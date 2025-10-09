{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    sops-nix.url = "github:Mic92/sops-nix";
    ssh-keys = { url = "https://github.com/LuukBlankenstijn.keys"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, sops-nix, ... }:
    let
      mkHost = modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = modules;
	  specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        headscale-box = mkHost [
          sops-nix.nixosModules.sops
          ./modules/common-server.nix
          ./hosts/headscale-box/hardware-configuration.nix
          ./hosts/headscale-box/configuration.nix
        ];

        home-server = mkHost [
          sops-nix.nixosModules.sops
          ./modules/common-server.nix
          ./hosts/home-server/hardware-configuration.nix
          ./hosts/home-server/configuration.nix
        ];
      };
    };
}

