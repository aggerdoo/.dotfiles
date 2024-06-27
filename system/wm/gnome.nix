{ config, pkgs, ... }:

{

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # exclude packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese epiphany geary evince
    totem tali iagno hitori atomix
    eog yelp file-roller seahorse

    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
    gnome-system-monitor gnome-weather gnome-disk-utility
  ]);

  services.gnome = {
    gnome-keyring.enable = true;
  };
  
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
