{ pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    (
      # Put the most recent revision here:
      # let revision = "f27db3a9a8c21a65c1ef50cacca3ef2bfff04cb9"; in
      let revision = "f02a01aab60c68b7898043c2e7f5bc97c93fb07b"; in
      builtins.fetchTarball {
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
        # Update the hash as needed:
        sha256 = "sha256:1rhpcz8sa37zgg7czhql32i6zhqw4d5wykmhykgjn652ayaj9sxw";
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
  # NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/0a71bbb64a89b311d9b5a715de2f1713368e799f.tar.gz nix-shell -p nixos-generators --run "nixos-generate --format iso --configuration ./image.nix -o result"
  # from https://nix.dev/tutorials/nixos/building-bootable-iso-image.html

}
