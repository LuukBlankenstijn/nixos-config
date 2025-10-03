{
  services.tailscale = {
      enable = true;
      openFirewall = true;
      extraUpFlags = [
        "--login-server" "https://headscale.luukblankenstijn.nl"
      ];
      extraSetFlags = [
        "--operator=luuk"
      ];
    };
}
