{ lib, inputs, user, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

in
  {
    Framework = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs unstable system user;
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
          home-manager.users.${user} = {
            imports = [(import ./Framework/home.nix)];
          };
          # optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
  }
