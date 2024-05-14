{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };

      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };


      username = "tiqur";
      name = "Trevor";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        tiqur-nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [ ./configuration.nix ];

          #https://youtu.be/hlytf6Uxf4E?t=225
          specialArgs = {
            inherit username;
            inherit name;
            inherit pkgs-unstable;
          };
        };
      };
    };
}
