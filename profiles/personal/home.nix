{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    ../../user/app/git/git.nix
    ../../user/shell/sh.nix
    ../../user/app/fastfetch/fastfetch.nix 
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    lm_sensors
    git
  ];

  xdg.enable = true;
  xdg.userDirs = {
    extraConfig = {
      #XDG_GAME_DIR = "${config.home.homeDirectory}/Games";
    };
  };

  #xresources.properties = {
  #"Xcursor.size" = 16;
  #"Xft.dpi" = 172;
  #};
  
}
