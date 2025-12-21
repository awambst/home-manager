{ pkgs, ... }:
{
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

  };
  home.packages = with pkgs; 
    [
      moonlight-qt
    ];

}
