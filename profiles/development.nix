{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    androidndk
    androidsdk_4_4
    atom
    binutils
    cmake
    patchelf
    python
    ruby
    valgrind
  ];
}
