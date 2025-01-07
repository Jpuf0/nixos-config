{config, ...}: {
  imports = [
    ./cache
    ./config
    ./packages
    ./fonts
  ];

  sakura = {
    home-manager = {
      enable = true;
      enableDirenv = true;
    };

    system = {
      hostname = "noctis";
      user = {
        username = "jpuf";
        description = "hehe";
        initialPassword = "test";
        extraGroups = [
          "networkmanager"
          "docker"
        ];
      };

      timezone = "Europe/London";
      locale = "en_US.UTF-8";

      hardware = {
        gpu = {
          type = "nvidia";
          nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.beta;
            open = true;
          };
        };
        cpu.type = "intel";
      };

      services = {
        ssh.enable = true;
        polkit = {
          enable = true;
          agents = "kde";
        };
        pipewire.enable = true;
      };
    };

    xdg = {
      enable = true;
      default_browser = "zen";
      default_editor = "vscodium";
      default_terminal = "kitty";
    };

    theme.catppuccin = {
      enable = true;
      enableQT = true;
      flavor = "mocha";
      accent = "lavender";
    };

    programs = {
      browsers = {
        zen.enable = true;
      };

      hyprland = {
        enable = true;
        # monitors = [
        #   "DP-2,1920x1080@240,0x0,1"
        #   "HDMI-A-1,1920x1080@60,1920x0,1"
        # ];
      };

      shells = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableAutosuggestion = true;
          omz.enable = true;
        };
      };

      prompt = {
        starship = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
      };

      terminals = {
        kitty.enable = true;
      };

      vesktop.enable = true;
      steam.enable = true;
      opentablet.enable = true;
      corectrl.enable = true;
      easyeffects.enable = true;
      btop.enable = true;
    };
  };
}
