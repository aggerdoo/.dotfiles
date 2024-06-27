{ pkgs, lib, systemSettings, userSettings, fetchFromgitHub, ... }:
{
  imports = 
  [
    ../../system/hardware-configuration.nix
    ../../system/style/stylix.nix
    ../../system/admin/doas.nix
    ../../system/admin/automount.nix
    ../../system/wm/gnome.nix
    ../../system/admin/pipewire.nix
    ../../system/admin/disko.nix
  ];

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # flakes & store & gc
  nix.package = pkgs.nixFlakes;
  nix = {
    extraOptions = ''experimental-features = nix-command flakes ca-derivations'';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "delete-older-than 5d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "userSettings.username" ];
    };
  };  

  # unfree
  nixpkgs.config = {
    allowunfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
  };

  # kernel-modules
  boot.kernelModules = [ "kvm-amd" ];

  # bootloader
  boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = (systemSettings.bootMountPath);
  boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
  boot.loader.grub.device = systemSettings.grubDevice;

  # networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.username;
    extraGroups = [ "networkmanager" "audio" "video" "wheel" "input" ];
    packages = [];
    uid = 1000;
  };

  # xserver
  services.xserver = {
    enable = true;
    xkb.layout = "gb";
    xkb.variant = "";
  };
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # dwm
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = ../../suckless/dwm;
  };
  
  console.keyMap = "uk";

  # systemwide packages
  environment.systemPackages = with pkgs; [
    wget
    helix
    #base16-schemes
    
    git
    kitty
    firefox
    tree
    fastfetch
    ranger
    fish
    zellij
  ];

  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # fonts
  fonts.fontDir.enable = true;
  fonts.fontconfig = {
    enable = true;
  };
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Terminus"]; })
    hack-font
    font-awesome
  ];

  # stylix
  #stylix = {
  #  enable = true;
    #image = pkgs.fetchurl {
    #  url = "https://github.com/NotMugil/catppuccin-wallpapers/blob/main/anime-skull.png";
    #  sha256 = "oTme8a6B2s7UgwX/zIPv2aIqVBTst1ryNlc0XCFgPKg=";
    #};
  #  image = ../../themes/wallpapers/wallpaper.png;
  #};
  
  environment.variables.EDITOR = "helix";

  system.stateVersion = "24.05";
   
}
