{
  description = "Pierce's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                     # Default Stable Nix Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager, used for managing user configuration
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ...}:
    let                                                                     # Variables that can be used in the config files.
      user = "piercewang";
    in                                                                      # Use above variables in ...
      {
        nixosConfigurations = (
          import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs user nixpkgs nixpkgs-unstable home-manager nixos-hardware;
          }
        );
      };
}
