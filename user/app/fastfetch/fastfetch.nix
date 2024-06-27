{ pkgs, userSettings, systemSettings, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
          #"$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      logo = {
        source = "nixos-small";
        padding = {
          right = 1;
        };
     };
     display = {
        separator = "  ";
    };
     modules = [
        {
           type = "custom";
            #// {#1} is equivalent to `\u001b[1m`. {#} is equivalent to `\u001b[m`
            format = "┌─────────── {#1}Hardware Information{#} ───────────┐";
        }
        {
            type = "host";
            key = "  󰌢";
        }
        {
            type = "cpu";
            key =  "  󰻠";
        }
        {
            type = "gpu";
            key = "  󰍛";
        }
        {
            type = "memory";
            key = "  󰑭";
        }
        {
            type = "sound";
            key = "  ";
        }
       
        {
            type = "custom";
            format = "├─────────── {#1}Software Information{#} ───────────┤";
        }
        {
            type = "title";
            key = "  ";
            format = "{1}@{2}";
        }
        {
            type = "os";
            key = "  ";
        }
        {
            type = "kernel";
            key = "  ";
            format = "{1} {2}";
        }
        {
            type = "wm";
            key = "  ";
        }
        {
            type = "shell";
            key = "  ";
        }
        {
            type = "terminal";
            key = "  ";
        }
        {
            type = "terminalfont";
            key = "  ";
        }
        {
            type = "theme";
            key = "  󰉼";
        }
        {
            type = "icons";
            key = "  󰀻";
        }
        {
            type = "packages";
            key = "  󰏖";
        }
        {
            type = "uptime";
            key = "  󰅐";
        }
        {
            type = "custom";
            format = "└────────────────────────────────────────────┘";
        }
        {
            type = "colors";
            paddingLeft = 2;
            symbol = "circle";
        }
    ];
    };
  };
}
