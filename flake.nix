{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

    #https://github.com/0xc000022070/zen-browser-flake
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.47.0";
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.47.0";
      inputs.hyprland.follows = "hyprland";
    };
    waybar = {
      url = "github:Alexays/waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      hyprland,
      hy3,
      impermanence,
      ...
    }@inputs:
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          ./hosts/shared.nix
        ];
      };
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/wifi.nix
          ./hosts/laptop/tlp.nix
          ./hosts/shared.nix
        ];
      };
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          impermanence.nixosModules.impermanence
          ./hosts/server/configuration.nix
          ./hosts/server/hardware-configuration.nix
        ];
      };
    };
}
