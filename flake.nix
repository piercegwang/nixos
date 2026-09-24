{
  description = "Pierce's NixOS Flake";

  inputs = {
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                    # Default Unstable Nix Packages
    nixpkgs-2605-stable.url = "github:nixos/nixpkgs/nixos-26.05";           # Default Nix Packages 26.05
    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Helium Browser
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    blueferry-nix = {
      url = "github:piercegwang/nix-flake-blueferry";
      # url = "path:/home/piercewang/Documents/github/nix-flake-blueferry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, used for managing user configuration
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, nixpkgs, nixpkgs-2605-stable, jovian-nixos, home-manager, nixos-hardware, ...}:
    let                                                                     # Variables that can be used in the config files.
      inherit (self) outputs;
      user = "piercewang";
    in                                                                      # Use above variables in ...
      {

        overlays = import ./overlays {inherit inputs;};
        nixosConfigurations = (
         import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs outputs user nixpkgs nixpkgs-2605-stable jovian-nixos home-manager nixos-hardware;
          }
        );
      };
}
