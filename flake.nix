{
  description = "Pierce's NixOS Flake";

  inputs = {
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                    # Default Stable Nix Packages
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";                # Default Stable Nix Packages
    nixpkgs-2305-stable.url = "github:nixos/nixpkgs/nixos-23.05";           # Default Nix Packages 23.05 (for gpg 2.4.0)
    nixpkgs-2411-stable.url = "github:nixos/nixpkgs/nixos-24.11";           # Default Nix Packages 24.05 (for handbrake)
    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager, used for managing user configuration
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, nixpkgs, nixpkgs-2305-stable, nixpkgs-2411-stable, jovian-nixos, home-manager, nixos-hardware, ...}:
    let                                                                     # Variables that can be used in the config files.
      inherit (self) outputs;
      user = "piercewang";
    in                                                                      # Use above variables in ...
      {

        overlays = import ./overlays {inherit inputs;};
        nixosConfigurations = (
         import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs outputs user nixpkgs nixpkgs-2305-stable nixpkgs-2411-stable jovian-nixos home-manager nixos-hardware;
          }
        );
      };
}
