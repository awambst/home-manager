{ ... }:
{
  imports = [
    ./plugins
  ];

  programs.nixvim = import ./nixvim.nix // {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
