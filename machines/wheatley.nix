{ config, pkgs, ... }:

{
  imports =
  [
    ../profiles/desktop.nix
    ../profiles/laptop.nix
    ../profiles/development.nix
    ../profiles/games.nix
  ];

  #networking.hostName = "wheatley";
  
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  hardware = {
    opengl.driSupport32Bit = true;
  };

  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 6600 8000 ];
    allowedUDPPorts = [ 8000 ];
  };
}
