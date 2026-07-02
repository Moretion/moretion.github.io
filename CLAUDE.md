# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The GitHub Pages site for **魔迅科技 (Moretion)** — a motion-capture / data-glove / VR product company.
Served raw as static HTML from `main` at `https://moretion.github.io/`. There is **no build CI and no
package manager** — GitHub Pages serves the committed files directly. The doc content and all commit
messages are in **Chinese**; match that when writing docs or commits.

## Architecture: source vs. built output (read this first)

The repo holds two parallel trees that must stay in sync:

1. **`_Docs/`** — the **source**. One subdirectory per product section, each an independent MkDocs project:
   `_Docs/<section>/mkdocs.yml` + `_Docs/<section>/docs/` (the `.md` sources, images, and binary
   downloads like `.apk`, `.unitypackage`, `.step`/`.fbx`, `.docx`, `.exe`). Also contains `_Docs/cmds.md`
   (the canonical build/deploy workflow), `_Docs/URLs.txt` (MkDocs reference links), and a draft
   `index.html`. **`_Docs/` is currently untracked in git** — check `git status` before assuming it is
   committed. The original/canonical copy also lives on a company NAS at `\\MoretionNAS\共享资料\MoretionDocs`.

2. **Top-level section dirs** (`dev_z1/`, `plugin_unity/`, `ap_vr/`, `softw_ms/`, …) — the **built
   output** served by GitHub Pages. Each is an MkDocs `site/` directory renamed to the section name:
   `404.html`, `sitemap.xml(.gz)`, `assets/` (Material theme JS/CSS + `logo.png`), `search/search_index.json`,
   and one `<page-slug>/index.html` per nav page. Generator string: `mkdocs-1.6.1, mkdocs-material-9.7.0`.

**Do not hand-edit the built `index.html` files under top-level section dirs.** Edit the `.md` source in
`_Docs/<section>/docs/` and rebuild. The only hand-written HTML is the **root `index.html`** landing page
(three.js + Vanta.js "birds" animated background) — it is NOT part of any MkDocs site; it just links into
each section.

Each section is its **own** MkDocs site with its own `mkdocs.yml` — there is no unified nav. The root
`index.html` is the manual hub that links them together.

## Build & deploy workflow

Documented in `_Docs/cmds.md`. Tools needed: `mkdocs`, `mkdocs-material`, `mkdocs-video`, `pandoc`
(`pip install mkdocs mkdocs-material mkdocs-video`).

**Rebuilding all sections is automated by `build_docs.sh`** (repo root). For each `_Docs/<section>/`
with a `mkdocs.yml`, it runs `mkdocs build` into a temp dir, then backup → replace → rollback the
matching deploy dir at the repo root. It encodes the 3 source→deploy name exceptions
(`plugin_blender→blender`, `plugin_c4d→c4d`, `plugin_maya→maya`); every other section deploys to a dir
named the same as its source.

```bash
bash build_docs.sh --dry-run                 # preview (no mkdocs needed)
bash build_docs.sh                           # rebuild & replace all already-deployed sections
bash build_docs.sh --all                     # also create sections not yet deployed (e.g. ap_holo)
bash build_docs.sh --only dev_z1,softw_sp    # just these source sections
```

By default it only replaces dirs that already exist at the repo root (so half-baked sections like
`ap_holo` aren't accidentally published). It does **not** auto-commit — review `git status`/`git diff`
after, then commit and push; GitHub Pages deploys from `main` automatically. The script builds strictly
from `_Docs`, so any file that exists only in a deployed dir (not in source) is lost on replace.

Manual one-off workflow (from `_Docs/cmds.md`): convert Word→MD with
`pandoc input.docx --extract-media=./images -o output.md`, scaffold with `mkdocs new`, edit
`mkdocs.yml` (`site_name`, `theme: material`, `nav:` for pagination), `mkdocs build` → `site/`,
`mkdocs serve` to preview, then rename `site/` to the section dir and copy into the repo root.

## Output URL mapping (important when editing links)

MkDocs runs with `use_directory_urls: true`, so a nav page `foo.md` builds to `foo/index.html` *inside
the section dir*. Because section dirs are often named the same as their first page, paths double up —
e.g. `dev_z1.md` in section `dev_z1/` builds to **`dev_z1/dev_z1/index.html`** (there is no
`dev_z1/index.html`). Single-page sections whose page is the index build to `<section>/index.html`
(e.g. `softw_sp/index.html`). The root `index.html` deep-links the exact built path for each section, so
**when you add/rename/reorder nav pages, update both the section's `mkdocs.yml` nav and the root
`index.html` link.**

## MkDocs conventions (shared by all section configs)

- Theme: `material` with `content.code.copy`; `logo: assets/logo.png`.
- Plugin: `mkdocs-video` — embed video with `![type:video](./assets/v0.mp4)`.
- Markdown extensions: `pymdownx.highlight` (line numbers), `inlinehilite`, `snippets`, `superfences`.
- `extra.homepage: https://moretion.github.io/`.
- Section `mkdocs.yml` files in `_Docs/` vary slightly (some have minimal nav); prefer the fuller config
  pattern above when creating new sections.

## Conventions

- **Commits:** Conventional Commits with Chinese descriptions, scope = section dir. Examples from
  history: `docs: 更新…`, `feat(plugin_unity): …`, `fix(softw_sp): …`, `feat(g1): …`.
- **Images:** pandoc-extracted images land in `images_<page>/media/`. A past commit (`移除图片的尺寸属性`)
  established the rule: **strip explicit width/height attributes from images** in the Markdown.
- `Thumbs.db` (Windows) and `.docx` originals are sometimes committed alongside the built site — match
  surrounding practice per section rather than deleting them.
- GitHub org: `Moretion` (`https://github.com/Moretion`).
