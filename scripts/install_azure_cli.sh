#!/usr/bin/env bash
set -euo pipefail

FORCE=false

usage() {
  cat <<USAGE
Usage: $(basename "$0") [--force]

Installs or upgrades the Azure CLI on macOS or Linux.
  --force   Reinstall/upgrade even if Azure CLI is already present.
USAGE
}

log() { printf '[INFO] %s\n' "$1"; }
err() { printf '[ERROR] %s\n' "$1" >&2; }

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --force)
        FORCE=true
        shift
        ;;
      --help|-h)
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

install_mac() {
  if ! command -v brew >/dev/null 2>&1; then
    err "Homebrew is required. Install it from https://brew.sh/ and rerun."
    exit 1
  fi

  if brew list azure-cli >/dev/null 2>&1; then
    log "azure-cli already installed via Homebrew. Running brew upgrade."
    brew upgrade azure-cli || log "brew upgrade returned non-zero. Continuing."
  else
    log "Installing azure-cli via Homebrew."
    brew install azure-cli
  fi
}

install_linux() {
  if [[ -f /etc/debian_version ]]; then
    log "Running Microsoft install script for Debian/Ubuntu."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  elif [[ -f /etc/redhat-release ]]; then
    log "Running Microsoft install script for RHEL/CentOS/Fedora."
    curl -sL https://aka.ms/InstallAzureCLIRpm | sudo bash
  else
    err "Unsupported Linux distribution. Follow manual instructions: https://learn.microsoft.com/cli/azure/install-azure-cli"
    exit 1
  fi
}

verify_install() {
  if ! command -v az >/dev/null 2>&1; then
    err "Azure CLI not detected after installation."
    exit 1
  fi

  log "Installed Azure CLI version: $(az version --query azure-cli --output tsv 2>/dev/null || az --version | head -n 1)"
}

main() {
  parse_args "$@"

  if command -v az >/dev/null 2>&1 && [[ $FORCE == false ]]; then
    log "Azure CLI already installed. Use --force to reinstall or upgrade."
    return
  fi

  case "$(uname -s)" in
    Darwin)
      install_mac
      ;;
    Linux)
      if ! command -v curl >/dev/null 2>&1; then
        err "curl is required to fetch the installer."
        exit 1
      fi
      install_linux
      ;;
    *)
      err "Unsupported OS: $(uname -s)."
      exit 1
      ;;
  esac

  verify_install
  log "Azure CLI installation complete. Run 'az login' to authenticate."
}

main "$@"
