{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    git-lfs
    delta
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
      # Sign all commits using ssh key
      # gpg.format = "ssh";
      # user.signingkey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
        default = "current";
      };
    };

    ignores = [
      "node_modules"
    ];
  };
}
