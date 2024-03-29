{
  pkgs,
  username,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "jpuf0";
    userEmail = "jpuf@jpuf.xyz";

    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  home.packages = [pkgs.gh pkgs.git-lfs];
}
