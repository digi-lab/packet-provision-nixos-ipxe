{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs:
      { linux_4_15 = pkgs.linux_4_15.override {
          extraConfig =
            ''
              MLX5_CORE_EN y
            '';
        };
      };

  boot.kernelPackages = pkgs.linuxPackages_4_15;
  boot.initrd.availableKernelModules = [
    "ahci" "xhci_pci" "mpt3sas" "nvme" "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams =  [ "console=ttyS1,115200n8" ];
  boot.extraModulePackages = [ ];

  hardware.enableAllFirmware = true;

  nix.maxJobs = 56;
}
