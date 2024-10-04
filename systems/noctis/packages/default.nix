{
  config,
  pkgs,
  ...
}: let
  inherit (config.sakura.system.user) username;

  inherit (config.sakura.theme) catppuccin;
in {
  home-manager.users."${username}" = {
    home.packages = with pkgs; [
      bitwise # cli tool for bit / hex manipulation
      eza # ls replacement
      entr # perform action when file change
      file # Show file information
      fzf # fuzzy finder
      jdk
      libreoffice
      nitch # systhem fetch util
      nix-prefetch-github
      pipx # Install Python applications in isolated environments
      prismlauncher # minecraft launcher
      ripgrep # grep replacement
      toipe # typing test in the terminal
      nemo-with-extensions # file manager
      yazi # terminal file manager
      yt-dlp
      zenity

      # C / C++
      gcc
      gnumake
      gdb

      # Python
      python3

      nil

      # Node
      nodejs
      bun

      dotnet-sdk_8

      bleachbit # cache cleaner
      cmatrix
      gparted # partition manager
      ffmpeg
      imv # image viewer
      libnotify
      man-pages # extra man pages
      mpv # video player
      ncdu # disk space
      openssl
      pamixer # pulseaudio command line mixer
      pavucontrol # pulseaudio volume controle (GUI)
      playerctl # controller for media players
      unzip
      wget
      jq
      bluez
      telegram-desktop
      pywal
      dnsutils
      audacious-plugins
      alacritty
      gimp
      docker
      bottles
      steamtinkerlaunch
      wine64
      winetricks
      gamemode
      gamescope
      r2modman
      ryujinx
      gallery-dl
      qbittorrent
      mullvad-vpn
      obs-studio
      gargoyle
      remmina
      spotify-player
      ollama
      simplex-chat-desktop
      blender
      nix-ld
      sunshine
      moonlight-qt
      firefox
      zed-editor
      craftos-pc
      vdhcoapp
      spotify
      heroic
      cmake
    ];

    programs.git = {
      enable = true;

      userName = "jpuf0";
      userEmail = "jpuf@jpuf.xyz";

      signing = {
        key = "847A356BD6C0BADBBE5FE93EF9BE92F02750551B";
        signByDefault = true;
      };

      delta = {
        enable = true;
        options = {
          line-numbers = true;
        };
      };

      extraConfig = {
        init.defaultBranch = "mistress";
        push = {
          autoSetupRemote = true;
          default = "current";
        };
      };

      ignores = [
        "node_modules"
      ];
    };

    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Dracula";
      };
    };

    gtk = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = catppuccin.flavor;
          accent = catppuccin.accent;
        };
      };
      theme = {
        name = "Catppuccin-Mocha-Compact-Lavender-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [
            catppuccin.accent
          ];
          size = "compact";
          # tweaks = [ "rimless" ];
          variant = catppuccin.flavor;
        };
      };

      cursorTheme = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 22;
      };
    };
  };
}
