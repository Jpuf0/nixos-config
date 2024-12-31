{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkMerge mkIf;
  inherit (lib.types) enum str bool;

  cfg = config.sakura.system.hardware.gpu;
in {
  options.sakura.system.hardware.gpu = {
    type = mkOption {
      type = enum ["nvidia" "amd"];
      description = "GPU type";
      default = "nvidia";
    };

    nvidia = {
      prime = {
        sync.enable = mkEnableOption "Enable Nvidia Prime sync";
        reverseSync.enable = mkEnableOption "Enable Nvidia Prime reverse sync";
        allowExternalGPU = mkEnableOption "Allow external GPUs to be used";
        offload = {
          enable = mkEnableOption "Enable Nvidia Prime offload";
          enableOffloadCmd = mkEnableOption "Enable nvidia-offload command";
        };
        nvidiaBusId = mkOption {
          type = str;
          description = "Nvidia Bus ID";
          example = "PCI:14:0:0";
        };
        intelBusId = mkOption {
          type = str;
          description = "Intel Bus ID";
          example = "PCI:0:2:0";
        };
        amdgpuBusId = mkOption {
          type = str;
          description = "AMDGPU Bus ID";
          example = "PCI:54:0:0";
        };
      };
      powerManagement = {
        enabled = mkOption {
          type = bool;
          description = "Enable Nvidia power management";
          default = true;
        };
        finegrained = mkOption {
          type = bool;
          description = "Enable Nvidia finegrained power management";
          default = false;
        };
      };
      open = mkOption {
        type = bool;
        description = "Enable Nvidia Open";
        default = true;
      };
      nvidiaSettings = mkOption {
        type = bool;
        description = "Enable Nvidia settings";
        default = true;
      };
      package = lib.mkOption {
        example = "config.boot.kernelPackages.nvidiaPackages.legacy_470";
        description = "The NVIDIA driver package to use";
        default = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };

  config = mkMerge [
    (mkIf (cfg.type == "amd") {
      # TODO: Add support for AMDGPU
      hardware.amdgpu.opencl.enable = true;
      services.xserver.videoDrivers = ["amdgpu"];

      boot = {
        initrd.kernelModules = ["amdgpu"];
        kernelModules = ["kvm-amd"];
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
          libdrm
          libva
          rocmPackages.clr
          rocmPackages.clr.icd
        ];

        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
          driversi686Linux.libvdpau-va-gl
        ];
      };

      environment.variables = {
        VDPAU_DRIVER = "radeonsi";
        LIBVA_DRIVER_NAME = "radeonsi";
        AMD_VULKAN_ICD = "RADV";
      };

      systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
      ];
    })

    (mkIf (cfg.type == "nvidia") {
      services.xserver.videoDrivers = ["nvidia"];

      hardware = {
        nvidia = {
          modesetting.enable = true;
          powerManagement = {
            enable = false;
            finegrained = false;
          };

          prime = {
            nvidiaBusId = cfg.nvidia.prime.nvidiaBusId;
            intelBusId = cfg.nvidia.prime.intelBusId;
            amdgpuBusId = cfg.nvidia.prime.amdgpuBusId;

            sync.enable = cfg.nvidia.prime.sync.enable;

            reverseSync.enable = cfg.nvidia.prime.reverseSync.enable;
            allowExternalGpu = cfg.nvidia.prime.allowExternalGPU;

            offload = {
              enable = cfg.nvidia.prime.offload.enable;
              enableOffloadCmd = cfg.nvidia.prime.offload.enableOffloadCmd;
            };
          };

          open = cfg.nvidia.open;
          nvidiaSettings = cfg.nvidia.nvidiaSettings;
          package = cfg.nvidia.package;
        };

        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };
    })
  ];
}
