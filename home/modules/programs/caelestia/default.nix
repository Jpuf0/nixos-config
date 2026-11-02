{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  hostname = config.networking.hostName;

  # { enabled; id } entries used by bar.entries, bar.statusIcons, utilities.quickToggles
  on = id: {
    enabled = true;
    inherit id;
  };
  off = id: {
    enabled = false;
    inherit id;
  };

  vpnProvider = id: name: displayName: interface: {
    inherit id name displayName interface;
    connectCmd = [];
    disconnectCmd = [];
  };
in {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false;
    };

    settings = {
      background = {
        desktopClock = {
          enabled = true;
          background.enabled = true;
        };
        visualizer.enabled = true;
      };

      bar = {
        scrollActions.brightness = false;
        statusIcons = [
          (off "lockStatus")
          (on "audio")
          (off "microphone")
          (off "kbLayout")
          (on "network")
          (on "bluetooth")
          (
            if hostname == "ghost"
            then (on "battery")
            else (off "battery")
          )
        ];
        workspaces = {
          activeTrail = false;
          maxWindowIcons = 3;
          label = " "; # default has two trailing spaces
          specialWorkspaceIcons = [
            {
              name = "steam";
              icon = "sports_esports";
            }
          ];
        };
      };

      general = {
        apps = {
          terminal = ["kitty"];
          audio = ["pavucontrol"];
          explorer = ["nemo"];
        };

        idle = {
          timeouts = [
            {
              timeout = 180;
              idleAction = "lock";
            }
            {
              timeout = 300;
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
            (mkIf (hostname == "ghost") {
              timeout = 600;
              idleAction = ["suspendThenHibernate"];
            })
          ];
        };
      };

      launcher = {
        favouriteApps = ["equibop" "steam" "dev.zed.Zed" "zen-beta"];
        hiddenApps = ["ModOrganizer-steamtinkerlaunch-dl"];
      };

      notifs = {
        defaultExpireTimeout = 3000;
      };

      osd = {
        enableBrightness =
          if hostname == "ghost"
          then true
          else false;
        enableMicrophone =
          if hostname == "ghost"
          then false
          else true;
      };

      services = {
        clockFormat = "TwentyFourHour";
        weatherUnits = "Celsius";
      };

      utilities = {
        enabled = true;
        maxToasts = 3;
        quickToggles = [
          (on "wifi")
          (on "bluetooth")
          (on "mic")
          (on "settings")
          (on "gameMode")
          (on "dnd")
          (on "vpn")
        ];
        toasts = {
          audioInputChanged = true;
          audioOutputChanged = true;
          capsLockChanged = true;
          chargingChanged = true;
          configLoaded = true;
          dndChanged = true;
          fullscreen = "important";
          gameModeChanged = true;
          kbLayoutChanged = false;
          kbLimit = false;
          nowPlaying = true;
          numLockChanged = true;
          vpnChanged = true;
        };
        vpn = {
          enabled = true;
          selectedProvider = "";
          provider = [
            # (vpnProvider "tailscale" "tailscale" "Tailscale" "tailscale0")
            (vpnProvider "mullvad" "mullvad" "Mullvad" "wg0-mullvad")
          ];
        };
      };
    };

    cli = {
      enable = true;
      settings = {
        record = {
          extraArgs = [];
        };
        wallpaper = {
          postHook = "";
        };
        theme = {
          enableTerm = true;
          enableHypr = true;
          enableDiscord = true;
          enableSpicetify = true;
          enablePandora = true;
          enableFuzzel = true;
          enableBtop = true;
          enableNvtop = true;
          enableHtop = true;
          enableGtk = true;
          enableQt = true;
          enableWarp = true;
          enableChromium = true;
          enableZed = true;
          enableCava = true;
          iconTheme = "Papirus-Dark";
          iconThemeLight = "Papirus-Light";
          iconThemeDark = "Papirus-Dark";
          postHook = "";
        };
        toggles = {
          communication = {
            discord = {
              enable = true;
              match = [{class = "equibop";}];
              command = ["equibop"];
              move = true;
            };
            whatsapp = {
              enable = false;
            };
          };
          music = {
            spotify = {
              enable = true;
              match = [{class = "Spotify";} {initialTitle = "Spotify";}];
              command = ["spotify"];
              move = true;
            };
            feishin = {
              enable = false;
            };
          };
          sysmon = {
            btop = {
              enable = true;
              match = [
                {
                  class = "btop";
                  title = "btop";
                  workspace = {name = "special:sysmon";};
                }
              ];
              command = ["kitty" "--app-id" "btop" "-T" "btop" "fish" "-C" "exec btop"];
            };
          };
          todo = {
            todoist = {
              enable = false;
            };
          };
        };
      };
    };
  };
}
