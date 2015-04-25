{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    androidndk
    androidsdk_4_4
    atom
    binutils
    cmake
    haskellngPackages.yi
    patchelf
    python
    ruby
    valgrind
  ];
}
