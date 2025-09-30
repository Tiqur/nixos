{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home.username = "tiqur";
  home.homeDirectory = "/home/tiqur";
  home.stateVersion = "24.11";

  #systemd.user.services.noisetorch = {
  #  after = [ "default.target" ];
  #  wantedBy = [ "default.target" ];
  #  serviceConfig = {
  #    Type = "simple";
  #    ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i";
  #    Restart = "on-failure";
  #    RestartSec = 5;
  #  };
  #  #environment = {
  #  #  PULSE_SERVER = "/run/user/1000/pulse/native";
  #  #};
  #};

  catppuccin = {
    enable = true;
    accent = "red";
    flavor = "macchiato";
  };

  programs.hyprpanel = {
    enable = true;
    settings = {

      theme = {
        matugen = true;
        wallpaper = {
          enable = true;
          image = "/home/tiqur/mysystem/wallpapers/wave.png";
        };
      };

      layout = {
        bar.layouts = {
          "0" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "systray"
              "notifications"
            ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };

  programs.nixvim = {
    enable = true;

    opts = {
      clipboard = "unnamedplus";
      relativenumber = true;
      number = true;
      hlsearch = true;
      errorbells = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      smartcase = true;
      swapfile = false;
      backup = false;
      undofile = true;
      incsearch = true;
      termguicolors = true;
      cursorline = true;
      spell = true;
      mouse = "a";
      showmode = false;
      updatetime = 20;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      vimtex_view_general_viewer = "okular";
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-y>";
        action = "<C-u>zz";
      }

      {
        mode = "n";
        key = "<leader>h";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<leader>j";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<leader>k";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<leader>l";
        action = "<C-w>l";
      }

      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>Telescope find_files<cr>";
      }
      {
        mode = "n";
        key = "<leader>r";
        action = "<cmd>Telescope live_grep<cr>";
      }
      {
        mode = "n";
        key = "<leader>g";
        action = "<cmd>LazyGit<cr>";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>NvimTreeToggle<cr>";
      }
    ];

    extraConfigLua = ''
      local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
      vim.opt.undodir = { prefix .. "/nvim/.undo//" }
      vim.opt.backupdir = { prefix .. "/nvim/.backup//" }
      vim.opt.directory = { prefix .. "/nvim/.swp//" }
    '';

    colorschemes.catppuccin.enable = true;

    plugins = {
      telescope.enable = true;
      nvim-tree.enable = true;
      lazygit.enable = true;
      lualine.enable = true;
      vimtex.enable = true;
      web-devicons.enable = true;
      wrapping.enable = true;
      nvim-autopairs.enable = true;
      undotree.enable = true;
    };
  };

  #programs.neovim = {
  #  enable = true;
  #  defaultEditor = true;
  #  extraConfig = ''
  #    " Clipboard
  #    set clipboard=unnamedplus
  #
  #    " Line numbers
  #    set relativenumber
  #    set number
  #
  #    " Search and bell
  #    set hlsearch
  #    set errorbells
  #
  #    " Tabs and indentation
  #    set tabstop=2
  #    set softtabstop=2
  #    set shiftwidth=2
  #    set expandtab
  #    set smartindent
  #    set nowrap
  #    set smartcase
  #
  #    " Swap and backup
  #    set noswapfile
  #    set backupdir=~/.config/nvim/.backup//
  #    set directory=~/.config/nvim/.swp//
  #    set nobackup
  #
  #    " Undo
  #    set undofile
  #    set undodir=~/.config/nvim/.undo//
  #    set incsearch
  #
  #    " Spell check
  #    set spell
  #
  #    " Mouse and mode
  #    set mouse=a
  #    set noshowmode
  #
  #    " Update time
  #    set updatetime=20
  #
  #    " Termguicolors and cursorline
  #    set termguicolors
  #    set cursorline

  #
  #    " Leader keys
  #    let mapleader = " "
  #    let maplocalleader = " "
  #
  #    " Keybindings
  #    nnoremap <C-d> <C-d>zz
  #    nnoremap <C-y> <C-u>zz
  #
  #    " Window split navigation
  #    nnoremap <leader>h :wincmd h<CR>
  #    nnoremap <leader>j :wincmd j<CR>
  #    nnoremap <leader>k :wincmd k<CR>
  #    nnoremap <leader>l :wincmd l<CR>
  #
  #    " Telescope and others
  #    nnoremap <leader>f :Telescope find_files<CR>
  #    nnoremap <leader>r :Telescope live_grep<CR>
  #    nnoremap <leader>g :LazyGit<CR>
  #    nnoremap <leader>n :NvimTreeToggle<CR>
  #  '';

  #  #plugins = with pkgs.vimPlugins; [
  #  #];
  #  #extraPackages = [

  #  #];
  #};

  programs.firefox = {
    enable = false;
    profiles.default = {
      name = "Default";
      isDefault = true;
      settings = {
      };
      # https://cascadefox.github.io/
      userChrome = '''';
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        bitwarden
        darkreader
        vimium
        youtube-shorts-block
        sponsorblock
      ];
    };
  };

  xdg.mimeApps.defaultApplications = {

  };

  programs.git = {
    enable = true;
    userName = "Tiqur";
    userEmail = "Tiqur7@gmail.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        layer = "overlay";
        prompt = ">>  ";
      };

      colors.background = "2E3440E6";
      colors.text = "D8DEE9ff";
      colors.selection = "4C566AE6";
      colors.selection-text = "ECEFF4ff";
      colors.border = "88c0d0E6";
      colors.match = "88C0D0E6";
      colors.selection-match = "81A1C1E6";

      border.radius = 20;
      border.width = 2;
    };
  };

  #programs.eww = {
  #  enable = true;
  #};

  programs.waybar = {
    enable = false;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    settings = [
      {
        layer = "top";
        position = "top";
        mode = "dock"; # Fixes fullscreen issues
        height = 32; # 35
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        ipc = true;
        fixed-center = true;
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        margin-bottom = 0;

        modules-left = [
          "hyprland/workspaces"
          "cava"
        ];
        # modules-center = ["clock" "custom/notification"];
        modules-center = [
          "idle_inhibitor"
          "clock"
        ];
        modules-right = [
          "custom/gpuinfo"
          "cpu"
          "memory"
          "backlight"
          "pulseaudio"
          "bluetooth"
          "network"
          "tray"
          "battery"
        ];

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/colour-temperature" = {
          format = "{} ";
          exec = "wl-gammarelay-rs watch {t}";
          on-scroll-up = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +100";
          on-scroll-down = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -100";
        };
        "custom/cava_mviz" = {
          #exec = "${../../scripts/WaybarCava.sh}";
          format = "{}";
        };
        "cava" = {
          hide_on_silence = false;
          framerate = 60;
          bars = 10;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          input_delay = 1;
          # "noise_reduction" = 0.77;
          sleep_timer = 5;
          bar_delimiter = 0;
          on-click = "playerctl play-pause";
        };
        "custom/gpuinfo" = {
          #exec = "${../../scripts/gpuinfo.sh}";
          return-type = "json";
          format = " {}";
          interval = 5; # once every 5 seconds
          tooltip = true;
          max-length = 1000;
        };
        "custom/icon" = {
          # format = " ";
          exec = "echo ' '";
          format = "{}";
        };
        "mpris" = {
          format = "{player_icon} {title} - {artist}";
          format-paused = "{status_icon} <i>{title} - {artist}</i>";
          player-icons = {
            default = "▶";
            spotify = "";
            mpv = "󰐹";
            vlc = "󰕼";
            firefox = "";
            chromium = "";
            kdeconnect = "";
            mopidy = "";
          };
          status-icons = {
            paused = "⏸";
            playing = "";
          };
          ignored-players = [
            "firefox"
            "chromium"
          ];
          max-length = 30;
        };
        "temperature" = {
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 83;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
          ];
          interval = 10;
        };
        "hyprland/language" = {
          format = "{short}"; # can use {short} and {variant}
          #on-click = "${../../scripts/keyboardswitch.sh}";
        };
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          active-only = false;
          on-click = "activate";
          persistent-workspaces = {
            "*" = [
              1
              2
              3
              4
              5
              6
              7
              8
              9
              10
            ];
          };
        };

        "hyprland/window" = {
          format = "  {}";
          separate-outputs = true;
          rewrite = {
            "harvey@hyprland =(.*)" = "$1 ";
            "(.*) — Mozilla Firefox" = "$1 󰈹";
            "(.*)Mozilla Firefox" = " Firefox 󰈹";
            "(.*) - Visual Studio Code" = "$1 󰨞";
            "(.*)Visual Studio Code" = "Code 󰨞";
            "(.*) — Dolphin" = "$1 󰉋";
            "(.*)Spotify" = "Spotify 󰓇";
            "(.*)Spotify Premium" = "Spotify 󰓇";
            "(.*)Steam" = "Steam 󰓓";
          };
          max-length = 1000;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰥔";
            deactivated = "";
          };
        };

        "clock" = {
          format = "{:%a %d %b %R}";
          # format = "{:%R 󰃭 %d·%m·%y}";
          format-alt = "{:%I:%M %p}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "cpu" = {
          interval = 10;
          format = "󰍛 {usage}%";
          format-alt = "{icon0}{icon1}{icon2}{icon3}";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };

        "memory" = {
          interval = 30;
          format = "󰾆 {percentage}%";
          format-alt = "󰾅 {used}GB";
          max-length = 10;
          tooltip = true;
          tooltip-format = " {used:.1f}GB/{total:.1f}GB";
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 2%+";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        };

        "network" = {
          # on-click = "nm-connection-editor";
          # "interface" = "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = "󰤨 Wi-Fi";
          # format-wifi = " {bandwidthDownBits}  {bandwidthUpBits}";
          # format-wifi = "󰤨 {essid}";
          format-ethernet = "󱘖 Wired";
          # format-ethernet = " {bandwidthDownBits}  {bandwidthUpBits}";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = "󰤮 Off";
          # format-disconnected = "󰤮 Disconnected";
          format-alt = "󰤨 {signalStrength}%";
          tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
        };

        "bluetooth" = {
          format = "";
          # format-disabled = ""; # an empty format will hide the module
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
          on-click = "blueman-manager";
        };

        "pulseaudio" = {
          format = "{icon} {volume}";
          format-muted = " ";
          on-click = "pavucontrol -t 3";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 4;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "pavucontrol -t 4";
          tooltip-format = "{format_source} {source_desc} // {source_volume}%";
          scroll-step = 5;
        };

        "tray" = {
          icon-size = 12;
          spacing = 5;
        };

        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          # format-charging = " {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/power" = {
          format = "{}";
          on-click = "wlogout -b 4";
          interval = 86400; # once every day
          tooltip = true;
        };
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        margin: 0px;
        padding: 0px;
      }

      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color theme_base_color @base;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      window#waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
        background: transparent;
        /*border: 2px solid @overlay0;*/
        /*background: @theme_base_color;*/
        border-radius: 10px;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 8px;
      }

      tooltip label {
        color: #cad3f5;
        margin-right: 5px;
        margin-left: 5px;
      }

      /* This section can be use if you want to separate waybar modules */
      .modules-left {
      	background: @theme_base_color;
       	border: 1px solid @blue;
      	padding-right: 15px;
      	padding-left: 2px;
      	border-radius: 10px;
        margin-left: 70px;
      }
      .modules-center {
      	background: @theme_base_color;
        border: 0.5px solid @overlay0;
      	padding-right: 5px;
      	padding-left: 5px;
      	border-radius: 10px;
      }
      .modules-right {
      	background: @theme_base_color;
       	border: 1px solid @blue;
      	padding-right: 15px;
      	padding-left: 15px;
      	border-radius: 10px;
        margin-right: 70px;
      }

      #backlight,
      #backlight-slider,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #idle_inhibitor,
      #keyboard-state,
      #memory,
      #mode,
      #mpris,
      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #taskbar button,
      #taskbar,
      #temperature,
      #tray,
      #window,
      #wireplumber,
      #workspaces,
      #custom-backlight,
      #custom-cycle_wall,
      #custom-keybinds,
      #custom-keyboard,
      #custom-light_dark,
      #custom-lock,
      #custom-menu,
      #custom-power_vertical,
      #custom-power,
      #custom-swaync,
      #custom-updater,
      #custom-weather,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.default,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.severe,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.sunnyDay {
      	padding-top: 3px;
      	padding-bottom: 3px;
      	padding-right: 6px;
      	padding-left: 6px;
      }

      #idle_inhibitor {
        color: @blue;
      }

      #bluetooth,
      #backlight {
        color: @blue;
      }

      #battery {
        color: @green;
      }

      @keyframes blink {
        to {
          color: @surface0;
        }
      }

      #battery.critical:not(.charging) {
        background-color: @red;
        color: @theme_text_color;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        box-shadow: inset 0 -3px transparent;
      }

      #custom-updates {
        color: @blue
      }

      #custom-notification {
        color: #dfdfdf;
        padding: 0px 5px;
        border-radius: 5px;
      }

      #language {
        color: @blue
      }

      #clock {
        color: @yellow;
      }

      #custom-icon {
        font-size: 15px;
        color: #cba6f7;
      }

      #custom-gpuinfo {
        color: @maroon;
      }

      #cpu {
        color: @yellow;
      }

      #custom-keyboard,
      #memory {
        color: @green;
      }

      #disk {
        color: @sapphire;
      }

      #temperature {
        color: @teal;
      }

      #temperature.critical {
        background-color: @red;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #keyboard-state {
        color: @flamingo;
      }

      #workspaces button {
          box-shadow: none;
      	text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          padding-left: 4px;
          padding-right: 4px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
      	border-radius: 10px;
      	color: @overlay0;
      	background-color: @surface0;
       	padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.persistent {
      	color: @surface1;
      	border-radius: 10px;
      }

      #workspaces button.active {
      	color: @peach;
        	border-radius: 10px;
          padding-left: 8px;
          padding-right: 8px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.urgent {
      	color: @red;
       	border-radius: 0px;
      }

      #taskbar button.active {
          padding-left: 8px;
          padding-right: 8px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button:hover {
          padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #custom-cava_mviz {
      	color: @pink;
      }

      #cava {
      	color: @pink;
      }

      #mpris {
      	color: @pink;
      }

      #custom-menu {
        color: @rosewater;
      }

      #custom-power {
        color: @red;
      }

      #custom-updater {
        color: @red;
      }

      #custom-light_dark {
        color: @blue;
      }

      #custom-weather {
        color: @lavender;
      }

      #custom-lock {
        color: @maroon;
      }

      #pulseaudio {
        color: @lavender;
      }

      #pulseaudio.bluetooth {
        color: @pink;
      }
      #pulseaudio.muted {
        color: @red;
      }

      #window {
        color: @mauve;
      }

      #custom-waybar-mpris {
        color:@lavender;
      }

      #network {
        color: @blue;
      }
      #network.disconnected,
      #network.disabled {
        background-color: @surface0;
        color: @text;
      }
      #pulseaudio-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #pulseaudio-slider trough {
      	min-width: 80px;
      	min-height: 5px;
      	border-radius: 5px;
      }

      #pulseaudio-slider highlight {
      	min-height: 10px;
      	border-radius: 5px;
      }

      #backlight-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #backlight-slider trough {
      	min-width: 80px;
      	min-height: 10px;
      	border-radius: 5px;
      }

      #backlight-slider highlight {
      	min-width: 10px;
      	border-radius: 5px;
      }
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        title = "Terminal";
        padding = {
          y = 16;
          x = 16;
        };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        #normal.family = "JetbrainsMono Nerd Font";
        #size = 8.0;
      };

      #background_opacity = 0.3;
      #shell = { program = "${pkgs.zsh}/bin/zsh"; };

      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          dim_foreground = "#7f849c";
          bright_foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe";
        };
        selection = {
          text = "#1e1e2e";
          background = "#f5e0dc";
        };
        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1";
          };
        };
        footer_bar = {
          foreground = "#1e1e2e";
          background = "#a6adc8";
        };
        hints = {
          start = {
            foreground = "#1e1e2e";
            background = "#f9e2af";
          };
          end = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#fab387";
          }
          {
            index = 17;
            color = "#f5e0dc";
          }
        ];
      };
    };
  };

  services.hyprpaper = {
    enable = false;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/tiqur/mysystem/wallpapers/kurzgesagt.jxl" ];

      wallpaper = [
        "DP-2,/home/tiqur/mysystem/wallpapers/kurzgesagt.jxl"
        "DP-1,/home/tiqur/mysystem/wallpapers/kurzgesagt.jxl"
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    plugins = [ inputs.hy3.packages.${pkgs.system}.hy3 ];

    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";

      #monitor = "DP-1, 3440@1440@144, 0x0, 1";
      monitor = "DP-2, 2560x1440@240, 0x0, 1";

      xwayland = {
        force_zero_scaling = true;
      };

      general = {
        gaps_in = 10;
        gaps_out = 80;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
        "col.active_border" = "rgba(f5e0dcee)";
        "col.inactive_border" = "rgba(3b4252ee)";
      };

      input = {
        kb_layout = "us";
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
        accel_profile = "flat";
        sensitivity = 0;
      };

      decoration = {
        rounding = 8;
        active_opacity = 0.8;
        inactive_opacity = 0.7;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 2;
          passes = 3;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          ignore_opacity = false;
        };

        shadow = {
          enabled = false;
          range = 8;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      cursor = {
        enable_hyprcursor = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        #no_gaps_when_only = 0;
        smart_split = false;
        smart_resizing = false;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        # General
        "$mod, return, exec, $terminal -e fish -c \"fastfetch; exec fish\""
        "$mod SHIFT, q, killactive"
        "$mod SHIFT, e, exit"
        "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

        # Screen focus
        "$mod, SPACE, togglefloating"
        "$mod, u, focusurgentorlast"
        "$mod, tab, focuscurrentorlast"
        "$mod, f, fullscreen"

        # Screen resize
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, l, resizeactive, 20 0"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, j, resizeactive, 0 20"

        # Workspacek
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspaces
        "$mod SHIFT, 1, movetoworkspace,1"
        "$mod SHIFT, 2, movetoworkspace,2"
        "$mod SHIFT, 3, movetoworkspace,3"
        "$mod SHIFT, 4, movetoworkspace,4"
        "$mod SHIFT, 5, movetoworkspace,5"
        "$mod SHIFT, 6, movetoworkspace,6"
        "$mod SHIFT, 7, movetoworkspace,7"
        "$mod SHIFT, 8, movetoworkspace,8"
        "$mod SHIFT, 9, movetoworkspace,9"
        "$mod SHIFT, 0, movetoworkspace,10"

        # Navigation
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Move Windows
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # Applications
        #"$mod ALT, f, exec, ${pkgs.firefox}/bin/firefox"
        #"$mod ALT, e, exec, $terminal --hold -e ${pkgs.yazi}/bin/yazi"
        #"$mod ALT, o, exec, ${pkgs.obsidian}/bin/obsidian"
        "$mod, d, exec, pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
        #"$mod ALT, r, exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
        #"$mod ALT, n, exec, swaync-client -t -sw"

        # Clipboard
        #"$mod ALT, v, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

        # Screencapture
        "$mod, S, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy"
      ];

      bindm = [
        #"$mod, mouse:272, hy3:movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      env = [ ];
      exec-once = [
        #"${pkgs.waybar}/bin/waybar"
        #"${pkgs.waybar}/bin/eww"
      ];
    };

  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    inputs.zen-browser.packages."${pkgs.system}".twilight
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
