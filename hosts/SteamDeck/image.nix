{ pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    (
      # Put the most recent revision here:
      let revision = "8d91e8c23b14819781403c47de3c5bada7db2d65"; in
      builtins.fetchTarball {
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
        # Update the hash as needed:
        sha256 = "sha256:1z5yy4fkffzrz4f07q55wnn54vk2i3lzccdvcmamd0fpbcxsy5qr";
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
  # NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/6990439a4a194ed8f6f7a4a594740dc01153cf91.tar.gz nix-shell -p nixos-generators --run "nixos-generate --format iso --configuration ./image.nix -o result"
  # from https://nix.dev/tutorials/nixos/building-bootable-iso-image.html

}
