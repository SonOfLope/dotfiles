# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = { 
      initrd = {  
        availableKernelModules = [ 
          "xhci_pci" 
          "nvme"
          "ahci" 
          "usb_storage" 
          "sd_mod" 
        ];
        kernelModules = [ ];
      };

      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };


  fileSystems."/" =
    { 
      device = "/dev/disk/by-uuid/7ef373eb-21d3-471f-92e1-a640804eb8e6";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { 
      device = "/dev/disk/by-uuid/31BB-8197";
      fsType = "vfat";
    };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
