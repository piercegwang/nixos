{ pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    (
      # Put the most recent revision here:
      # let revision = "f27db3a9a8c21a65c1ef50cacca3ef2bfff04cb9"; in
      let revision = "a679e3a0ef9d3d43639f7ba894069c43e2d39c2c"; in
      builtins.fetchTarball {
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
        # Update the hash as needed:
        sha256 = "sha256:1vx13fsfjnvqm70jhkbcykaksjsq13fl7g013k9jm7ka744ndpc2";
      } + "/modules"
    )
  ];

  nixpkgs.config.allowUnfree = true;

  # use the latest Linux kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

  jovian.devices.steamdeck.enable = true;

  # generate using
  # NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/9ac9a9c2f5c2e22a32b55fa283a0ee64c8bb7760.tar.gz nix-shell -p nixos-generators --run "nixos-generate --format iso --configuration ./image.nix -o result"
  # from https://nix.dev/tutorials/nixos/building-bootable-iso-image.html

}
