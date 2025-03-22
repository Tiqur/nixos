{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Consider automatic upgrades (for security)

  # Docker
  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable support for RAID arrays
  boot.swraid.enable = true;

  # Hostname
  networking.hostName = "rikka";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Scrub (self-heal) btrfs filesystems
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # Automatically snapshot raid array to seperate drive
  services.snapper = {
    snapshotInterval = "hourly";
    persistentTimer = true;
    configs.tank = {
      SUBVOLUME = "/storage/tank/@home_data";
      FSTYPE = "btrfs";
      TIMELINE_LIMIT_HOURLY = 3;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY = 1;
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
    };
  };

  # Percistent Logging
  services.journald.extraConfig = "Storage=persistent";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tiqur = {
    isNormalUser = true;
    description = "tiqur";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9f24H+33riGpiXIgGWX3hOWOT/Q7oS6TwJRdXonhmT tiqur@nixos" # Desktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECv7n8RK9THvNKXHZDcv/Q14MlWh4UyCoRy4/SwhciZ tiqur@nixos" # Laptop
    ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "tiqur";

  services.scrutiny = {
    enable = true;
    openFirewall = true;
    settings.web.listen.port = 8080;
  };

  services.cockpit = {
    enable = true;
    openFirewall = true;
  };

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/home/tiqur/immich_data";
  };
  #services.tailscale.enable = true;

  nix.gc.automatic = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    htop
    screen
  ];

  services.fail2ban = {
    enable = true;
    maxretry = 10;
    bantime-increment.enable = true;
    ignoreIP = [ "192.168.1.235" ];
  };

  # age.secrets.restic-hetzner.file = ../../secrets/restic-hetzner.age;
  # age.secrets.restic-hetzner-password.file = ../../secrets/restic-hetzner-password.age;

  # services.restic.backups = {
  #   remotebackup = {
  #     initialize = true;
  #     paths = [ # what to backup
  #       "/persistent"
  #     ];
  #     passwordFile = config.age.secrets.restic-hetzner-password.path; # encryption
  #     repository = "sftp://<boxname>-<subN>@<boxname>.your-storagebox.de/"; @ where to store it
  #
  #     extraOptions = [
  #       # how to connect
  #       "sftp.command='${pkgs.sshpass}/bin/sshpass -f ${config.age.secrets.restic-hetzner.path} -- ssh -4 u419690.your-storagebox.de -l u419690-sub1 -s sftp'"
  #     ];
  #     timerConfig = { # when to backup
  #       OnCalendar = "00:05";
  #       RandomizedDelaySec = "5h";
  #     };
  #   };

  # Enable the OpenSSH daemon.
  services.openssh = {
    forwardX11 = true;
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "tiqur" ];
      LogLevel = "VERBOSE";
    };
  };

  systemd.services.main-python-service = {
    enable = true;
    description = "My Python App Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nix}/bin/nix run .";
      Restart = "always";
      User = "tiqur";
      WorkingDirectory = "/home/tiqur/osu-score-history";
      StandardOutput = "journal";
      StandardError = "journal";
      RestartSec = "10s";
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
