{
  inputs,
  pkgs,
  ...
}: let
  pythonPkgs = pkgs.python3Packages;
in {
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
    # pipx # Install Python applications in isolated environments
    uv
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
    openssl
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
    gimp
    usbmuxd
    libimobiledevice
    ifuse
    usbutils
    docker
    bottles-unwrapped
    protonup-qt
    # steamtinkerlaunch
    xdotool
    xorg.xprop
    unixtools.xxd
    xorg.xwininfo
    xorg.xrandr
    yad

    # wine64
    winetricks
    protontricks
    p7zip
    gamemode
    gamescope
    nvtopPackages.full
    r2modman
    ryujinx
    gallery-dl
    wvkbd
    qbittorrent
    easyeffects
    yabridge
    yabridgectl
    mullvad-vpn
    # gleam
    # erlang
    # rebar3
    obs-studio
    syncthing
    gargoyle
    remmina
    spotify-player

    gollama
    # lmstudio

    sunshine
    moonlight-qt
    firefox
    zed-editor
    vdhcoapp
    # spotify # now provided by spicetify
    heroic
    cmake
    jetbrains-toolbox
    nodePackages_latest.pnpm
    dmenu
    nix-alien
    hyprpicker
    gifski
    pythonPkgs.tensorflowWithCuda
    mangohud
    mangojuice
    gale
    piper
  ];
  home.sessionVariables = {
    # Because dotnet is a fucking rat
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };
}
