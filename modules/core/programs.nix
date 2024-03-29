{pkgs, ...}: {
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # pinentryFlavor = "";
  };
  programs.ssh.startAgent = true;
}
