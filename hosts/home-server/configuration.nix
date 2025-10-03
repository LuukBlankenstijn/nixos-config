{ ... }:
{
  networking.hostName = "home-server";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=ignore
    IdleAction=ignore
  '';

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}

