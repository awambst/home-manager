{ pkgs, ...} :
{
  home.packages = with pkgs; [
    dunst
  ];

  ".config/dunst/dunstrc" = {
      source = ../../dotfiles/dunst/dunstrc;
      recursive = true;
    };
}
