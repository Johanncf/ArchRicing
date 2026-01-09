#!/usr/bin/env bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "ArchRicing: BASH_SOURCE: $script_dir"

set -e # kill the process if an error occur

# Install dependencies if needed

for arg in "$@"; do
  if [[ "$arg" == "-S" ]]; then
    echo "ArchRicing: Synchronizing dependencies"
    source "$script_dir/hypr/hyprdeps.sh"
  fi

  if [[ "$arg" == "--rofi" && ! -d "$HOME/rofi-collection" ]]; then
    echo "ArchRicing: Cloning Murzchnvok rofi collection"
    git clone https://github.com/Murzchnvok/rofi-collection "$HOME/rofi-collection" --depth 1
    mkdir -p "$HOME/.local/share/rofi/themes/"
    cp "$HOME/rofi-collection/nord/nord.rasi" "$HOME/.local/share/rofi/themes/"
    cp "$HOME/rofi-collection/tokyonight/tokyonight.rasi" "$HOME/.local/share/rofi/themes/"
  fi
done

echo "ArchRicing: Synchronizing config files..." 
cp -r "$script_dir/hypr"        ~/.config
cp -r "$script_dir/waybar"      ~/.config
cp -r "$script_dir/kitty"	      ~/.config
cp    "$script_dir/zsh/.zshrc"  ~/.zshrc
echo "ArchRicing: Ok"

echo "ArchRicing: Creating wallpaper helper script..."
chmod u+x "$script_dir/hypr/switch_wallpaper.sh"
echo "ArchRicing: Ok"

echo "ArchRicing: Creating reload waybar helper script..."
reloadbar_script="$script_dir/waybar/reloadbar.sh"
chmod u+x $reloadbar_script
cp $reloadbar_script ~/.local/bin/reloadbar
echo "ArchRicing: Ok"

echo "ArchRicing: Reloading hyprland..."
hyprctl reload

echo "ArchRicing: Reloading waybar..."
$reloadbar_script && sleep 2

echo -e "\033[33mArchRicing: Reload your .zshrc so changes can be applied\033[0m"

echo "ArchRicing: Success"
