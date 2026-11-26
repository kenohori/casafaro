#!/usr/bin/env bash
#
# Deploy the CasaFaro Jekyll site to casafaro.mx.
#
# Builds the site into a temporary directory, verifies the build, mirrors it to
# the casafaro.mx document root over SSH, and checks the published URLs.
#
# The target host also serves other sites (ken.mx, git.ken.mx, ...), so this
# script is deliberately scoped to /var/www/casafaro and refuses to touch
# anything else. rsync runs with --delete inside that directory only, which
# means the remote document root is an exact mirror of the local build.
#
# Usage:
#   bin/deploy.sh                 # build, show changes, ask for confirmation
#   bin/deploy.sh --yes           # build and deploy without prompting
#   bin/deploy.sh --dry-run       # build and show what would change, don't deploy
#   bin/deploy.sh --no-build      # reuse the last _site/ build
#   bin/deploy.sh --allow-dirty   # deploy even with uncommitted changes
#
# Requires: git, jekyll (or bundle), rsync, ssh, curl.

set -euo pipefail

readonly REMOTE_HOST="root@casafaro.mx"
readonly REMOTE_DIR="/var/www/casafaro"
readonly SITE_URL="https://casafaro.mx"
readonly SSH_OPTS=(-o ConnectTimeout=15 -o ServerAliveInterval=15)
readonly HEALTH_PATHS=("/" "/about/" "/ourwork/" "/contact/" "/recursos/" "/recursos/proqol5/")

DRY_RUN=0
ASSUME_YES=0
SKIP_BUILD=0
ALLOW_DIRTY=0

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }
die()   { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

usage() {
    cat <<'EOF'
Usage:
  bin/deploy.sh                 build, show changes, ask for confirmation
  bin/deploy.sh --yes           build and deploy without prompting
  bin/deploy.sh --dry-run       build and show what would change, don't deploy
  bin/deploy.sh --no-build      reuse the last _site/ build
  bin/deploy.sh --allow-dirty   deploy even with uncommitted changes
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)     DRY_RUN=1 ;;
        --yes|-y)      ASSUME_YES=1 ;;
        --no-build)    SKIP_BUILD=1 ;;
        --allow-dirty) ALLOW_DIRTY=1 ;;
        -h|--help)     usage ;;
        *)             die "unknown option: $1 (try --help)" ;;
    esac
    shift
done

# --- Locate the repository -------------------------------------------------

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
[[ -n "$REPO_ROOT" ]] || die "not inside a git repository"
cd "$REPO_ROOT"

# --- Safety checks on the deploy target ------------------------------------

[[ "$REMOTE_DIR" == /var/www/* && "$REMOTE_DIR" == */casafaro ]] \
    || die "refusing to deploy to unexpected path: $REMOTE_DIR"

for cmd in rsync ssh curl git; do
    command -v "$cmd" >/dev/null || die "missing required command: $cmd"
done

if command -v shasum >/dev/null; then
    HASH_CMD=(shasum -a 256)
elif command -v sha256sum >/dev/null; then
    HASH_CMD=(sha256sum)
else
    die "missing required command: shasum or sha256sum"
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
[[ "$BRANCH" == "main" ]] || warn "deploying from branch '$BRANCH', not 'main'"

# --- Working tree check -----------------------------------------------------

if [[ -n "$(git status --porcelain)" ]]; then
    if [[ $ALLOW_DIRTY -eq 0 ]]; then
        git status --short
        die "working tree is not clean; commit/stash your changes or pass --allow-dirty"
    fi
    warn "deploying with uncommitted changes:"
    git status --short | sed 's/^/    /' >&2
fi

# --- Build ------------------------------------------------------------------

if [[ $SKIP_BUILD -eq 1 ]]; then
    BUILD_DIR="$REPO_ROOT/_site"
    [[ -f "$BUILD_DIR/index.html" ]] || die "--no-build given but $BUILD_DIR/index.html does not exist"
    info "Using existing build in $BUILD_DIR"
else
    BUILD_DIR="$(mktemp -d "${TMPDIR:-/tmp}/casafaro-build.XXXXXX")"
    chmod 755 "$BUILD_DIR"   # mktemp creates 0700; nginx must be able to read it
    trap 'rm -rf "$BUILD_DIR"' EXIT

    if [[ -f Gemfile ]]; then
        info "Building with bundle exec jekyll"
        bundle exec jekyll build --destination "$BUILD_DIR"
    else
        info "Building with jekyll"
        jekyll build --destination "$BUILD_DIR"
    fi
fi

# --- Verify the build -------------------------------------------------------

[[ -s "$BUILD_DIR/index.html" ]] || die "build is missing index.html"
grep -q "CasaFaro" "$BUILD_DIR/index.html" || die "index.html does not look like the CasaFaro site"
[[ -d "$BUILD_DIR/recursos/proqol5" ]] || die "build is missing recursos/proqol5/"

file_count="$(find "$BUILD_DIR" -type f | wc -l | tr -d ' ')"
[[ "$file_count" -ge 20 ]] || die "build only contains $file_count files; something went wrong"
info "Build OK: $file_count files, $(du -sh "$BUILD_DIR" | cut -f1)"

# --- Verify the remote target ----------------------------------------------

info "Checking $REMOTE_HOST:$REMOTE_DIR"
remote_real="$(ssh "${SSH_OPTS[@]}" "$REMOTE_HOST" "readlink -f '$REMOTE_DIR'")" \
    || die "cannot connect to $REMOTE_HOST"
[[ "$remote_real" == "$REMOTE_DIR" ]] || die "remote path resolved to '$remote_real', expected '$REMOTE_DIR'"
ssh "${SSH_OPTS[@]}" "$REMOTE_HOST" \
    "test -d '$REMOTE_DIR' && test ! -L '$REMOTE_DIR' && test -f '$REMOTE_DIR/index.html'" \
    || die "$REMOTE_DIR is not a directory containing index.html; refusing to deploy"
info "Remote target OK"

# --- Mirror the build -------------------------------------------------------

RSYNC_OPTS=(
    -az
    --delete
    --delay-updates
    --itemize-changes
    --human-readable
    --exclude=.DS_Store
    --exclude=._*
    --exclude=.well-known/
    -e "ssh ${SSH_OPTS[*]}"
)

info "Changes to apply:"
rsync "${RSYNC_OPTS[@]}" --dry-run "$BUILD_DIR"/ "$REMOTE_HOST:$REMOTE_DIR/" \
    | sed 's/^/    /'

if [[ $DRY_RUN -eq 1 ]]; then
    info "Dry run: nothing was deployed"
    exit 0
fi

if [[ $ASSUME_YES -eq 0 ]]; then
    printf '\nDeploy these changes to %s:%s? [y/N] ' "$REMOTE_HOST" "$REMOTE_DIR"
    read -r answer
    [[ "$answer" =~ ^[Yy]$ ]] || { info "Aborted"; exit 1; }
fi

info "Deploying"
rsync "${RSYNC_OPTS[@]}" --out-format='%n' "$BUILD_DIR"/ "$REMOTE_HOST:$REMOTE_DIR/" \
    | sed 's/^/    /'

# rsync -a preserves the build directory's ownership/permissions, which are a
# local uid and mode 700 for the mktemp root. Normalize so nginx (www-data) can
# read everything. Scoped to REMOTE_DIR only.
info "Normalizing ownership and permissions"
ssh "${SSH_OPTS[@]}" "$REMOTE_HOST" \
    "chown -R root:root '$REMOTE_DIR' && find '$REMOTE_DIR' -type d -exec chmod 755 {} + && find '$REMOTE_DIR' -type f -exec chmod 644 {} +"

# --- Verify the deployment --------------------------------------------------

info "Verifying deployed files"
for file in index.html recursos/proqol5/index.html css/casafaro.css; do
    local_hash="$("${HASH_CMD[@]}" "$BUILD_DIR/$file" | cut -d' ' -f1)"
    remote_hash="$(ssh "${SSH_OPTS[@]}" "$REMOTE_HOST" "sha256sum '$REMOTE_DIR/$file'" | cut -d' ' -f1)"
    [[ "$local_hash" == "$remote_hash" ]] || die "hash mismatch for $file"
    printf '    %s OK\n' "$file"
done

local_files="$(find "$BUILD_DIR" -type f ! -name '.DS_Store' ! -name '._*' ! -path '*/.well-known/*' | wc -l | tr -d ' ')"
remote_files="$(ssh "${SSH_OPTS[@]}" "$REMOTE_HOST" \
    "find '$REMOTE_DIR' -type f ! -name '.DS_Store' ! -name '._*' ! -path '$REMOTE_DIR/.well-known/*' | wc -l" | tr -d ' ')"
[[ "$local_files" == "$remote_files" ]] \
    || die "remote file count ($remote_files) does not match build ($local_files)"
printf '    file count OK (%s files)\n' "$local_files"

info "Checking published URLs"
for path in "${HEALTH_PATHS[@]}"; do
    status="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 "$SITE_URL$path")" \
        || die "request failed: $SITE_URL$path"
    [[ "$status" == "200" ]] || die "$SITE_URL$path returned HTTP $status"
    printf '    %s %s\n' "$status" "$path"
done

info "Deployment complete: $SITE_URL"
info "Rollback: check out the previous commit and run bin/deploy.sh again"
