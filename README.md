# Dotfiles

This repository contains personal configuration for tools like Fish, tmux, Neovim, LazyGit, and more. Each directory under the repo mirrors the structure expected inside `~/.config`, and the helper scripts take care of provisioning dependencies (requires `git` and a `gcc` toolchain) and linking the configs. Install the prerequisites with:

```bash
sudo apt update
sudo apt install git build-essential
```

## git

To use private repositories or push changes, set up SSH authentication with GitHub:

1. Create a keypair (accept defaults to store it in `~/.ssh`):
   ```bash
   ssh-keygen -t ed25519 -C "your-email@example.com"
   ```
2. Copy the public key and upload it to GitHub under *Settings → SSH and GPG keys*:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
3. Test the login to confirm GitHub recognizes the key:
   ```bash
   ssh -T git@github.com
   ```

## Usage

```bash
git clone git@github.com:aehrlich1/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The `install.sh` script first runs `setup-remote.sh` to install required packages (APT, Homebrew, CLI tools, etc.) and then invokes `link-configs.sh` to symlink every configuration directory from the repo into `~/.config`.

To include the optional AI tooling (Claude Code, Codex, Gemini, and Node), pass `--with-ai-tools` to either `install.sh` or `setup-remote.sh`. By default these tools are skipped.

For machine-specific Fish tweaks, add them to `fish/conf.d/config.local.fish`; the directory is already sourced by Fish, but the file is ignored so local overrides stay untracked.

## fish

To configure fish as your login shell:

```bash
command -v fish | sudo tee -a /etc/shells
sudo chsh -s "$(command -v fish)" <username>
```

Place this in `~/.config/fish/conf.d/config.local.fish`

```bash
eval "$(<Homebrew prefix path>/bin/brew shellenv)"
```
