{
  description = "Flake";

  outputs = inputs@ { self, lix-module, home-manager, nixpkgs, stylix, disko, ... }:
    let
      # System Setting
      systemSettings = {
        system = "x86_64-linux";
        hostname = "grimoire";
        profile = "personal";
        timezone = "Europe/London";
        locale = "en_GB.UTF-8";
        bootMode = "uefi";
        bootMountPath = "/boot";
      };

      # user settings
      userSettings = rec {
        name = "alan";
        username = "alan";
        email = "smcklaus@gmail.com";
        dotfilesDir = "~./dotfiles";
        theme = "everforest";
        wm = "hyprland";
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser = "firefox";
        defaultRoamDir = "";
        term = "kitty";
        font = "hack";
        fontPkg = pkgs.hack-font;
        editor = "helix";
      };

      # define packages
      pkgs = (if ((systemSettings.profile == "personal"))
              then 
                (import inputs.nixpkgs {
                  system = systemSettings.system;
                  config = {
                    allowunfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
                  };
                })
              else
                (import inputs.nixpkgs-unstable {
                  system = systemSettings.system;
                  config = {
                    allowunfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
                  };
                }));

      #pkgs = import inputs.nixpkgs {
      #  system = systemSettings.system;
      #  config = {
      #    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
      #  }; 
      #};

      # configure lib
      lib = (if ((systemSettings.profile == "personal"))
             then
                inputs.nixpkgs.lib
             else
                inputs.nixpkgs-unstable.lib);

      # home-manager
      home-manager = (if ((systemSettings.profile == "personal") || (systemSettings.profile == "test"))
             then
                inputs.home-manager-stable
             else
                inputs.home-manager-unstable);

      # systems
      supportedSystems = [ "x86_64-linux" ];

      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = 
        forAllSystems (system: import inputs.nixpkgs { inherit system; });

    in {
     # homeConfigurations = {
     #   user = home-manager.lib.homeManagerConfiguration {
     #     inherit pkgs;
     #     modules = [
     #       (./. + "profiles" + ("/" + systemSettings.profile) + "/home.nix") # loads home nix from selected profile
     #     ];
     #     extraSpecialArgs = {
     #       inherit pkgs-stable ;
     #       inherit systemSettings;
     #       inherit userSettings;
     #       inherit inputs;
     #     };
     #   };
     # };

      nixosConfigurations = {
        grimoire = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = {
            inherit pkgs;
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
            #inputs.stylix.nixosModules.stylix
            disko.nixosModules.disko
            {
              _module.args.disks = [ "/dev/vda" ];
            }
            lix-module.nixosModules.default
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.alan = import (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix");
                extraSpecialArgs = {
                  inherit pkgs;
                  inherit systemSettings;
                  inherit userSettings;
                  inherit inputs;
                };
              };
            }
          ];
        };
      };

      # formatter
      formatter = forAllSystems ( system: nixpkgs.legacyPackages.${system}.alejandra);
    };

      inputs = {
        # nix
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nixpkgs.url = "nixpkgs/nixos-24.05";

        # home-manager
        home-manager-unstable.url = "github:nix-community/home-manager/master";
        home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

        home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
        home-manager-stable.inputs.nixpkgs.follows = "nixpkgs";

        # hyprland
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable";

        # lix
        lix = {
          url = "git+https://git.lix.systems/lix-project/lix?ref=refs/tags/2.90-beta.1";
          flake = false;
        };
        lix-module = {
          url = "git+https://git.lix.systems/lix-project/nixos-module";
          inputs.lix.follows = "lix";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        # disko
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";

        # stylix
        stylix = {
          url = "github:danth/stylix";
        };
      };                
}
