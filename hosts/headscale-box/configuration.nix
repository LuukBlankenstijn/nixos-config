{ ... }:
{
  networking.hostName = "headscale-box";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}

