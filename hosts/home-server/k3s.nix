{ pkgs, ... }: {
  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;

    extraFlags =
      [ "--write-kubeconfig-mode=0644" "--etcd-expose-metrics=true" ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 6443 10250 2379 2380 10257 10259 ];
    allowedUDPPorts = [ 8472 51820 ];
  };

  boot.kernelModules = [ "br_netfilter" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.bridge.bridge-nf-call-ip6tables" = 1;
  };

  networking.nftables.enable = true;

  environment.systemPackages = with pkgs; [ k9s ];
}
