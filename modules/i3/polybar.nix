{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    package = pkgs.polybarFull;
  };

  home.file = {
    ".config/polybar" = {
      source = ../../dotfiles/polybar;
      recursive = true;
    };

  };
}
