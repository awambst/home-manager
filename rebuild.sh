#!/bin/bash
echo "!info.nix" >> .gitignore
rm -f ~/.config/waybar/config.jsonc.backup
git add info.nix
home-manager switch -b backup
git rm -rf --cached info.nix
sed -i '$d' .gitignore
