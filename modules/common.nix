{ lib, pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./tailscale.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Amsterdam";

  networking.useDHCP = lib.mkDefault true;

  environment.systemPackages = with pkgs; [ 
    git 
    vim 
    bind
    jq
  ];

  users.users.luuk = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.05";
}

