{pkgs, ...}: {
  config = {
    boot.initrd.kernelModules = ["i915"];

    hardware = {
      opengl = {
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
          nvidia-vaapi-driver
          intel-media-driver
        ];
      };
    };
  };
}
