{
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) optional strings;

  isLaptop = osConfig.networking.hostName == "ghost";

  on = id: {
    enabled = true;
    inherit id;
  };
  off = id: {
    enabled = false;
    inherit id;
  };

  vpnProvider = displayName: interface: connectCmd: disconnectCmd: {
    inherit displayName interface;
    name = strings.toLower displayName;
    connectCmd = [connectCmd];
    disconnectCmd = [disconnectCmd];
  };
in {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  home.packages = with pkgs; [
    pwvucontrol
  ];

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
        visualiser.enabled = true;
      };

      bar = {
        scrollActions = {
          brightness = false;
        };
        tray = {
          hiddenIcons = ["gammastep" "nm-applet" "blueman"];
        };
        statusIcons = [
          (off "lockStatus")
          (on "audio")
          (off "microphone")
          (off "kbLayout")
          (on "network")
          (on "bluetooth")
          {
            enabled = isLaptop;
            id = "battery";
          }
        ];
        entries = [
          (on "logo")
          (on "workspaces")
          (on "spacer")
          (on "activeWindow")
          (on "spacer")
          (on "tray")
          (on "clock")
          (on "statusIcons")
          (on "power")
        ];
      };

      general = {
        apps = {
          terminal = ["kitty"];
          audio = ["pwvucontrol"];
          explorer = ["nemo"];
        };

        idle = {
          timeouts =
            [
              {
                timeout = 180;
                idleAction = "lock";
              }
              {
                timeout = 300;
                idleAction = "dpms off";
                returnAction = "dpms on";
              }
            ]
            ++ optional isLaptop {
              timeout = 600;
              idleAction = ["suspendThenHibernate"];
            };
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
        enableBrightness = isLaptop;
        enableMicrophone = !isLaptop;
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
          fullscreen = "important";
          kbLayoutChanged = false;
          kbLimit = false;
          nowPlaying = true;
        };
        vpn = {
          enabled = true;
          provider = [
            (vpnProvider "Tailscale" "tailscale0" "tailscale up --accept-routes" "tailscale down")
            (vpnProvider "Mullvad" "wg0-mullvad" "mullvad connect" "mullvad disconnect")
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
