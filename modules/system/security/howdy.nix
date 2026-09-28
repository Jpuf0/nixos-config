{...}: {
  services.howdy = {
    enable = true;
    settings.video.device_path = "/dev/video2";
  };

  services.linux-enable-ir-emitter = {
    enable = true;
    device = "video2";
  };
}
