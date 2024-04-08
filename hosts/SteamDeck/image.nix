{ pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    (
      # Put the most recent revision here:
      let revision = "9b0e8712f1a9e5569036b227d539b745fcf54aad"; in
      builtins.fetchTarball {
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
        # Update the hash as needed:
        sha256 = "sha256:0hwmb5bpjrc4dv20qgjc1hgywp3frbyf5m9zp2gb20sc5f6la5vm";
      } + "/modules"
    )
  ];

  nixpkgs.config.allowUnfree = true;

  # use the latest Linux kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

  jovian.devices.steamdeck.enable = true;
}
