# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth = {
    enable = true;
    # settings = {
    #   General = {
    #     ControllerMode = "bredr";
    #   };
    # };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-5f5347bc-c685-4b20-aaca-c5e24a26ddd4".device = "/dev/disk/by-uuid/5f5347bc-c685-4b20-aaca-c5e24a26ddd4";
  boot.initrd.luks.devices."luks-5f5347bc-c685-4b20-aaca-c5e24a26ddd4".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "Framework"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # networking.wireless = {
  #   enable = true;
  #   environmentFile = "/home/piercewang/.config/secrets/wireless.env";
  #   networks = {
  #     "Columbia U Secure" = {
  #       auth = ''
  #         key_mgmt=WPA-EAP
  #         eap=PEAP
  #         phase2="auth=MSCHAPV2"
  #         identity="@IDENT_COLUMBIA@"
  #         password="@PSK_COLUMBIA@"
  #         '';
  #     };
  #   };
  # };

  # Set your time zone.
  # time.timeZone = "America/Los_Angeles";
  time.timeZone = "America/New_York";
  # time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # fonts.fontconfig.defaultFonts = {
  #     monospace = [
  #       "DejaVu Sans Mono"
  #       "WenQuanYi Micro Hei Mono"
  #     ];
  #     sansSerif = [
  #       "DejaVu Sans"
  #       "WenQuanYi Micro Hei"
  #     ];
  #     serif = [
  #       "DejaVu Serif"
  #       "WenQuanYi Micro Hei"
  #     ];
  # };

  # i18n.inputMethod.enabled = "fcitx5";


  # i18n.inputMethod.enabled = "fcitx5";
  # i18n.inputMethod.fcitx5.addons = with pkgs; [
  #   fcitx5-chinese-addons
  #   fcitx5-rime
  # ];
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-rime
  #     fcitx5-configtool
  #     fcitx5-chinese-addons
  #     fcitx5-gtk
  #   ];

    # 我现在用 ibus
    # enabled = "ibus";
    # ibus.engines = with pkgs.ibus-engines; [
    #   libpinyin
    #   rime
    # ];
  # };

  # Enable fwupd
  services.fwupd.enable = true;

  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Enable the GNOME Desktop Environment.
      # displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;
      # need unstable for this:
      # Configure keymap in X11
      # layout = "us,cn";
      # xkbVariant = "";
      # xkbOptions = "ctrl:nocaps";
    };
  };

  # GTK themes are not applied in Wayland applications / Window Decorations missing / Cursor looks different (from nixos guide)
  programs.dconf.enable = true;

  # programs.sway.enable = true;
  # xdg.portal.wlr.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.pki.certificateFiles = [
    ../../modules/nextcloud/nc-selfsigned.pem
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.piercewang = {
    isNormalUser = true;
    description = "Pierce Wang";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [
    # ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    # gnome.gnome-tweaks
    zerotierone
    packagekit
    steam
  ];


  # What is this for?
  # systemd.packages = with pkgs; [
  # ];

  services = {
    zerotierone = {
      enable = true;
      joinNetworks = [
        "a0cbf4b62a5cddb8"
      ];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
