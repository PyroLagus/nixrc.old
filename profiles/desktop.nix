{ config, pkgs, ... }:

{
  imports = [
    ../services/xserver.nix
    ../services/mpd.nix
  ];

  nixpkgs.config.allowUnfree = true;

  hardware.pulseaudio.enable = true;
  
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  environment.systemPackages = with pkgs; [                
    (pkgs.ncmpcpp.override { outputsSupport = true; })
    (pkgs.texLiveAggregationFun { paths = [ pkgs.texLive pkgs.texLiveExtra pkgs.texLiveBeamer pkgs.lmodern pkgs.tipa ]; })
    (pkgs.mumble.override { pulseSupport = true; })
    blender
    deadbeef
    dunst
    ffmpeg
    #(lib.singleton (pkgs.wrapFirefox { browser = pkgs.firefox-bin; }))
    #firefox-bin-wrapper
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
    rxvt_unicode
    thunderbird-bin
    urxvt_perls
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
      fira-mono
      inconsolata
      lmodern
    ];
  };

  nixpkgs.config.packageOverrides = pkgs:
  {
    bluez = pkgs.bluez5;
    pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
      plugins = [ pkgs.pidginotr ];
    };
  };
} 
