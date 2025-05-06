{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    inputs.sops-nix.nixosModules.sops
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./hardware-configuration.nix
  ];

  # Ensure directory exists
  #systemd.tmpfiles.rules = [
  #  "d /run/secrets/ 0755 root root -"
  #];

  #sops.defaultSopsFile = ./secrets/secrets.yaml;
  #sops.defaultSopsFormat = "yaml";

  #sops.age.keyFile = "/storage/secrets/keys.txt";

  #sops.secrets."borg-ssh-key-path" = { };
  #sops.secrets."borg-user" = { };
  #sops.secrets."borg-host" = { };
  #sops.secrets."borg-passphrase" = { };

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

  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/storage/tank/@minecraft_servers";

    servers.voidmc_survival = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      package = inputs.nix-minecraft.legacyPackages.${pkgs.system}.fabricServers.fabric-1_21_5;
      jvmOpts = "-Xmx8G -Xms4G";
      whitelist = {
        Tiqur = "0af77247-21bc-4729-9a97-6ed2538f6317";
      };
      serverProperties = {
        server-port = 25565;
        difficulty = 3;
        gamemode = 1;
        max-players = 50;
        motd = "VoidMC Survival";
        white-list = true;
      };
    };
  };

  # Scrub (self-heal) btrfs filesystems
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # Automatically snapshot raid array to seperate drive
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "12h";
    persistentTimer = true;
    configs.minecraft_servers = {
      SUBVOLUME = "/storage/tank/@minecraft_servers";
      FSTYPE = "btrfs";
      TIMELINE_LIMIT_HOURLY = 4;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY = 1;
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
    };
    configs.tiqur_backup = {
      SUBVOLUME = "/storage/tank/@tiqur_backup";
      FSTYPE = "btrfs";
      TIMELINE_LIMIT_HOURLY = 4;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY = 1;
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
    };
    configs.home_data = {
      SUBVOLUME = "/storage/tank/@home_data";
      FSTYPE = "btrfs";
      TIMELINE_LIMIT_HOURLY = 4;
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

  #services.borgbackup.jobs."borg-backup" = {
  #  paths = [
  #    "/storage/tank/@home_data"
  #    "/storage/tank/@tiqur_backup"
  #  ];
  #  repo = "u453229@u453229.your-storagebox.de:/home/backup";
  #  encryption = {
  #    mode = "repokey";
  #    passCommand = "cat ${config.sops.secrets."borg-passphrase".path}";
  #  };
  #  environment.BORG_RSH = "ssh -v -p 23 -i /root/.ssh/id_ed25519";
  #  environment.BORG_LOGGING_LEVEL = "DEBUG";
  #  compression = "auto,lzma";
  #  startAt = "weekly";
  #  persistentTimer = true;
  #};

  services.scrutiny = {
    enable = true;
    openFirewall = true;
    settings.web.listen.port = 8080;
  };

  services.cockpit = {
    enable = true;
    openFirewall = true;
    settings = {
      WebService = {
        LoginTo = false;
        AllowUnencrypted = true;
      };
    };
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

  environment.variables.EDITOR = "neovim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    htop
    sops
    screen
  ];

  services.fail2ban = {
    enable = true;
    maxretry = 10;
    bantime-increment.enable = true;
    ignoreIP = [ "192.168.1.235" ];
  };

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

  #systemd.services.python-osu-relayer-server-service = {
  #  enable = true;
  #  description = "Osu Replayer";
  #  after = [ "network.target" ];
  #  wantedBy = [ "multi-user.target" ];
  #  serviceConfig = {
  #    ExecStart = "${pkgs.nix}/bin/nix run .";
  #    Restart = "always";
  #    User = "tiqur";
  #    WorkingDirectory = "/home/tiqur/osu-replayer-server";
  #    StandardOutput = "journal";
  #    StandardError = "journal";
  #    RestartSec = "10s";
  #  };
  #};

  #systemd.services.main-python-service = {
  #  enable = true;
  #  description = "My Python App Service";
  #  after = [ "network.target" ];
  #  wantedBy = [ "multi-user.target" ];
  #  serviceConfig = {
  #    ExecStart = "${pkgs.nix}/bin/nix run .";
  #    Restart = "always";
  #    User = "tiqur";
  #    WorkingDirectory = "/home/tiqur/osu-score-history";
  #    StandardOutput = "journal";
  #    StandardError = "journal";
  #    RestartSec = "10s";
  #  };
  #};

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    8727
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
