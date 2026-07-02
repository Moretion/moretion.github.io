#!/usr/bin/env bash
#
# build_docs.sh
# 用 mkdocs 把 _Docs/<section>/ 下的 markdown 源码构建为静态站点，
# 再用生成的 site 目录替换项目主目录下对应的旧站点目录。
#
# 仓库结构（重要）：
#   _Docs/<section>/mkdocs.yml + docs/   <- 源码（唯一真相来源）
#   <section>/                            <- mkdocs 构建产物，由本脚本生成/替换
# 多数章节源目录名与部署目录名相同；例外见下方 DEPLOY_NAME。
#
# 依赖：mkdocs、mkdocs-material、mkdocs-video
#   pip install mkdocs mkdocs-material mkdocs-video
#
# 用法：
#   ./build_docs.sh                    重建所有已部署章节（替换旧目录）
#   ./build_docs.sh --all              同时构建尚未部署的新章节（如 ap_holo）
#   ./build_docs.sh --only dev_z1,softw_sp   只构建指定源目录（逗号分隔；无视是否已部署）
#   ./build_docs.sh --dry-run          只打印计划，不构建/替换
#   ./build_docs.sh --help
#
# 注意：脚本严格按 _Docs 源码构建，会"删除并替换"旧目录——
#       旧目录中任何不在源码里的文件都会丢失。请确保源码完整后再运行。

set -o pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/_Docs"

# 源目录名 -> 部署目录名（只列与源目录名不同的；其余同名）
declare -A DEPLOY_NAME=(
  [plugin_blender]=blender
  [plugin_c4d]=c4d
  [plugin_maya]=maya
)

DRY_RUN=0
ALL=0
ONLY=()

usage() {
  sed -n '3,/^$/p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

while [ $# -gt 0 ]; do
  case "$1" in
    --all)      ALL=1; shift;;
    --dry-run)  DRY_RUN=1; shift;;
    --only)     ONLY=(${2//,/ }); shift 2;;
    --help|-h)  usage; exit 0;;
    *) echo "未知参数: $1" >&2; usage >&2; exit 2;;
  esac
done

# 只有真正构建时才需要 mkdocs（--dry-run / --help 不需要）
# 优先用 PATH 上的 mkdocs；找不到则回退到仓库内 .venv（Windows: .venv/Scripts，Unix: .venv/bin）
MKDOCS=""
if [ $DRY_RUN -eq 0 ]; then
  if command -v mkdocs >/dev/null 2>&1; then
    MKDOCS=mkdocs
  elif [ -f "$ROOT/.venv/Scripts/mkdocs.exe" ]; then
    MKDOCS="$ROOT/.venv/Scripts/mkdocs.exe"
  elif [ -f "$ROOT/.venv/bin/mkdocs" ]; then
    MKDOCS="$ROOT/.venv/bin/mkdocs"
  else
    echo "错误: 未找到 mkdocs。请安装: pip install mkdocs mkdocs-material mkdocs-video（也可装到仓库 .venv）" >&2
    exit 1
  fi
fi

# 收集所有源章节：_Docs 下含 mkdocs.yml 的子目录
all_sections=()
for d in "$SRC"/*/; do
  [ -f "$d/mkdocs.yml" ] && all_sections+=("$(basename "$d")")
done

# 按 --only 过滤
sections=()
if [ ${#ONLY[@]} -gt 0 ]; then
  for s in "${ONLY[@]}"; do
    if [ -f "$SRC/$s/mkdocs.yml" ]; then
      sections+=("$s")
    else
      echo "警告: 跳过 $s（不存在 _Docs/$s/mkdocs.yml）" >&2
    fi
  done
else
  sections=("${all_sections[@]}")
fi

deploy_name() { echo "${DEPLOY_NAME[$1]:-$1}"; }

# 临时构建目录放在仓库内，避免 Windows 跨盘符移动
TMP="$ROOT/.~mkdocs_build.$$"
rm -rf "$TMP"; mkdir -p "$TMP"
trap 'rm -rf "$TMP"' EXIT

# 重试：Windows 上杀软/索引器可能短暂锁住刚生成的文件，导致 rm/mv 偶发 permission denied。
# 先立即试一次，失败则按递增间隔重试。
retry() {
  local delays=(0.3 0.5 1 1 2 3 3) d
  "$@" && return 0
  for d in "${delays[@]}"; do sleep "$d"; "$@" && return 0; done
  return 1
}

ok=0; fail=0; skip=0; plan=0
printf "%-22s -> %-22s %s\n" "源目录" "部署目录" "结果"
printf -- "------------------------------------------------------------\n"

for s in "${sections[@]}"; do
  cfg="$SRC/$s/mkdocs.yml"
  dst="$(deploy_name "$s")"
  target="$ROOT/$dst"
  out="$TMP/$dst"
  err="$TMP/$s.err"

  # 默认跳过尚未部署的章节（--all 或 --only 除外）
  if [ ${#ONLY[@]} -eq 0 ] && [ $ALL -eq 0 ] && [ ! -d "$target" ]; then
    printf "%-22s -> %-22s %s\n" "$s" "$dst" "跳过（新章节，用 --all 创建）"
    skip=$((skip+1)); continue
  fi

  if [ $DRY_RUN -eq 1 ]; then
    [ -d "$target" ] && r="将替换" || r="将新建"
    printf "%-22s -> %-22s %s\n" "$s" "$dst" "DRY-RUN: $r"
    plan=$((plan+1)); continue
  fi

  if "$MKDOCS" build -f "$cfg" -d "$out" 2>"$err"; then
    # 备份旧目录 → 移入新目录 → 成功删备份 / 失败回滚（rm/mv 加重试以应对 Windows 文件锁）
    had_old=0
    if [ -d "$target" ]; then
      had_old=1
      retry rm -rf "$target.old"
      if ! retry mv "$target" "$target.old"; then
        echo "错误: 备份 $target 失败（文件被占用？请关闭可能打开该目录的程序后重试）" >&2
        fail=$((fail+1)); continue
      fi
    fi
    if retry mv "$out" "$target"; then
      retry rm -rf "$target.old"
      tag="OK"; [ $had_old -eq 0 ] && tag="OK（新建）"
      if grep -qiE 'warning|error' "$err"; then
        printf "%-22s -> %-22s %s（有警告）\n" "$s" "$dst" "$tag"
        sed 's/^/      /' "$err"
      else
        printf "%-22s -> %-22s %s\n" "$s" "$dst" "$tag"
      fi
      ok=$((ok+1))
    else
      echo "错误: 移动构建产物 $out -> $target 失败（文件被占用？请关闭可能打开该目录的程序后重试）" >&2
      [ $had_old -eq 1 ] && retry mv "$target.old" "$target"
      fail=$((fail+1))
    fi
  else
    printf "%-22s -> %-22s %s\n" "$s" "$dst" "失败"
    sed 's/^/      /' "$err" >&2
    fail=$((fail+1))
  fi
done

echo "------------------------------------------------------------"
if [ $DRY_RUN -eq 1 ]; then
  echo "DRY-RUN：共计划处理 $plan 个章节（未实际改动）"
else
  echo "成功 $ok / 失败 $fail / 跳过 $skip"
  [ $fail -eq 0 ] && echo "完成。可用 git status 查看变更，确认后提交。"
fi
[ $fail -eq 0 ]
