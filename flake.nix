{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "git+https://github.com/nix-community/nixvim.git"; # ?rev=ab1b5962e1ca90b42de47e1172e0d24ca80e6256";
    };
  };

  outputs =
    { nixpkgs, home-manager, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      info = import ./info.nix;
    in
    {
      homeConfigurations."${info.login}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          nixvim.homeModules.nixvim
          ./modules/neovim
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
