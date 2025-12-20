{ flake, ... }:
{
  imports = [
    #flake.inputs.nixvim.nixosModules.nixvim
    ./plugins
    #flake.inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = import ./nixvim.nix // {
    enable = true;
    viAlias = true;
  };
}
