{
  pkgs,
  ...
}:
let
  info = import ./info.nix;
in
{
  home.username = "${info.login}";
  home.homeDirectory = "/home/${info.login}";

  # Enable the Flakes feature and the accompanying new nix command-line tool
  #home.settings.experimental-features = [
  #  "nix-command"
  #   "flakes"
  #];

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [

    picom
    feh

    scrot
    flameshot

    arandr

    kdePackages.ark

    kdePackages.oxygen
    kdePackages.oxygen-icons
    kdePackages.dolphin-plugins
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.kio-extras

    adwaita-icon-theme
    hicolor-icon-theme
    papirus-icon-theme

    lombok
    jdt-language-server
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".clang-format".source = dotfiles/.clang-format;

    ".config/waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };

    "Images/screens/.oui".text = "";

    ".bashrc".text = ''
      if [ -n "$IN_NIX_SHELL" ]; then
        export PS1="\[\033[01;32m\]nix-shell\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$ "
      else
        export PS1="\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$ "
      fi
    '';

    ".config/flameshot/flameshot.ini".text = ''
      [General]
      contrastOpacity=188
      savePath=/home/${info.login}/Images/screens
      showHelp=false
      showStartupLaunchMessage=false
      startupLaunch=true
      buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\t\0\0\0\0\0\0\0\x5\0\0\0\x12\0\0\0\xf\0\0\0\b\0\0\0\t\0\0\0\n\0\0\0\v\0\0\0\f)
      showSelectionGeometryHideTime=2997
    '';

    ".config/dolphinrc".source = ./dotfiles/dolphinrc;

    ".cache/betterlockscreen" = {
      source = ./dotfiles/betterlockscreen;
      recursive = true;
    };

    ".config/variety" = {
      source = ./dotfiles/variety;
      recursive = true;
    };

    ".config/lock" = {
      source = ./dotfiles/lock;
      recursive = true;
    };

    ".config/alacritty" = {
      source = ./dotfiles/alacritty;
      recursive = true;
    };

    ".config/mako" = {
      source = ./dotfiles/mako;
      recursive = true;
    };

    ".config/wallpapers" = {
      source = ./dotfiles/wallpapers;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/"${info.login}/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  imports = [
    ./modules/xdg-config.nix
    ./modules/i3.nix
    ./modules/dev.nix
    ./modules/common.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
