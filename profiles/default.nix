{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    emacs
    git
    htop
    hunspell
    hunspellDicts.en-us
    imagemagick
    links2
    mc
    netcat
    psmisc
    screen
    screenfetch
    telnet
    tmux
    unrar
    unzip
    w3m
    weechat
    wget
    zsh
  ];
}
