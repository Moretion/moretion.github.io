# 魔迅科技文档中心 (Moretion Documentation Center)

Moretion（魔迅科技）官方文档站点，托管于 GitHub Pages：<https://moretion.github.io/>

支持**中英文双语**：中文站点在根目录，英文站点在 `en/`，首页右上角 **EN / 中文** 按钮可切换。

## 站点地图

每个条目后为部署目录名（线上 URL 路径）。

### 硬件
- Z1/Z1 Pro 开发指南 — `dev_z1`
- G1/G1 Pro 开发指南 — `dev_g1`
- ML020W 开发指南 — `dev_ml`
- 随身网关（待补）
- G2 / Z2 开发指南（待补）

### 动捕软件
- Motion Studio — `softw_ms`
- 串流端口协议 — `softw_sp`
- 移动端版本 Beta（待补）

### 插件
- C++ SDK — `plugin_cpp`
- Unity 插件 — `plugin_unity`
- Unreal Engine 插件 — `plugin_ue`
- MotionBuilder 插件 — `plugin_mb`
- Maya 插件 — 源 `plugin_maya` → 部署 `maya`
- Blender 插件 — 源 `plugin_blender` → 部署 `blender`
- C4D 插件 — 源 `plugin_c4d` → 部署 `c4d`
- iClone8 插件（待补）

### 行业应用
- 机器人 — `ap_robot`
- 全息屏 — `ap_holo`（待发布）
- 虚拟现实 — `ap_vr`
- 虚拟直播 — `ap_vls`
- 运动康复 — `ap_er`

### 其他
- 示例模型 — `others_model`
- 3D 打印件 — `others_3d_printing`

## 仓库结构

| | 中文 | 英文 |
|---|---|---|
| 源码（mkdocs） | `_Docs/<section>/` | `_Docs_en/<section>/` |
| 构建产物（线上） | `<section>/` | `en/<section>/` |

- 每个章节是独立的 mkdocs 站点：`mkdocs.yml` + `docs/*.md` + 图片/二进制资源。
- 线上目录由 `build_docs.sh` 从源码生成，**不要手改**——改源码后重建。
- 根 `index.html`（中）与 `en/index.html`（英）是手写首页（three.js + Vanta.js 动画），非 mkdocs 产物。
- `_Docs_en` 镜像 `_Docs`，英文 `.md` 是中文的翻译，图片/资源共用（复制）。

## 日常维护

### 环境准备（一次性）

```bash
pip install mkdocs mkdocs-material mkdocs-video
# 也可装到仓库内 .venv，build_docs.sh 会自动识别（.venv 已在 .gitignore）
```

版本建议与线上一致：`mkdocs 1.6.1`、`mkdocs-material 9.7.0`、`mkdocs-video 1.5.0`。

### 修改一篇文档

1. 编辑中文源码：`_Docs/<section>/docs/xxx.md`
2. 同步翻译英文：`_Docs_en/<section>/docs/xxx.md`
3. 重建该章节（中英都会重建）：
   ```bash
   bash build_docs.sh --only <section>
   ```
4. 本地预览：仓库目录下 `python -m http.server 8000`，浏览器开 `http://localhost:8000/`
5. 满意后 [发布上线](#发布上线)

### 新增一个章节

1. 在 `_Docs/` 与 `_Docs_en/` 各建 `<section>/`，含 `mkdocs.yml` + `docs/<page>.md` + 资源（参考现有章节如 `softw_sp`）。`mkdocs.yml` 模板：
   ```yaml
   site_name: <站点名>
   nav:
     - <页面标题>: <page>.md
   theme:
     name: material
     features: [content.code.copy]
     logo: assets/logo.png
   plugins:
     - mkdocs-video          # 不加 search，搜索已禁用
   markdown_extensions:
     - pymdownx.highlight: { anchor_linenums: true, line_spans: __span, pygments_lang_class: true }
     - pymdownx.inlinehilite
     - pymdownx.snippets
     - pymdownx.superfences
   extra:
     homepage: https://moretion.github.io/      # 英文用 .../en/
   ```
2. 首次构建（新章节需 `--all`）：
   ```bash
   bash build_docs.sh --all --only <section>
   ```
3. 在根 `index.html` 与 `en/index.html` 各加一条链接，指向 `<section>/<page>/index.html`
4. [发布上线](#发布上线)

### 构建脚本用法

```bash
bash build_docs.sh --dry-run                  # 预览（不实际构建）
bash build_docs.sh                            # 重建所有已部署章节（中+英）
bash build_docs.sh --lang zh                  # 只构建中文
bash build_docs.sh --lang en --all            # 构建全部英文
bash build_docs.sh --lang en --only softw_sp  # 只构建指定英文章节
bash build_docs.sh --only dev_z1,softw_sp     # 中+英，只构建指定章节
```

**Windows** PowerShell / cmd 用 `.\build_docs.cmd ...`（自动定位 `bash.exe`，无需手动配 PATH）。

> 脚本会**删除并替换**线上目录，严格以源码为准——源码里没有的文件会被清掉。改前可先 `--dry-run` 看看会动哪些目录。替换时带重试，能绕过杀软/索引器的文件锁。

### 发布上线

```bash
git add -A
git commit -m "docs: <说明>"
git push origin main
```

GitHub Pages 自动从 `main` 构建部署，几分钟后生效。

### 注意事项

- **搜索已禁用**：mkdocs 配置只保留 `mkdocs-video` 插件，不放搜索框、不生成 `search_index.json`。
- **品牌名保持原样**：Z1 / G1 / ML020W / Motion Studio / Unity / Unreal / Maya / Blender / C4D / MotionBuilder / SteamVR 等，中英文都不翻译。
- **术语一致**：英文翻译沿用统一术语表——动捕→motion capture、串流→streaming、数据手套→data glove、随身网关→portable gateway、虚拟直播→virtual live streaming、具身智能→embodied intelligence、宇树→Unitree、傲意→AOYI（产品 OHand）等。
- **改名映射**：`plugin_blender→blender`、`plugin_c4d→c4d`、`plugin_maya→maya`（源目录名 ≠ 部署目录名，脚本已内置处理）。
- **大文件**：`others_model` 里有几个 >50MB 的 3D 模型（`.fbx` / `.tif`），GitHub 会警告但 <100MB 仍可推送；若涨过 100MB 需改用 Git LFS 或外链存储。
- **图片**：pandoc 抽取的图片在 `images_<page>/media/`；约定**去掉图片的宽高属性**。

## 更多

- 构建/部署原始流程笔记：`_Docs/cmds.md`
- 给 Claude Code 的工作指引：`CLAUDE.md`
- GitHub 组织：<https://github.com/Moretion>
