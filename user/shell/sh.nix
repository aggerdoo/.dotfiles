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
    shellAliases = myAliases;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = [
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
      ];
      directory = { style = "blue"; };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = "[$branch]($style)";
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
        format = " '\([$state( $progress_current/$progress_total)]($style)\) '";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style)";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style)";
        style = "bright-black";
      };  
    };
  };

  home.packages = with pkgs; [
    disfetch fastfetch eza bat
    fd btop direnv nix-direnv
    onefetch gnugrep 
  ];

  #programs.direnv.enable = true;
  #programs.direnv.nix-direnv.enable = true;
  #programs.direnv.enableFishIntegration = true;
  
}
