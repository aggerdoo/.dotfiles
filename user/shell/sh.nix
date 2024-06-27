{ pkgs, ... }:

let

# aliases
myAliases = {
  ls = "eza --icons -l -T -L=1";
  cat = "bat";
  htop = "btop";
  fd = "fd -Lu";
  neofetch = "fastfetch";
  fetch = "disfetch";
  gitfetch = "onefetch";
};

in

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };
  
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "";
    };
    interactiveShellInit = "fastfetch";
    
    shellAliases = myAliases;
  };

  programs.zellij = {
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      #pallete = "everforest";
      palette.everforest = {
        base00 = "2f383e"; # bg0,       palette1 dark (medium)
        base01 = "374247"; # bg1,       palette1 dark (medium)
        base02 = "4a555b"; # bg3,       palette1 dark (medium)
        base03 = "859289"; # grey1,     palette2 dark
        base04 = "9da9a0"; # grey2,     palette2 dark
        base05 = "d3c6aa"; # fg,        palette2 dark
        base06 = "e4e1cd"; # bg3,       palette1 light (medium)
        base07 = "fdf6e3"; # bg0,       palette1 light (medium)
        base08 = "7fbbb3"; # blue,      palette2 dark
        base09 = "d699b6"; # purple,    palette2 dark
        base0A = "dbbc7f"; # yellow,    palette2 dark
        base0B = "83c092"; # aqua,      palette2 dark
        base0C = "e69875"; # orange,    palette2 dark
        base0D = "a7c080"; # green,     palette2 dark
        base0E = "e67e80"; # red,       palette2 dark
        base0F = "eaedc8"; # bg_visual, palette1 dark (medium)
      };
      add_newline = false;
      command_timeout = 500;
      follow_symlinks = true;
      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$character"
        "$nix_shell"
      ];
      username = {
        show_always = true;
        style_user = "bg:base03 fg:base0A";
        style_root = "bg:base03 fg:base0E";
      };
      directory = { 
        format = "[$path]($style)";
        style = "blue"; 
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        symbol = "  ";
        format = "[$symbol$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "⚠️";
        untracked = "📁 ";
        modified = "𝚫 ";
        staged = "✔ ";
        renamed = "⇆ ";
        deleted = "✘ ";
        stashed = "↪ ";
      };
      git_state = {
        format = "[\($state($progress_current of $progress_total)\)]($style) ";
        style = "bright-black";
      };
      cmd_duration = {
        format = " took [$duration]($style)";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style)";
        style = "bright-black";
      };  
      nix_shell = {
        disabled = false;
        #format = "[${pad.left}](fg:white)[ ](bg:white fg:black)[${pad.right}](fg:white) ";
      };
    };
  };

  home.packages = with pkgs; [
    disfetch fastfetch eza bat
    fd btop direnv nix-direnv
    onefetch gnugrep nix-output-monitor
    zellij
  ];

  #programs.direnv.enable = true;
  #programs.direnv.nix-direnv.enable = true;
  #programs.direnv.enableFishIntegration = true;
  
}
