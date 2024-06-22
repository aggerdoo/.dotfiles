{ pkgs, ... }:

{
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    ranger
    gvfs
    udisks
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
  ];
}
