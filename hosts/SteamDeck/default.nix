# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, outputs, inputs, config, pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (
        # Put the most recent revision here:
        let revision = "f02a01aab60c68b7898043c2e7f5bc97c93fb07b"; in
        builtins.fetchTarball {
          url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
          # Update the hash as needed:
          sha256 = "sha256:1rhpcz8sa37zgg7czhql32i6zhqw4d5wykmhykgjn652ayaj9sxw";
        } + "/modules"
      )
      # ../../modules/opensd
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "bredr";
        Enable = "Source,Sink,Media,Socket"; # Fixes connecting Bluetooth Earphones
      };
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  networking.hostName = "SteamDeck"; # Define your hostname.
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
  # time.timeZone = "Asia/Taipei";
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

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          # fcitx5-chinese-addons
          libsForQt5.fcitx5-chinese-addons
          fcitx5-rime
        ];
      };
    };
  };

  # Enable fwupd
  services.fwupd.enable = true;

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      settings = {
        General = {
          InputMethod = "qtvirtualkeyboard";
        };
      };
    };
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Enable the GNOME Desktop Environment.
      # displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;
      # desktopManager.xfce.enable = true;
      # Configure keymap in X11
      # layout = "us,cn";
      # xkbVariant = "";
      # xkbOptions = "ctrl:nocaps";
    };
  };

  # GTK themes are not applied in Wayland applications / Window Decorations missing / Cursor looks different (from nixos guide)
  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.pki.certificateFiles = [
    ../../modules/nextcloud/nc-selfsigned.pem
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.piercewang = {
    isNormalUser = true;
    description = "Pierce Wang";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "initial_password";
    # packages = with pkgs; [
    # ];
  };

  # Allow unfree packages
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config.allowUnfree = true;
  };

  jovian = {
    decky-loader = {
      user = "piercewang";
    };
    steam = {
      enable = true;
      autoStart = false;
      user = "piercewang";
      desktopSession = "plasma";
    };
    devices.steamdeck = {
      enable = true;
      enableSoundSupport = true;
    };
  };

  # services.pipewire.wireplumber.package = lib.mkForce pkgs.wireplumber;
  # services.pipewire.wireplumber.configPackages = lib.mkForce [];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    # gnome.gnome-tweaks
    zerotierone
    packagekit
    # steamdeck-firmware
    qt6.qtvirtualkeyboard
    # linuxKernel.packages.linux_zen.v4l2loopback

    # Language Models
    ollama
    # open-webui
  ];

  services = {
    ollama.enable = true;
    # open-webui.enable = true;
  };

  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];

  boot.kernelModules = [ "v4l2loopback" ];

  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

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

  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable steam keyboard on wayland
  programs.steam = {
    enable = true;
    extest.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
