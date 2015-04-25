{ config, pkgs, ... }:

{
  networking.wireless.enable = true;
  hardware.bluetooth.enable = true;
  #synaptics.enable = true;
}
