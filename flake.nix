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

    # Zen Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    # optional, but recommended if you closely follow NixOS unstable so it shares
    # system libraries, and improves startup time
    # NOTE: if you experience a build failure with Zen, the first thing to check is to remove this line!
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Helium Browser
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager, used for managing user configuration
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, nixpkgs, nixpkgs-2605-stable, zen-browser, helium-flake, jovian-nixos, home-manager, nixos-hardware, ...}:
    let                                                                     # Variables that can be used in the config files.
      inherit (self) outputs;
      user = "piercewang";
    in                                                                      # Use above variables in ...
      {

        overlays = import ./overlays {inherit inputs;};
        nixosConfigurations = (
         import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs outputs user nixpkgs nixpkgs-2605-stable zen-browser helium-flake jovian-nixos home-manager nixos-hardware;
          }
        );
      };
}
