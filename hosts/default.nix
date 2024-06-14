{ lib, outputs, inputs, user, nixpkgs, nixpkgs-2305-stable, nixpkgs-2405-stable, home-manager, nixos-hardware, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  stable-2305 = import nixpkgs-2305-stable {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };
  # pkgs = nixpkgs.legacyPackages.${system} {
  #   config.allowUnfree = true;
  # };
  stable-2405 = import nixpkgs-2405-stable {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

in
  {
    Framework = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs system user;
        host = {
          hostName = "Framework";
        };
      };

      modules = [
        nixos-hardware.nixosModules.framework-12th-gen-intel
        ./Framework

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit user stable-2305;
            host = {
              hostName = "piercewang";
              mainMonitor = "eDP-1";
            };
          };
          home-manager.users.${user} = {
            imports = [(import ./Framework/home.nix)];
          };
          # optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };

    ThinkPad = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs system user;
        host = {
          Hostname = "ThinkPad";
        };
      };

      # modules = [];
      modules = [
        ./ThinkPad

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit user;
          };
          home-manager.users.${user} = {
            imports = [(import ./ThinkPad/home.nix)];
          };
        }
      ];
    };

    SteamDeck = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit outputs inputs system user;
        host = {
          hostName = "SteamDeck";
        };
      };

      modules = [
        ./SteamDeck

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit user stable-2305 stable-2405;
            host = {
              hostName = "piercewang";
            };
          };
          home-manager.users.${user} = {
            imports = [(import ./SteamDeck/home.nix)];
          };
          # optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };

  }
