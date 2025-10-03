{
  services.traefik = {
    enable = true;
    dataDir = "/var/lib/traefik";

    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure.address = ":443";
      };

      api.dashboard = false;

      certificatesResolvers.lets.acme = {
        email = "luukblankenstijn@gmail.com";
        storage = "/var/lib/traefik/acme.json";
        httpChallenge.entryPoint = "web";
      };
    };

    dynamicConfigOptions = {
      http = {
        routers.headscale = {
          rule = "Host(`headscale.luukblankenstijn.nl`)";
          entryPoints = [ "websecure" ];
          service = "headscale";
          tls.certResolver = "lets";
        };

        services.headscale.loadBalancer.servers = [
          { url = "http://127.0.0.1:8080"; }
        ];
      };

      tcp = {
        routers.other = {
          entryPoints = [ "websecure" ];
          rule = "HostSNI(`*`)";
          service = "other";
          tls.passthrough = true;
        };

        services.other.loadBalancer.servers = [
          { address = "home-server:443"; }
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
