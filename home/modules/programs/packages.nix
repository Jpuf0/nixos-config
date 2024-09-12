{
  inputs,
  pkgs,
  ...
}: {
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
    xdg-utils
    # runelite
    jq
    bluez
    telegram-desktop
    pywal
    dnsutils
    audacious-plugins
    alacritty
    gimp
    usbmuxd
    libimobiledevice
    ifuse
    usbutils
    docker
    bottles
    steamtinkerlaunch
    wine64
    winetricks
    gamemode
    gamescope
    nvtopPackages.full
    r2modman
    ryujinx
    gallery-dl
    maliit-keyboard
    maliit-framework
    wvkbd
    qbittorrent
    easyeffects
    carla
    yabridge
    yabridgectl
    mullvad-vpn
    gleam
    erlang
    rebar3
    obs-studio
    syncthing
    lightspark
    gargoyle
    remmina
    # prisma-engines
    spotify-player
    ollama
    simplex-chat-desktop
    blender
    nix-ld
    sunshine
    moonlight-qt
    firefox
    desmume
    zed-editor
    craftos-pc
  ];
}
