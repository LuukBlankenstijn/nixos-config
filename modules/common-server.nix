{ inputs, lib, pkgs, ... }:
{
  imports = [ ./common.nix ];

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  users.users.luuk.openssh.authorizedKeys.keyFiles = [
    inputs.ssh-keys.outPath
  ];

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}

