{config, ...}: {
  boot = {
    initrd.availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel" "wl" "v4l2loopback"];
    extraModulePackages = with config.boot.kernelPackages; [broadcom_sta v4l2loopback];
    extraModprobeConfig = ''
      options v4l2loopback video_nr=9 card_label=Video-Loopback exclusive_caps=1
    '';
  };
}
