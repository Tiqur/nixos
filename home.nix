{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tiqur";
  home.homeDirectory = "/home/tiqur";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.waybar = {
	enable = true;
	settings = {

  mainBar = {
    layer = "top";
    position = "top";
    height = 40;
    spacing = 5;
    margin-bottom = -45;

    modules-left = [ "custom/wofi" "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ "mpris" "clock#time" ];
    modules-right = [ "pulseaudio" "bluetooth" "custom/wifi" "custom/notification" ];

    "hyprland/workspaces" = {
      disable-scroll = true;
      active-only = false;
      all-outputs = true;
      warp-on-scroll = false;
      format = "{icon}";
      format-icons = {
        "1" = "<span color='#7e7eaa'>◆</span>";
        "2" = "<span color='#668fa0'>◆</span>";
        "3" = "<span color='#7f80aa'>◆</span>";
        default = "<span color='#7e7eaa'>◆</span>";
      };
      persistent-workspaces = {
        "*" = 1;
      };
    };

    "hyprland/window" = {
      format = "{class}";
      max-length = 20;
      rewrite = {
        "" = "<span foreground='#458588'></span> hyprland";
        "~" = " terminal";
        "com.mitchellh.ghostty" = ">> ghostty";
        "zen-beta" = ">> zen";
      };
    };

    "pulseaudio" = {
      format = "<span color='#fbf1c7'></span>{volume}%";
      format-muted = "<span color='#fbf1c7'></span>{volume}%";
      format-bluetooth = "<span color='#fbf1c7'></span>{volume}%";
      format-bluetooth-muted = "<span color='#fbf1c7'></span>{volume}%";
      format-source = "{volume}%";
      on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      tooltip = false;
      max-volume = 130;
    };

    "clock#time" = {
      format = "<span color='#cc241d'></span>{:%I:%M %p - %a %d %b}";
      tooltip = false;
      min-length = 8;
      max-length = 30;
    };

    "mpris" = {
      format = "<span color='#cc241d'></span> {artist} - {title} ";
      max-length = 40;
    };

    "custom/wifi" = {
      return-type = "json";
      format = "ᯤ";
      tooltip = true;
      on-click = "nm-connection-editor";
      interval = 1;
      min-length = 1;
      max-length = 12;
    };

    "bluetooth" = {
      format = "<span></span>";
      format-disabled = "<span></span>";
      format-connected = "<span></span>";
      format-connected-battery = "<span> low</span>";
      tooltip-format = "{num_connections} connected";
      tooltip-format-disabled = "Bluetooth Disabled";
      tooltip-format-connected = "{num_connections} connected\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}";
      tooltip-format-enumerate-connected-battery = "{device_alias}: {device_battery_percentage}%";
      on-click = "blueman-manager";
      interval = 1;
      min-length = 1;
      max-length = 10;
    };

    "custom/notification" = {
      tooltip = false;
      rotate = 0;
      format = "{icon}";
      format-icons = {
        notification = "󰅸 ";
        none = "󰂜 ";
        dnd-notification = "󰅸 ";
        dnd-none = "󱏨 ";
        inhibited-notification = "󰅸 ";
        inhibited-none = "󰂜 ";
        dnd-inhibited-notification = "󰅸 ";
        dnd-inhibited-none = "󱏨 ";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click-right = "swaync-client -d -sw";
      on-click = "swaync-client -t -sw";
      escape = true;
    };
  };


	};
	style = ''
@define-color blue #ffffff;
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

window#waybar>* {
  margin-top: 10px;
}

window#waybar>*>* {
  /*background: red;*/
}

/* Outer horizontal padding */
.modules-left {
  padding-left: 80px;
}
.modules-right {
  padding-right: 80px;
}

/* Inner element padding */
.modules-left>*>*>* {
  margin-right: 1rem;
}
.modules-right>*>* {
  margin-left: 1rem;
}


.modules-center {
}

#custom-wofi,
#workspaces button,
#workspaces button:hover,
#workspaces button.visible,
#workspaces button.visible:hover,
#workspaces button.active,
#workspaces button.active:hover,
#workspaces button.urgent,
#window,
#pulseaudio,
#pulseaudio.muted,
#clock {
}

#window,
#pulseaudio,
#pulseaudio.muted,
#clock {
}

#workspaces {
}

#workspaces button {
  min-width: 30px;
  padding: 0 4px;
  border-radius:13px;
}

#workspaces button {
  border: 2px solid @blue;
  border-radius: 13px;
}

#workspaces button.active {
  border: 2px solid @purple;
}

#workspaces button.urgent {
  /*border: 2px solid #ffffff;*/
}


#window {
  padding: 5px 30px 7px;
}


#pulseaudio {
}

#pulseaudio.muted {
}


#clock.time {
}

#mpris {
}

#custom-notification {
}

#bluetooh {
}

#bluetooth,#custom-wifi {
}
'';
  };



  programs.alacritty = {
enable = true;

settings = {
  window = {
    title = "Terminal";

    padding = { y = 5; x=5; };
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
      background = "#2e3440";
      foreground = "#d8dee9";
      dim_foreground = "#a5abb6";
    };
    cursor = {
      text = "#2e3440";
      cursor = "#d8dee9";
    };
    vi_mode_cursor = {
      text = "#2e3440";
      cursor = "#d8dee9";
    };
    selection = {
      text = "CellForeground";
      background = "#4c566a";
    };
    search = {
      matches = {
        foreground = "CellBackground";
        background = "#88c0d0";
      };
      #bar = {
      #  background = "#434c5e";
      #  foreground = "#d8dee9";
      #};
    };
    normal = {
      black = "#3b4252";
      red = "#bf616a";
      green = "#a3be8c";
      yellow = "#ebcb8b";
      blue = "#81a1c1";
      magenta = "#b48ead";
      cyan = "#88c0d0";
      white = "#e5e9f0";
    };
    bright = {
      black = "#4c566a";
      red = "#bf616a";
      green = "#a3be8c";
      yellow = "#ebcb8b";
      blue = "#81a1c1";
      magenta = "#b48ead";
      cyan = "#8fbcbb";
      white = "#eceff4";
    };
    dim = {
      black = "#373e4d";
      red = "#94545d";
      green = "#809575";
      yellow = "#b29e75";
      blue = "#68809a";
      magenta = "#8c738c";
      cyan = "#6d96a5";
      white = "#aeb3bb";
    };
  };
};
};


  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "/home/tiqur/mysystem/wallpapers/wave.png"];

      wallpaper = [
        "DP-3,/home/tiqur/mysystem/wallpapers/wave.png"
        "DP-1,/home/tiqur/mysystem/wallpapers/wave.png"
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

          monitor = [
            # "eDP-1, 1920x1080, 0x0, 1"
            ",prefered,auto,1"
          ];

          xwayland = {
            force_zero_scaling = true;
          };

          general = {
            gaps_in = 10;
            gaps_out = 80;
            border_size = 2;
            layout = "dwindle";
            allow_tearing = false;
	    #col.active_border = "#88c0d0";
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
            fullscreen_opacity = 0.9;

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
            "$mod, return, exec, $terminal"
            "$mod SHIFT, q, killactive"
            "$mod SHIFT, e, exit"
            "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

            # Screen focus
            "$mod, SHIFT SPACE, togglefloating"
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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tiqur/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
