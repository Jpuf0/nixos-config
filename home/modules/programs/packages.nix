{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  self_pkgs = inputs.self.packages.${system};
  aagl = inputs.aagl.packages.${system};
  llm-agents = inputs.llm-agents.packages.${system};
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
    # glances
    bottom
    cheat
    tldr
    bandwhich
    fd
    ouch

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
    nix-alien
    hyprpicker
    gifski
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
    qFlipper

    self_pkgs.amethyst-mod-manager

    gpauth
    gpclient

    distrobox
    distrobox-tui

    # LLM/AI Stuff
    claude-desktop-fhs # https://github.com/aaddrick/claude-desktop-debian, FHS-compatible sandboxed version of the desktop app.
    llm-agents.chatgpt

    # claude-code            # https://github.com/sadjow/claude-code-nix, modules/system/config/nix/nixpkgs.nix#L11
    llm-agents.claude-code # https://numtide.github.io/llm-agents.nix, LLM-agents packaged version.
    llm-agents.oh-my-claudecode

    llm-agents.codex
    llm-agents.oh-my-codex

    llm-agents.t3code-desktop

    llm-agents.ccstatusline
    # llm-agents.ccusage
    llm-agents.voxtype
    # llm-agents.agentsview
    llm-agents.ctx
    llm-agents.skills
    llm-agents.qmd
    # (llm-agents.qmd.override {
    #   cudaSupport = true;
    #   cudaPackages = pkgs.cudaPackages;
    # })

    # Local LLM Stuff
    llmfit
    llmserve
    # gollama
    # lmstudio
  ];
  home.sessionVariables = {
    # Because dotnet is a fucking rat
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };
}
