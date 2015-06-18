{ config, pkgs, ...  }:

{
  environment.systemPackages = with pkgs; [
    steam
    xonotic
    minetest
    nethack
    voxelands
  ];
}
