{ ... }:
let
  info = import ../../info.nix;
in
{
  home.file = {
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
}
