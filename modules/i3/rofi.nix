{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
    rofi-network-manager
    rofi-rbw
  ];

  home.file = {
    ".config/rofi" = {
      source = ../../dotfiles/rofi;
      recursive = true;
    };
  };
}
