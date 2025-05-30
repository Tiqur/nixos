# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fc10ca81-dd80-4a1e-9385-95d19935263e";
    fsType = "ext4";
  };

  #fileSystems."/nix" =
  #  { device = "/dev/disk/by-uuid/fc10ca81-dd80-4a1e-9385-95d19935263e";
  #    fsType = "ext4";
  #  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BDEE-7450";
    fsType = "vfat";
  };

  fileSystems."/storage/tank" = {
    device = "/dev/disk/by-uuid/a2f7bcc4-7725-4c12-8054-91a9332c357e";
    fsType = "btrfs";
    options = [
      "defaults"
      "compress=zstd"
      "nofail"
    ];
  };

  fileSystems."/storage/bucket" = {
    device = "/dev/disk/by-uuid/d7a66aa4-7623-4f4c-b2ed-1921c5c011d6";
    fsType = "btrfs";
    options = [
      "defaults"
      "compress=zstd"
      "nofail"
    ];
  };

  fileSystems."/storage/secrets" = {
    device = "/dev/disk/by-uuid/5726f408-a734-4960-bc0f-26cfecfb53c8";
    fsType = "ext4";
  };
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
