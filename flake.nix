{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    ssh-keys = { url = "https://github.com/LuukBlankenstijn.keys"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
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
          ./modules/common-server.nix
          ./hosts/headscale-box/hardware-configuration.nix
          ./hosts/headscale-box/configuration.nix
        ];
      };
    };
}

