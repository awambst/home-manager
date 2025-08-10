{ config, pkgs, ... }:
let
  info = import dotfiles/info.nix;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
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
  programs.git = {
    enable = true;
    lfs.enable = false;
    userEmail = "${info.mail}";
    userName = "${info.prenom} ${info.nom}";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
      aliases = {
        qmp = "!f() { git fetch && git add -A && git commit -m \"$*\" && git push; }; f";
        s = "!f() { git status -sb; }; f";
        st = "!f() { git status; }; f";
        f = "!f() { git fetch; }; f";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".gitconfig".text = ''
            [user]
            	email = "${info.mail}"
              name = "${info.prenom} ${info.nom}"
            [core]
      	      editor = nvim
            	whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
            	pager = delta
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
            [alias]
              qmp = "!f() { git fetch && git add -A && git commit -m \"$*\" && git push; }; f"
              s = "!f() { git status -sb; }; f"
              st = "!f() { git status; }; f"
              f = "!f() { git fetch; }; f"
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
