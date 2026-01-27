{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Docker
  virtualisation.docker.enable = true;

  # Networking
  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.opentabletdriver.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
    ];
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
  };

  # I
  # The Ollama environment variables, as mentioned in the comments section
  systemd.services.ollama.serviceConfig = {
    Environment = [ "OLLAMA_HOST=0.0.0.0:11434" ];
  };

  services.open-webui = {
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "False";
    };
  };

  environment.interactiveShellInit = ''
    dr() {
       while ! aria2c -x 1 -s 1 --connect-timeout=30 --retry-wait=1 --max-tries=0 \
         --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
         --referer="https://kemono.su/" -c "$1"; do
           RND=$(( ( RANDOM % 5 ) + 1 ))
           echo "Server is cooked. Retrying in $RND seconds..."
           sleep $RND
       done
     }
  '';

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "where_is_my_sddm_theme";
  services.desktopManager.plasma6.enable = true;
  #programs.hyprlock.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" ];
  };

  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "tiqur";

  # Enable the LXQT Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.lxqt.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
    #extraConfig.pipewire.adjust-sample-rate = {
    #  "context.properties" = {
    #    "default.clock.rate" = 192000;
    #    "default.allowed-rates" = [
    #      44100
    #      48000
    #      192000
    #    ];
    #  };
    #};

    extraConfig.pipewire."99-deepfilter-mono-source" = {
      "context.modules" = [
        {
          "name" = "libpipewire-module-filter-chain";
          "args" = {
            "filter.graph" = {
              "nodes" = [
                {
                  "type" = "ladspa";
                  "name" = "DeepFilter Mono";
                  "plugin" = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
                  "label" = "deep_filter_mono";
                  "control" = {
                    "Attenuation Limit (dB)" = 100;
                  };
                }
              ];
            };
            "audio.position" = [ "MONO" ];
            "audio.rate" = "48000";
            "capture.props" = {
              "node.passive" = true;
            };
            "playback.props" = {
              "media.class" = "Audio/Source";
            };
          };
        }
      ];
    };

  };

  users.users.tiqur = {
    isNormalUser = true;
    description = "Tiqur";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      neovim
      alacritty
      firefox
      fastfetch
      obsidian
      #webcord
      discord
      vesktop
      htop
      wofi
      unzip
      anki-bin
      swappy
      grim
      slurp
      waybar
      kitty
      home-manager
      mpv
      gamescope-wsi
      wl-clipboard
      feh
      prismlauncher
      osu-lazer-bin
    ];
  };

  programs.firefox.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.tiqur = {
      imports = [
        ./home.nix
        inputs.nixvim.homeModules.nixvim
        inputs.catppuccin.homeModules.catppuccin
        #inputs.niri.homeModules.niri
      ];
    };
  };

  fonts.packages = [
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.caskaydia-cove
    pkgs.nerd-fonts.droid-sans-mono
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    #substituters = [ "https://niri.cachix.org" ];
    #trusted-public-keys = [ "niri.cachix.org-1:Wv0Om60S7qS6SGMGCf6hY6+E3+FMA6JpS1A9E3kID6o=" ];
  };

  environment.systemPackages = with pkgs; [
    #kdePackages.kwin-vk-hdr-layer
    libnotify
    steam
    oterm

    aria2
    (writeScriptBin "dr" ''
      #!/usr/bin/env bash
      URL="$1"
      if [ -z "$URL" ]; then
        echo "Usage: dr <url>"
        exit 1
      fi

      while ! aria2c -x 1 -s 1 --connect-timeout=30 --retry-wait=1 --max-tries=0 \
        --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
        -c "$URL"; do
          RND=$(( ( RANDOM % 5 ) + 1 ))
          echo "Server is cooked. Retrying in $RND seconds..."
          sleep $RND
      done
    '')
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
