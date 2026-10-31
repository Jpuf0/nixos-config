# Fish shell aliases
{
  q = "exit";
  where = "whereis";
  nix-shell = "nix-shell --run fish";

  # File operations
  ll = "eza -la";
  la = "eza -la";
  ls = "eza -l";
  lt = "eza --tree";
  tree = "eza -T";
  dsize = "du -hs";

  # Directory navigation
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";

  # Screenshots (using grimblast with notifications)
  # ss = "grimblast --notify copy area"; # Screenshot area to clipboard
  # ssf = "grimblast --notify save area"; # Screenshot area to file
  # sss = "grimblast --notify copy screen"; # Screenshot screen to clipboard
  # sssf = "grimblast --notify save screen"; # Screenshot screen to file
  # ssw = "grimblast --notify copy active"; # Screenshot window to clipboard
  # sswf = "grimblast --notify save active"; # Screenshot window to file

  # Git shortcuts
  g = "git";
  gs = "git status";
  ga = "git add";
  gc = "git commit -m";
  gp = "git push";
  gl = "git log --oneline";
  gd = "git diff";
  gb = "git branch";
  gco = "git checkout";

  # System shortcuts
  c = "clear";
  h = "history";

  # Development
  v = "nvim";
  nv = "nvim";
  vim = "nvim";

  # Networking
  ping = "ping -c 5";

  # File viewing
  cat = "bat --style=auto";
  grep = "rg";

  # System monitoring
  top = "btop";
  htop = "btop";

  # Safety nets
  cp = "cp -i";
  mv = "mv -i";

  # Kitty
  icat = "kitty icat";
}
