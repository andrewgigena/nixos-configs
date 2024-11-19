{ pkgs, config, lib, modulesPath, ... }:

{
  # -----------------------
  # Nix things
  # -----------------------
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.05";

  # -----------------------
  # Bootloader
  # -----------------------
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  # -----------------------
  # Initrd
  # -----------------------
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];

  # -----------------------
  # Kernel things
  # -----------------------
  boot.kernelModules = [ "kvm-amd"];
  boot.extraModprobeConfig = "";
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=0"
  ];

  # -----------------------
  # Main disk
  # -----------------------
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [ "subvol=@root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [ "subvol=@persist" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/055C-B0AB";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  # -----------------------
  # Memory
  # -----------------------
  swapDevices = [ ];

  # -----------------------
  # Network
  # -----------------------
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "apollo";
  networking.networkmanager.enable = true;

  # -----------------------
  # Firmware
  # -----------------------
  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # -----------------------
  # Power Management
  # -----------------------
  powerManagement.enable = true;
  services.thermald.enable = true;

  # -----------------------
  # CPU Emulation
  # -----------------------
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];
}
