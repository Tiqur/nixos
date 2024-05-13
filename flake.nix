{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, unstable, ... }@inputs: {
    nixosConfigurations = {
      tiqur-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
        ./configuration.nix
        ];
      };
    };
  };
}
