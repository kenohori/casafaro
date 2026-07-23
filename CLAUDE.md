# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

The marketing website for Casa Faro (casafaro.mx), a Jekyll static site. There is no
application code, build tooling, package.json, or test suite — this repo is Jekyll
templates/content plus static assets.

## Commands

No Gemfile is committed; Jekyll (4.4.1) is expected to be available globally (e.g. via
rbenv) rather than through Bundler.

- Serve locally with live rebuild: `jekyll serve`
- One-off build to `_site/`: `jekyll build`

There is no lint or test command in this repo.

## Architecture

- `_config.yml` — site-wide settings (title, url, description). `baseurl` is empty (site
  is served from the domain root).
- `_layouts/default.html` — the single layout used by every page. Renders the Bootstrap
  navbar (with in-page anchor links to `#ourwork`, `#about`, `#contact` on the home page),
  wraps `{{ content }}` in a `.container`, and includes `_includes/head.html` /
  `_includes/footer.html`.
- `_includes/head.html` — loads Bootstrap 5 and Font Awesome from CDNs, `freezeframe.js`
  (used to freeze animated GIFs until hovered, via the `.gif-freeze` class), and the local
  `css/casafaro.css`.
- Content pages are Markdown files with `layout: default` front matter:
  - `index.md` — the real, current home page (hero, "¿Qué hacemos?", team bios, contact),
    with section anchors matching the navbar links.
  - `about/index.md`, `ourwork/index.md` — separate routes for `/about` and `/ourwork`.
    **Known issue:** these still contain placeholder/Lorem-ipsum copy and reference image
    files that don't exist in `img/` (e.g. `Foto FEG.jpeg`, `teamwork_17850287.gif`). The
    up-to-date version of this same content lives in `index.md` instead. Don't treat
    `about/`/`ourwork/` as the source of truth without checking with the user first.
  - `contact/index.md` — currently just a heading, no content.
- `css/casafaro.css` — small stylesheet: `@font-face` declarations for the "Host Grotesk"
  variable font family (files in `fonts/`), plus a couple of custom rules (e.g. `.rojocf`
  for the brand red `#FF303F`).
- `img/` — SVG icons/logos and team photos referenced by the content pages.
- Language: page content is in Spanish (`<html lang="es">`).
