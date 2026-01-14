{ pkgs, ...}:
{
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    (pkgs.writeShellScriptBin "vpn-banquise" ''
      sudo systemctl restart strongswan-swanctl.service
      sudo swanctl -q
      sudo swanctl -i --child banquise
    '')
    
    (pkgs.writeShellScriptBin "dev-rust" ''
      nix shell github:oxalica/rust-overlay
    '')


    jq
    jellyfin-media-player
    mpv
    inkscape-with-extensions
    kdePackages.dolphin
    kdePackages.dolphin-plugins

    bc
    arrpc # To be able to use discord acivity detection
    vesktop
    pulseaudio
    gparted
    popsicle
  ];

  imports = [
    common/firefox.nix
    common/moonlight.nix
    common/git.nix
  ];
}
