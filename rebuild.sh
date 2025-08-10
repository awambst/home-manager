#!/bin/bash
echo "!info.nix" >> .gitignore
git add info.nix
home-manager switch -b backup
git rm -rf --cached info.nix
sed -i '$d' .gitignore
