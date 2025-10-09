{ config, pkgs, lib, ... }:
let
  genScript = pkgs.writeShellScript "gen-age-key" ''
    set -euo pipefail
    umask 077
    mkdir -p /var/lib/sops
    if [ ! -s /var/lib/sops/host.agekey ]; then
      ${pkgs.age}/bin/age-keygen -o /var/lib/sops/host.agekey
    fi
    # Always (re)derive the public key from the private key
    ${pkgs.age}/bin/age-keygen -y /var/lib/sops/host.agekey > /var/lib/sops/host.pub
    chmod 600 /var/lib/sops/host.agekey
    chmod 644 /var/lib/sops/host.pub
  '';
in {
  systemd.tmpfiles.rules = [ "d /var/lib/sops 0700 root root -" ];

  systemd.services.gen-age-key = {
    description = "Generate Age keypair for sops-nix";
    wantedBy = [ "multi-user.target" ];
    after  = [ "local-fs.target" "systemd-tmpfiles-setup.service" ];
    wants  = [ "systemd-tmpfiles-setup.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = genScript;
    };
  };

  # sops-nix uses this key
  sops.age.keyFile = "/var/lib/sops/host.agekey";
}

