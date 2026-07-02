# 中英文双语支持实施计划

## 目标
在文档中心增加中英文切换：英文首页 + 英文文档（由 `_Docs` 翻译而来），用同一个 `build_docs.sh` 构建，首页 toggle 在中英两套首页间互跳。**先试点 `softw_sp` 一个章节**，确认翻译质量与管线无误后，再批量翻译其余 29 篇。

## 架构
- **英文源码树** `_Docs_en/<section>/` 镜像 `_Docs/<section>/`：`docs/` 内放翻译后的 `.md` + 复制的图片/资源；`mkdocs.yml` 用英文 `site_name` + 英文 nav，并修正 plugins（含 `- search`）。
- **英文部署** `en/<section>/...`（由 `_Docs_en` 构建）。
- **首页** `index.html`（中，现有）+ `en/index.html`（英，新建）。顶部 toggle 按钮互跳。英文首页链接指向 `en/<section>/...`。
- **构建脚本** `build_docs.sh` 扩展为同时构建中文（`_Docs`→`<section>/`）和英文（`_Docs_en`→`en/<section>/`）。

## Phase A — 试点 softw_sp（先做，等你确认）
1. 建 `_Docs_en/softw_sp/`：复制 `_Docs/softw_sp/docs/`→`_Docs_en/softw_sp/docs/`（带图片/assets/logo）；写 `_Docs_en/softw_sp/mkdocs.yml`（site_name="Streaming Port Protocol"，nav 英文，`plugins: [search, mkdocs-video]`，相同 markdown_extensions，`extra.homepage: https://moretion.github.io/en/`）。
2. 用 1 个 workflow agent 翻译 `index.md`（带术语表 + WebSearch 校验；保留 JSON/代码块结构，只译中文叙述与注释）。
3. 扩展 `build_docs.sh` 支持英文（见 Phase C）。
4. 构建英文 softw_sp → `en/softw_sp/`，验证产物。
5. 新建 `en/index.html` + 给 `index.html` 加 EN toggle。
6. 把试点成果交你确认（翻译质量 / toggle / 构建）。

## Phase B — 批量翻译其余 29 篇（试点通过后）
- 对每个剩余章节建 `_Docs_en/<section>/`（复制 docs/ + 写英文 mkdocs.yml）。
- Workflow：**每篇 .md 一个 agent**（29 个），各自从 zh 读取、按共享术语表 + WebSearch 校验、写出 en .md。
- 翻译全部 19 个 mkdocs.yml 的 nav/site_name。
- 构建全部英文站点。

## Phase C — build_docs.sh 扩展
- 重构为按语言迭代：中文 `_Docs`→`<section>/`，英文 `_Docs_en`→`en/<section>/`。
- 复用 DEPLOY_NAME 映射（plugin_blender→blender 等对英文同样适用）。
- 加 `--lang zh|en|all`（默认 `all`）；`--only`/`--all`/`--dry-run` 对每种语言生效。
- 英文章节部署到 `en/` 下，首次构建自动建 `en/` 目录。
- 保留现有重试/备份/回滚安全机制。

## Phase D — 首页与 toggle
- `index.html`（中）：header 加 "EN" 按钮 → `en/index.html`。
- `en/index.html`：英文版首页，章节链接指向 `en/<section>/<page>/index.html`（相对路径），"中文" 按钮 → `../index.html`。
- 两套首页都保留 Vanta.js 背景。

## Phase E — 构建与验证
- 跑 `build_docs.sh`（中+英）；验证英文站点渲染、toggle 跳转、链接可达。
- 英文 mkdocs.yml 含 `- search`（顺带修了搜索缺失问题，仅英文侧；中文侧是否同步修可另议）。

## 翻译 agent 规范（每篇）
- 输入 zh .md 路径，输出 en .md 路径。
- 中文叙述译为专业英文；保留 markdown 结构、标题层级、图片/链接路径、front-matter。
- 代码块：保留代码/标识符/JSON 键不动；仅翻译其中的中文注释与字符串字面量。
- 按共享术语表保持一致；生疏专业词用 WebSearch 校验。
- 品牌/产品名保持原样（Moretion、Motion Studio、Z1/G1、Unity、Unreal、Maya、Blender、C4D、MotionBuilder、SteamVR 等）。

## 共享术语表（核心）
动作捕捉/动捕→motion capture；数据手套→data glove；动捕服/套装→motion capture suit；串流→streaming；串流端口协议→Streaming Port Protocol；随身网关→portable gateway；全息屏→holographic display；虚拟直播→virtual live streaming；运动康复→motion rehabilitation；具身智能→embodied intelligence；关节→joint；姿态→pose；根节点→root node；骨骼→skeleton；绑定→rigging；标定/校准→calibration；传感器→sensor；插件→plugin。（agent 可 WebSearch 校验/扩充）

## 范围说明
- 不含每个文档页内的语言切换（toggle 仅在首页，按你选的"两套首页互跳"）。后续可加。
- `_Docs_en` 与 `_Docs` 一样 untracked。
- 不自动提交，用 `git diff` 自行审阅。
- 规模：约 30 个翻译 agent（先 1 试点，通过后 29）。每篇读一个 .md + 少量 WebSearch + 写译文。

## 试点章节：softw_sp
理由：单页、技术性（串流协议）、含 JSON 代码块（检验代码保留）、full config、且为既有冒烟测试基线。试点通过后再批量。
