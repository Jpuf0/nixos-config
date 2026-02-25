{pkgs, ...}: {
  home.packages = with pkgs; [
    ydiff
    difftastic
    delta
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {pager = "delta --dark --paging=never";}
          {
            pager = "ydiff -p cat -s --wrap --width={{columnWidth}}";
            colorArg = "never";
          }
          {externalDiffCommand = "difft --color=always";}
        ];
      };
    };
  };
}
