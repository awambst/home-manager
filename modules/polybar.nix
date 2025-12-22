{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    package = pkgs.polybarFull;

  };
}
