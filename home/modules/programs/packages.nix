{
  inputs,
  pkgs,
  ...
}: let
  pythonPkgs = pkgs.python312Packages;
  aagl = inputs.aagl.packages.${pkgs.stdenv.hostPlatform.system};
  # zed = pkgs.zed-editor.overrideAttrs (oa: {
  #   src = pkgs.fetchFromGitHub {
  #     owner = "zed-industries";
  #     repo = "zed";
  #     tag = "v{oa.version}";
  #     hash = "sha256-Q7Ord+GJJcOCH/S3qNwAbzILqQiIC94qb8V+JkzQqaQ=";
  #   };
  # });
in {
  home.packages = with pkgs; [
    bitwise # cli tool for bit / hex manipulation
    eza # ls replacement
    entr # perform action when file change
    file # Show file information
    fzf # fuzzy finder
    dua
    gdu
    gtop
    glances
    bottom
    cheat
    tldr
    bandwhich
    fd

    jdk
    libreoffice
    nitch # systhem fetch util
    nix-prefetch-github
    # pipx # Install Python applications in isolated environments
    uv
    prismlauncher # minecraft launcher
    ripgrep # grep replacement
    toipe # typing test in the terminal
    nemo-with-extensions # file manager

    yazi # terminal file manager
    ouch
    sox
    exiftool

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
    nodejs_latest
    bun

    # dotnet-sdk_9
    dotnet-sdk
    dotnet-ef

    bleachbit # cache cleaner
    cmatrix
    gparted # partition manager
    ffmpeg
    imv # image viewer
    libnotify
    man-pages # extra man pages
    mpv # video player
    ncdu # disk space
    # openssl
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio volume controle (GUI)
    playerctl # controller for media players
    unzip
    wget
    xdg-utils
    jq
    bluez
    telegram-desktop
    pywal
    dnsutils
    # gimp
    usbmuxd
    libimobiledevice
    ifuse
    usbutils
    docker
    ctop
    # bottles-unwrapped
    protonup-qt
    # steamtinkerlaunch
    xdotool
    xprop
    unixtools.xxd
    xwininfo
    xrandr
    yad

    # wine64
    winetricks
    p7zip
    gamemode
    gamescope
    # nvtopPackages.full
    r2modman
    ryubing
    gallery-dl
    wvkbd
    qbittorrent
    easyeffects
    # yabridge
    # yabridgectl
    mullvad-vpn
    gleam
    beamPackages.erlang
    rebar3
    obs-studio
    syncthing
    # gargoyle
    remmina
    spotify-player

    # gollama
    # lmstudio

    sunshine
    moonlight-qt
    firefox
    zed-editor
    # zed
    # vdhcoapp
    # spotify # now provided by spicetify
    # heroic
    cmake
    jetbrains-toolbox
    pnpm
    dmenu
    # nix-alien
    hyprpicker
    gifski
    # pythonPkgs.tensorflowWithCuda
    mangohud
    # mangojuice
    # gale
    piper
    # lutris

    unityhub
    vrc-get

    opencode
    grc
    runelite
    obsidian
    dysk

    # inputs.hytale-launcher.packages.${pkgs.system}.default
    winboat
    stoat-desktop
    # virt-manager
    linux-wifi-hotspot
    # clamav

    # aagl.honkers-railway-launcher
    # aagl.honkers-launcher
    # aagl.sleepy-launcher

    claude-code
  ];
  home.sessionVariables = {
    # Because dotnet is a fucking rat
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };
}
