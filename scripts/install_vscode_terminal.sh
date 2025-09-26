#!/usr/bin/env bash
set -euo pipefail

log() { printf '[INFO] %s\n' "$1"; }
err() { printf '[ERROR] %s\n' "$1" >&2; }

ensure_vscode_mac() {
  local app_path="/Applications/Visual Studio Code.app"
  local cli_path="$app_path/Contents/Resources/app/bin/code"

  if [[ ! -d "$app_path" ]]; then
    err "Visual Studio Code is not installed in $app_path"
    err "Download it from https://code.visualstudio.com/ and retry."
    exit 1
  fi

  log "Creating symlink for 'code' command under /usr/local/bin"
  sudo mkdir -p /usr/local/bin
  sudo ln -sf "$cli_path" /usr/local/bin/code

  ensure_path_entry "/usr/local/bin"
}

ensure_vscode_linux() {
  if command -v code >/dev/null 2>&1; then
    log "'code' command already available."
    return
  fi

  local candidates=(
    "/usr/share/code/bin/code"
    "/var/lib/snapd/snap/bin/code"
    "$HOME/.vscode-server/bin/code"
  )

  for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      log "Linking $candidate to /usr/local/bin/code"
      sudo mkdir -p /usr/local/bin
      sudo ln -sf "$candidate" /usr/local/bin/code
      return
    fi
  done

  err "Unable to locate the VS Code executable."
  err "Install VS Code via https://code.visualstudio.com/ and rerun this script."
  exit 1
}

ensure_path_entry() {
  local target="$1"
  local shell_profile=""

  if [[ ${SHELL:-} == *"zsh"* ]]; then
    shell_profile="$HOME/.zshrc"
  elif [[ ${SHELL:-} == *"bash"* ]]; then
    shell_profile="$HOME/.bash_profile"
    [[ -f "$HOME/.bashrc" ]] && shell_profile="$HOME/.bashrc"
  fi

  [[ -z "$shell_profile" || ! -f "$shell_profile" ]] && return
  grep -q "$target" "$shell_profile" && return

  log "Adding $target to PATH via $shell_profile"
  echo "export PATH=\"$target:\$PATH\"" >>"$shell_profile"
}

main() {
  log "Configuring VS Code command line integration..."

  case "$(uname -s)" in
    Darwin)
      ensure_vscode_mac
      ;;
    Linux)
      ensure_vscode_linux
      ;;
    *)
      err "Unsupported OS: $(uname -s). Only macOS and Linux are supported."
      exit 1
      ;;
  esac

  if command -v code >/dev/null 2>&1; then
    log "Success! Try 'code .' to open the current folder in VS Code."
  else
    err "The 'code' command is still unavailable. Run your shell's startup script or restart the terminal."
    exit 1
  fi
}

main "$@"
