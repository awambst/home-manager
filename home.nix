{
  config,
  pkgs,
  ...
}:
let
  info = import ./info.nix;
in
{
  home.username = "${info.login}";
  home.homeDirectory = "/home/${info.login}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.jq
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
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };

    ".bashrc".text = ''
      if [ -n "$IN_NIX_SHELL" ]; then
        export PS1="\[\033[01;32m\]nix-shell\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$"
      else
        export PS1="\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$"
      fi
    '';

    ".config/wofi" = {
      source = ./dotfiles/wofi;
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

    ".config/hypr/screens.conf".text = "${info.screens}";
    ".config/hypr/input.conf".text = ''
      # https://wiki.hyprland.org/Configuring/Variables/#input
      input {
          kb_layout = ${if info.keyboard == "fr" then "fr" else "us"}
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          sensitivity = -0.2 #1.0 - 1.0, 0 means no modification.
          accel_profile = flat    
          numlock_by_default = true

          touchpad {
              natural_scroll = true
          }
      }'';
    ".config/hypr/workspaces.conf".text = ''
          # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, ${
        if info.keyboard == "fr" then "ampersand" else "1"
      }, workspace, 1
      bind = $mainMod, ${
        if info.keyboard == "fr" then "eacute" else "2"
      }, workspace, 2
      bind = $mainMod, ${
        if info.keyboard == "fr" then "quotedbl" else "3"
      }, workspace, 3
      bind = $mainMod, ${
        if info.keyboard == "fr" then "apostrophe" else "4"
      }, workspace, 4
      bind = $mainMod, ${
        if info.keyboard == "fr" then "parenleft" else "5"
      }, workspace, 5
      bind = $mainMod, ${if info.keyboard == "fr" then "minus" else "6"}, workspace, 6
      bind = $mainMod, ${
        if info.keyboard == "fr" then "egrave" else "7"
      }, workspace, 7
      bind = $mainMod, ${
        if info.keyboard == "fr" then "underscore" else "8"
      }, workspace, 8
      bind = $mainMod, ${
        if info.keyboard == "fr" then "ccedilla" else "9"
      }, workspace, 9
      bind = $mainMod, ${
        if info.keyboard == "fr" then "agrave" else "0"
      }, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9] and DONT go there
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "ampersand" else "1"
      }, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "eacute" else "2"
      }, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "quotedbl" else "3"
      }, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "apostrophe" else "4"
      }, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "parenleft" else "5"
      }, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "minus" else "6"
      }, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "egrave" else "7"
      }, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "underscore" else "8"
      }, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "ccedilla" else "9"
      }, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, ${
        if info.keyboard == "fr" then "agrave" else "0"
      }, movetoworkspacesilent, 10'';

    ".config/hypr" = {
      source = ./dotfiles/hypr;
      recursive = true;
    };

    ".gitconfig".text = ''
      [user]
        email = "${info.mail}"
        name = "${info.prenom} ${info.nom}"
      [core]
        editor = nvim
        whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
      [init]
        defaultBranch = main
      [checkout]
        defaultRemote = origin
      [color]
        ui = auto
      [color "branch"]
        current = yellow bold
        local = green bold
        remote = cyan bold
      [color "diff"]
        meta = yellow bold
        frag = magenta bold
        old = red bold
        new = green bold
        whitespace = red reverse
      [color "status"]
        added = green bold
        changed = yellow bold
        untracked = red bold
      [push]
        autoSetupRemote = true
      [alias]
        qmp = "!f() { git fetch && git add -A && git commit -m \"$*\" && git push; }; f"
        s = "!f() { git status -sb; }; f"
        st = "!f() { git status; }; f"
        f = "!f() { git fetch; }; f"
      [gpg]
          format=ssh
      [user]
          signingkey=~/.ssh/keys/id_rsa_sign.pub
      [commit]
          gpgsign = ${info.git_signing}
      [tag]
          gpgsign = ${info.git_signing}
    '';

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

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
