{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
    firewall = {
      enable = true;
      allowedTCPPorts = [22 53 80 443 59010 59011];
      allowedUDPPorts = [53 59010 59011];
    };
  };

  programs = {
    nm-applet.enable = true;
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
