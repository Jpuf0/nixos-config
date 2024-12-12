{pkgs, ...}: {
  networking = {
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.enable = true;
    networkmanager.dns = "none";

    extraHosts = ''
      172.17.0.1 host.docker.internal
    '';

    nameservers = [
      # Cloudflare IPV4
      "1.1.1.1"
      "1.0.0.1"
      # # Google DNS
      # "8.8.8.8"
      # "8.8.4.4"
      # # Quad9 DNS IPV4
      # "9.9.9.9"
      # "149.112.112.112"

      # Cloudflare IPV6
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
      # # Google DNS IPV6
      # "2001:4860:4860::8888"
      # "2001:4860:4860::8844"
      # # Quad9 DNS IPV6
      # "2620:fe::fe"
      # "2620:fe::9"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [22 53 80 443 39361 59010 59011 8081];
      allowedUDPPorts = [53 59010 39361 59011 8081];
      trustedInterfaces = ["docker0"];
    };
  };

  programs = {
    nm-applet.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   networkmanagerapplet
  # ];
}
