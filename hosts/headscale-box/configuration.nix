{ ... }:
{
  networking.hostName = "headscale-box";

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    device = "/dev/sda";
  };
}

