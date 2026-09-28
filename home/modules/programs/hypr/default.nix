{
  inputs,
  pkgs,
  lib,
  ...
}: let
  # Upstream caelestia-dots Hyprland config (flake = false input)
  upstream = "${inputs.caelestia-dots}/hypr";

  # Local replacements for upstream files, same relative layout
  # (e.g. ./overrides/hyprland/keybinds.lua replaces hyprland/keybinds.lua)
  overrides = ./overrides;

  # Relative paths only; attribute names can't carry store path context
  relFiles = dir:
    map (f: builtins.unsafeDiscardStringContext (lib.removePrefix "${toString dir}/" (toString f)))
    (lib.filesystem.listFilesRecursive dir);

  # Upstream execs.lua with the Arch-only lines removed; NixOS runs these as services:
  #   /usr/lib/polkit-gnome/...  -> systemd.user.services.polkit-gnome (polkit-kde.nix)
  #   /usr/lib/geoclue-2.0/...   -> services.geoclue2
  execs = lib.pipe (builtins.readFile "${upstream}/hyprland/execs.lua") [
    (lib.splitString "\n")
    (lib.filter (l: !(lib.hasInfix "/usr/lib/" l)))
    (lib.concatStringsSep "\n")
  ];

  link = f: {
    name = "hypr/${f}";
    value =
      if builtins.pathExists (overrides + "/${f}")
      then { source = overrides + "/${f}"; }
      else if f == "hyprland/execs.lua"
      then { text = execs; }
      else { source = "${upstream}/${f}"; };
  };

  # Written to ~/.config/caelestia/hypr-vars.lua; upstream's hyprland.lua merges
  # this table over hypr/variables.lua. Any key from variables.lua can go here.
  vars = {
    terminal = "kitty";
    browser = "zen-beta";
    editor = "zeditor";
    fileExplorer = "nemo";
    audioSettings = "pavucontrol";
    cursorTheme = "Nordzy-cursors";
    cursorSize = 22;

    kbLauncher = "SUPER + D";
    kbCommunicationWs = "SUPER + SHIFT + D"; # was on SUPER + D
    kbCloseWindow = "SUPER + C";
    kbEditor = "SUPER + SHIFT + C";           # was on SUPER + C
    kbColorPicker = "SUPER + CTRL + C";       # was on SUPER + SHIFT + C
    kbTerminal = ["SUPER + T" "SUPER + Return"];
    kbMoveWinToWs = "SUPER + SHIFT";          # SUPER + SHIFT + 1…0, but see below
  };
in {
  home.packages = with pkgs; [
    cliphist
    wl-clipboard-rs
    hyprpicker
    fuzzel
    ydotool
    trash-cli
    gammastep
    libnotify
  ];

  # Every file is linked individually so ~/.config/hypr/scheme stays a real,
  # writable directory: hyprland.lua creates scheme/current.lua there on first
  # start and `caelestia scheme set` rewrites it.
  xdg.configFile =
    lib.listToAttrs (map link (lib.unique (relFiles upstream ++ relFiles overrides)))
    // {
      "caelestia/hypr-vars.lua".text = "return ${lib.generators.toLua {} vars}\n";
      "caelestia/hypr-user.lua".source = ./hypr-user.lua;
    };
}
