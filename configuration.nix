# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ]; # Allow mounting of ntfs filesystems

  boot.initrd.luks.devices."luks-c5390a9f-b211-4afe-b09c-9fc851a93be1".device = "/dev/disk/by-uuid/c5390a9f-b211-4afe-b09c-9fc851a93be1";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # LOW LATENCY PIPEWIRE SETTINGS FOR OSU
  #environment.etc."pipewire/pipewire.conf.d/99-rates.conf".text = ''
  #  context.properties = {
  #    default.clock.rate = 48000
  #    default.clock.quantum = 32
  #    default.clock.min-quantum = 32
  #    default.clock.max-quantum = 32
  #  }
  #'';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tiqur = {
    isNormalUser = true;
    description = "Tiqur";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [ ];
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Packages
  environment.systemPackages =
    (with pkgs-unstable; [
      # Unstable packages
      vim # How do I exit?
      neovim # How do I exit ( but neo )?
      ranger # Terminal based file explorer
      alacritty # Terminal emulator
      wofi # Application launcher
      pipewire # Audio
      vesktop # Discord but better
      anki # Flashcards 
      wireplumber # Session / policy manager for pipewire
      pavucontrol # Volume control for pipewire
      htop # Terminal task manager
      opentabletdriver # Tablet driver
      wlr-randr # xrander for wayland
      git # git
      gh # CLI for github 
      obsidian # Notes n stuff
      home-manager # /home manager
      bat # Alternative to cat
      eza # Alternative to ls
      neo-cowsay # Moo
      obs-studio # Caught in 4k
      osu-lazer-bin # See you next time
      grim # Screenshot utility for sway
      wl-clipboard # Copy to clipboard
      slurp

    ])

    ++

    (with pkgs; [
      # Stable packages
      firefox # Jumped over the lazy dog 
    ]);

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware = {
    opengl.enable = true;
    opentabletdriver.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
