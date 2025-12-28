{ ... }:
{
  imports = [
    i3/polybar.nix
    i3/dunst.nix
    i3/rofi.nix
  ];

  home.file = {
    ".config/i3" = {
      source = ../dotfiles/i3;
      recursive = true;
    };
    ".config/picom" = {
      source = ../dotfiles/picom;
      recursive = true;
    };

  };
}
