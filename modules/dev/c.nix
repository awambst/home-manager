{ pkgs, ... }:
{
  home.packages = with pkgs; [
    man-pages
    clang-tools
    gcovr
    gnumake
    gdb
    gcc
    #    rustc
    #    rustup
  ];
}
