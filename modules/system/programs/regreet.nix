{config, pkgs, inputs, ...}: {
  services.displayManager.regreet = {
    enable = true;
    cageArgs = [ "-s" "-d" "-m" "last" ];
    settings = {
      default_session = {
        command = "env WLR_WL_OUTPUTS=DP-1 ${pkgs.cage}/bin/cage -s -- ${config.services.displayManager.regreet.package}/bin/regreet";
        # command = "${pkgs.cage}/bin/cage -s -- ${inputs.caelestia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/caelestia-greeter";
        user = "greeter";
      };
      gtk = {
        application_prefer_dark_theme = true;
      };
    };
  };
  security.pam.services.greetd.gnupg.enable = true;
}
