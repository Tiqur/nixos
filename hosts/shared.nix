{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree # For writing the dir structure to README.md
  ];
}

