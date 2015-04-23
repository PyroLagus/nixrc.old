{ config, pkgs, ... }:

{
  imports = [
    ../services/xserver.nix
    ../services/mpd.nix
  ];

  environment.systemPackages = with pkgs; [                
    (pkgs.ncmpcpp.override { outputsSupport = true; })
    (pkgs.pulseaudio.override { ossWrapper = true; })
    (pkgs.texLiveAggregationFun { paths = [ pkgs.texLive pkgs.texLiveExtra pkgs.texLiveBeamer pkgs.lmodern pkgs.tipa ]; })
    blender
    deadbeef
    dunst
    ffmpeg
    firefox-bin
    gimp
    haskellngPackages.xmobar
    keepassx2
    libnotify
    libreoffice
    mpc_cli
    mpv
    pavucontrol
    picard
    pidgin-with-plugins
    pkgs.python34Packages.livestreamer
    rxvt_perls
    rxvt_unicode
    thunderbird
    xcompmgr # for transparent term
    xfontsel
    xlibs.xdpyinfo
    xorg.xhost
    xorg.xkill
    youtube-dl
    zathura
  ];
  
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fira
      inconsolata
      lmodern
    ];
  };

  nixpkgs.config.packageOverrides = pkgs:
  {
    bluez = pkgs.bluez5; # Use newer version of bluez.
    pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
      plugins = [ pkgs.pidginotr ];
    };
  };
} 
