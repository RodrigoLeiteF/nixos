# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];


  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernel.sysctl = { "vm.swappiness" = 0; };
  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [
    "kvm-amd"
    "amdgpu"
    # "vfio_virqfd"
    # "vfio_pci"
    # "vfio_iommu_type1"
    # "vfio"
  ];
  boot.extraModulePackages = [ ];

  services.xserver.videoDrivers = ["amdgpu"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5dac99e1-1850-4b49-8154-0739a1f22716";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8A7A-9713";
    fsType = "vfat";
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/673fc3ca-f732-48b4-9b49-13c5d104f3cd";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  swapDevices = [ ];

}