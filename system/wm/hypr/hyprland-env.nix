{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "helix";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      GBM_BACKEND = "";
      __GLX_VENDOR_LIBRARY_NAME = "";
      LIBVA_DRIVER_NAME = "";
      __GL_VRR_ALLOWED = "1";
      WLR_NO_HAARDWARE_CURSORS = "";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      CLUTTER_BACKEND = "wayland";
      WLR_RENDERER = "vulkan";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
