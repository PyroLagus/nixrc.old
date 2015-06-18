{ config, pkgs, ... }:

{
  networking.wireless.enable = true;
  hardware.bluetooth.enable = true;
  #synaptics.enable = true;

  environment.systemPackages = with pkgs; [
      bluez5
  ];

  nixpkgs.config.packageOverrides = pkgs:
  {
    bluez = pkgs.bluez5;
  };
}
