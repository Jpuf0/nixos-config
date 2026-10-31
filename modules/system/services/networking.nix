{pkgs, ...}: {
  services.resolved.enable = true;

  networking = {
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        # ASK4 registers devices by MAC, so keep the card's real address
        macAddress = "permanent";
      };
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };

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
      checkReversePath = "loose";
      interfaces = {
        ap0.allowedUDPPorts = [67 53 5355];
        wlan0.allowedUDPPorts = [67 53 5355];
        tailscale0.allowedTCPPorts = [5900 11434];
      };
    };

    nftables = {
      enable = true;

      tables.mullvad_tailscale = {
        family = "inet";
        content = ''
          chain output {
            type route hook output priority -100; policy accept;
            ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65
            ip6 daddr fd7a:115c:a1e0::/48 ct mark set 0x00000f41 meta mark set 0x6d6f6c65
          }
          chain input {
            type filter hook input priority -100; policy accept;
            iifname "tailscale0" ct mark set 0x00000f41 meta mark set 0x6d6f6c65
          }
        '';
      };
    };
  };

  programs = {
    nm-applet.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   networkmanagerapplet
  # ];
}
