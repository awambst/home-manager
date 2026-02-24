{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "clang-format-epitable" ''
      git rev-parse --git-dir > /dev/null 2>&1 || \
      exit 1; find . -name "*.cpp" -o -name "*.h" -o -name "*.c" | \
      xargs clang-format -i
    '')
  ];
  imports = [
    dev/c.nix
  ];
}
