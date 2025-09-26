#!/usr/bin/env bash
set -euo pipefail

FORCE=false
ORG=""
PROJECT=""

usage() {
  cat <<USAGE
Usage: $(basename "$0") [options]

Installs the Azure DevOps extension for the Azure CLI and optionally sets defaults.

Options:
  --organization <url>   Default Azure DevOps organization URL (e.g. https://dev.azure.com/contoso)
  --project <name>       Default project name to use with az devops commands
  --force                Reinstall/upgrade the extension even if present
  -h, --help             Show this help message
USAGE
}

log() { printf '[INFO] %s\n' "$1"; }
err() { printf '[ERROR] %s\n' "$1" >&2; }

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --organization)
        ORG="$2"
        shift 2
        ;;
      --project)
        PROJECT="$2"
        shift 2
        ;;
      --force)
        FORCE=true
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        err "Unknown argument: $1"
        usage
        exit 1
        ;;
    esac
  done
}

ensure_cli() {
  if ! command -v az >/dev/null 2>&1; then
    err "Azure CLI not found. Run scripts/install_azure_cli.sh first."
    exit 1
  fi
}

install_extension() {
  if az extension show --name azure-devops >/dev/null 2>&1; then
    if [[ $FORCE == true ]]; then
      log "Updating existing azure-devops extension."
      az extension update --name azure-devops >/dev/null
    else
      log "azure-devops extension already installed."
    fi
  else
    log "Installing azure-devops extension."
    az extension add --name azure-devops >/dev/null
  fi
}

configure_defaults() {
  local args=()
  [[ -n "$ORG" ]] && args+=("organization=$ORG")
  [[ -n "$PROJECT" ]] && args+=("project=$PROJECT")
  [[ ${#args[@]} -eq 0 ]] && return

  log "Setting default Azure DevOps values: ${args[*]}"
  az devops configure --defaults "${args[@]}"
}

main() {
  parse_args "$@"
  ensure_cli
  install_extension
  configure_defaults
  log "Azure DevOps CLI extension ready. Use 'az devops login' or 'az login' if not authenticated."
}

main "$@"
