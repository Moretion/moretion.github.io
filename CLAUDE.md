# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The GitHub Pages site for **魔迅科技 (Moretion)** — a motion-capture / data-glove / VR product company.
Served raw as static HTML from `main` at `https://moretion.github.io/`. There is **no build CI and no
package manager** — GitHub Pages serves the committed files directly. The site is **bilingual**:
Chinese docs under `<section>/` and English docs under `en/<section>/`, each section an independent
MkDocs site. Commit messages are in **Chinese**; Chinese source lives in `_Docs/`, English source
(translated from Chinese) in `_Docs_en/`.

## Architecture: source vs. built output (read this first)

The repo holds **two parallel source→built pairs**, one per language, that must stay in sync:

| Language | Source tree | Built output (served) |
|----------|-------------|-----------------------|
| Chinese | `_Docs/<section>/`    | `<section>/`     |
| English | `_Docs_en/<section>/` | `en/<section>/`  |

Each `<section>` is an independent MkDocs project: `<src>/<section>/mkdocs.yml` +
`<src>/<section>/docs/` (the `.md` sources, images, and binary downloads like `.apk`, `.unitypackage`,
`.step`/`.fbx`, `.docx`, `.exe`). `_Docs_en/` mirrors `_Docs/` section-for-section; the English `.md` are
translations, images/assets are shared (copied). `_Docs/cmds.md` holds the canonical build/deploy workflow
and `_Docs/URLs.txt` has MkDocs reference links. The original Chinese source also lives on a company NAS
at `\\MoretionNAS\共享资料\MoretionDocs`. Generator string: `mkdocs-1.6.1, mkdocs-material-9.7.0`.

The built dirs are MkDocs `site/` output renamed to the section name: `404.html`, `sitemap.xml(.gz)`,
`assets/` (Material theme JS/CSS + `logo.png`), and one `<page-slug>/index.html` per nav page. **Search is
disabled** — there is no `search/search_index.json` and no search box.

**Do not hand-edit the built `index.html` files under section dirs.** Edit the `.md` source in
`_Docs/<section>/docs/` (Chinese) or `_Docs_en/<section>/docs/` (English) and rebuild. The only hand-written
HTML is the **landing pages**: root `index.html` (Chinese) and `en/index.html` (English) — both three.js +
Vanta.js "birds" animated backgrounds, NOT part of any MkDocs site. A toggle button in each header
(EN ↔ 中文) navigates between them; each landing's section links point to that language's built sites.

Each section is its **own** MkDocs site with its own `mkdocs.yml` — there is no unified nav. The two
landing pages are the manual hub linking them together.

## Build & deploy workflow

Documented in `_Docs/cmds.md`. Tools needed: `mkdocs`, `mkdocs-material`, `mkdocs-video`, `pandoc`
(`pip install mkdocs mkdocs-material mkdocs-video`). A pinned set is installed in the repo-local `.venv`
(mkdocs 1.6.1, mkdocs-material 9.7.0, mkdocs-video 1.5.0) — `build_docs.sh` auto-detects it; `.venv/` is
gitignored.

**Rebuilding is automated by `build_docs.sh`** (repo root). It builds **both languages**: Chinese
(`_Docs` → `<section>/`) and English (`_Docs_en` → `en/<section>/`). For each section it runs
`mkdocs build` into a temp dir, then backup → replace → rollback the matching deploy dir. It encodes the
3 source→deploy name exceptions (`plugin_blender→blender`, `plugin_c4d→c4d`, `plugin_maya→maya`), applied
to both languages.

```bash
bash build_docs.sh --dry-run                  # preview (no mkdocs needed)
bash build_docs.sh                            # rebuild & replace all already-deployed zh+en sections
bash build_docs.sh --lang zh                  # Chinese only
bash build_docs.sh --lang en --all            # build all English (first build needs --all or --only)
bash build_docs.sh --lang en --only softw_sp  # just these English source sections
bash build_docs.sh --only dev_z1,softw_sp     # both languages, just these sections
```

On Windows, `build_docs.cmd` is a wrapper that locates `bash.exe` (Git for Windows does **not** put `bash`
on PATH by default, only `git`) and forwards args to `build_docs.sh` — run it as `.\build_docs.cmd --dry-run`
from PowerShell or cmd (note the `.\` prefix).

By default it only replaces dirs that already exist (so half-baked sections like `ap_holo` aren't
accidentally published). It does **not** auto-commit — review `git status`/`git diff` after, then commit
and push; GitHub Pages deploys from `main` automatically. The script builds strictly from source, so any
file that exists only in a deployed dir (not in `_Docs`/`_Docs_en`) is lost on replace. The `rm`/`mv`
replace retries with backoff to work around Windows AV/indexer file-locking.

Manual one-off workflow (from `_Docs/cmds.md`): convert Word→MD with
`pandoc input.docx --extract-media=./images -o output.md`, scaffold with `mkdocs new`, edit
`mkdocs.yml` (`site_name`, `theme: material`, `nav:` for pagination), `mkdocs build` → `site/`,
`mkdocs serve` to preview, then rename `site/` to the section dir and copy into the repo root (or
`en/<section>/` for English).

## Output URL mapping (important when editing links)

MkDocs runs with `use_directory_urls: true`, so a nav page `foo.md` builds to `foo/index.html` *inside
the section dir*. Because section dirs are often named the same as their first page, paths double up —
e.g. `dev_z1.md` in section `dev_z1/` builds to **`dev_z1/dev_z1/index.html`** (there is no
`dev_z1/index.html`). Single-page sections whose page is the index build to `<section>/index.html`
(e.g. `softw_sp/index.html`). English pages mirror this under `en/`: `en/dev_z1/dev_z1/index.html`,
`en/softw_sp/index.html`, etc. The root `index.html` and `en/index.html` each deep-link the exact built
path for their language's sections, so **when you add/rename/reorder nav pages, update the `mkdocs.yml`
nav in both `_Docs` and `_Docs_en`, and the link in both landing pages.**

## MkDocs conventions (shared by all section configs)

- Theme: `material` with `content.code.copy`; `logo: assets/logo.png` (the same logo is shared across all sections).
- Plugins: **`mkdocs-video` only** — search is intentionally **disabled** (no `search` plugin, no search
  box, no `search_index.json`). Embed video with `![type:video](./assets/v0.mp4)`.
- Markdown extensions: `pymdownx.highlight` (line numbers), `inlinehilite`, `snippets`, `superfences`.
- `extra.homepage`: `https://moretion.github.io/` for Chinese configs, `https://moretion.github.io/en/`
  for English configs.
- English configs in `_Docs_en/` are standardized to the full pattern above. Chinese configs in `_Docs/`
  vary (some minimal); when creating a new section, mirror the `_Docs_en` pattern in both trees and
  translate the `site_name` + `nav` labels.
- Brand/product names stay as-is in both languages (Moretion, Motion Studio, Z1/G1/ML020W, Unity, Unreal,
  Maya, Blender, C4D, MotionBuilder, SteamVR, …). Keep Chinese→English terminology consistent — a shared
  glossary was used when the English docs were translated (e.g. 动捕→motion capture, 串流→streaming,
  数据手套→data glove, 宇树→Unitree, 傲意→AOYI/OHand).

## Conventions

- **Commits:** Conventional Commits with Chinese descriptions, scope = section dir. Examples from
  history: `docs: 更新…`, `feat(plugin_unity): …`, `fix(softw_sp): …`, `feat(g1): …`.
- **Images:** pandoc-extracted images land in `images_<page>/media/`. A past commit (`移除图片的尺寸属性`)
  established the rule: **strip explicit width/height attributes from images** in the Markdown.
- `Thumbs.db` (Windows) and `.docx` originals are sometimes committed alongside the built site — match
  surrounding practice per section rather than deleting them.
- GitHub org: `Moretion` (`https://github.com/Moretion`).
