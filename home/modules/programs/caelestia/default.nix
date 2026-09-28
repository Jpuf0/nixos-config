{inputs, ...}: let
  font = "CaskaydiaCove NF";

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
      enable = true;
      target = "graphical-session.target";
      environment = [];
    };

    settings = {
      appearance = {
        # font = {
        #   clock = "IBM Plex Sans";
        #   workspaces = font;
        #   body.family = font;
        #   label.family = font;
        #   title.family = font;
        #   headline.family = font;
        # };
      };

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
          (off "battery")
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

      border = {

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
        enableBrightness = false;
        enableMicrophone = true;
      };

      services = {
        clockFormat = "TwentyFourHour";
        weatherUnits = "Celsius";
      };

      utilities = {};
    };

    cli = {
      enable = true;
      settings = {

      };
    };
  };
}
