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
    enable = true;
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
    settings = {

      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 5;
        margin-bottom = -45;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock#time"
        ];
        modules-right = [
          "pipewire"
          "network"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            default = "";
          };
        };

        "pipewire" = {
        };

        "clock#time" = {
          format = "<span color='#cc241d'></span>{:%I:%M %p - %a %d %b}";
          tooltip = false;
          min-length = 8;
          max-length = 30;
        };

        "network" = {
          format-wifi = "Wireless";
          format-ethernet = "Wired";
          format-disconnected = "Disconnected";
        };
      };
    };
    style = ''
      @define-color blue #88c0d0;
      @define-color purple #b48ead;

      * {
        padding: 0;
        border-radius: 0;
        min-height: 0;
        color: @white;
        font-weight: 400;
        margin: 0;
        border: none;
        text-shadow: none;
        transition: none;
        box-shadow: none;
        font-size: 1rem;
        font-family: JetBrainsMono Nerd Font Propo;
        border-radius: 8px;
        background: transparent;
      }

      .modules-left {
        padding-left: 80px;
      }
      .modules-right {
        padding-right: 80px;
      }

      window#waybar>* {
        margin-top: 10px;
      }

      .module {
        background-color: #282a36;
        padding-left: 1rem;
        padding-right: 1rem;
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
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/tiqur/mysystem/wallpapers/cat_juzo.png" ];

      wallpaper = [
        "DP-3,/home/tiqur/mysystem/wallpapers/cat_juzo.png"
        "DP-1,/home/tiqur/mysystem/wallpapers/cat_juzo.png"
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
        active_opacity = 0.9;
        inactive_opacity = 0.8;
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
        "$mod, S, exec, ${pkgs.grim}/bin/grim | wl-copy"
        "$mod SHIFT+ALT, S, exec, ${pkgs.grim}/bin/grim -g \"$(slurp)\" - | ${pkgs.swappy}/bin/swappy -f -"
      ];

      bindm = [
        #"$mod, mouse:272, hy3:movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      env = [
        #"NIXOS_OZONE_WL,1"
        #"_JAVA_AWT_WM_NONREPARENTING,1"
        #"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        #"QT_QPA_PLATFORM,wayland"
        #"SDL_VIDEODRIVER,wayland"
        #"GDK_BACKEND,wayland"
        #"LIBVA_DRIVER_NAME,nvidia"
        #"XDG_SESSION_TYPE,wayland"
        #"XDG_SESSION_DESKTOP,Hyprland"
        #"XDG_CURRENT_DESKTOP,Hyprland"
        #"GBM_BACKEND,nvidia-drm"
        #"__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        #"${pkgs.waybar}/bin/eww"
        #"${pkgs.hyprpaper}/bin/hyprpaper"
        #"${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
        #"${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
        #"eval $(gnome-keyring-daemon --start --components=secrets,ssh,gpg,pkcs11)"
        #"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
        #"hash dbus-update-activation-environment 2>/dev/null"
        #"export SSH_AUTH_SOCK"
        #"${pkgs.plasma5Packages.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
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
