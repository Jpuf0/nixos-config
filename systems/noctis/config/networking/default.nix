{
  networking = {
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.enable = true;
    networkmanager.dns = "none";

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"

      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [22 53 80 443 39361 59010 59011];
      allowedUDPPorts = [53 59010 39361 59011];
    };
  };
}
