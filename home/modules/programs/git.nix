{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    # git-lfs
    delta
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "jpuf0";
        email = "jpuf@jpuf.xyz";
      };

      # Sign all commits using ssh key
      # gpg.format = "ssh";
      # user.signingkey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
        default = "current";
      };

      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };

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

    ignores = [
      "node_modules"
    ];
  };
}
