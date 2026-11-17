{
  pkgs,
  osConfig,
  ...
}: let
  isLaptop = osConfig.networking.hostName == "ghost";

  gpgSigning = key: {
    format = "openpgp";
    signByDefault = true;
    key = key;
  };
in {
  home.packages = with pkgs; [
    gh
    # git-lfs
    delta
    better-commits
  ];

  programs.delta = {
    enable = true;
    options = {
      line-numbers = true;
    };
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

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

    signing =
      if isLaptop
      then gpgSigning "D7867359D50E58A0AC1254DDD43EE2D9DCEDFDBA"
      else gpgSigning "847A356BD6C0BADBBE5FE93EF9BE92F02750551B";

    ignores = [
      "node_modules"
    ];
  };
}
