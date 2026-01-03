{pkgs, ...}: {
  config = {
    boot.initrd.kernelModules = ["i915"];

    hardware = {
      graphics = {
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau-va-gl
          nvidia-vaapi-driver
          intel-media-driver
        ];
      };
    };
  };
}
