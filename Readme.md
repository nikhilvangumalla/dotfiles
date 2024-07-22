# Dotfiles Config

Install Nix Package Manager

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Add channel

```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
```
### Update nix channel

```sh
nix-channel --update
```

allow non free software

add below config in `~/.config/nixpkgs/config.nix`

```nix
{
    allowUnfree = true;
}
```

Install packages

```sh
nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.neovim \
  nixpkgs.btop \
  nixpkgs.git \
  nixpkgs.bat \
  nixpkgs.eza \
  nixpkgs.fd \
  nixpkgs.fzf \
  nixpkgs.lazygit \
  nixpkgs.zoxide \
  nixpkgs.ripgrep \
  nixpkgs.stow \
  nixpkgs.starship \
```

Run below command for gui application to show it in the menu

```sh
ln -s /home/$USER/.nix-profile/share/applications/* /home/$USER/.local/share/applications
```

if you have already ran this and throws file exits error run the below code

```sh
for file in /home/$USER/.nix-profile/share/applications/*; do
  target = "$HOME/.local/share/applications/$(basename "$file")"
  [ -e "$target" ] || ln -s "$file" "$target"
done
```

logout and login to see the icons in the menu

```sh
flatpak install flathub io.github.zen_browser.zen
```

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

### Change default shell

```sh
sudo vi /etc/shells
```
add `/home/$USER/.nix-profile/bin/zsh`

```sh
chsh -s /home/$USER/.nix-profile/bin/zsh
```


### Dotfiles Configuration

Install Nerd font for this config `FiraCord NerdFont` is required

Clone this repo

```sh
git clone https://github.com/nikhilvangumalla/dotfiles.git ~/
```

Run Stow to symlink configs

go to `~/dotfiles`

```sh
cd ~/dotfiles
```

for all

```sh
stow -vt ~ */
```

for single

```sh
stow -vt ~ zsh
```

**Note:** for `vscode` need to do things differently because vscode have profiles

so, for the default setting go to folder `~/dotfiles/vscode` and then run `stow` command

```sh
cd ~/dotfiles/vscode
stow -vt ~ default
```

we can import profiles manually based on need from vscode, files are in `~/vscode/profiles`
