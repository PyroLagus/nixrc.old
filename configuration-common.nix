{ config, lib, pkgs, ... }:

with lib;
rec {
  imports = [
    ./profiles/default.nix
  ];

  # nixpkgs.config.allowUnfree = true; # maybe put this into games

  boot = {
    # See console messages during early boot.
    initrd.kernelModules = [ "fbcon" ];

    # Disable console blanking after being idle.
    kernelParams = [ "consoleblank=0" ];
  };

  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  users.extraUsers.codehero = {
    name = "codehero";
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "mpd" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  users.extraGroups.codehero.gid = 1000;

  services.nixosManual.showManual = true;

  system.activationScripts =
  {
    # Configure dotfiles.
    dotfiles = stringAfter [ "users" ]
    ''
      cd /home/codehero
      ln -fs ${./dotfiles/aliases} .aliases
      ln -fs ${./dotfiles/bash_profile} .bash_profile
      ln -fs ${./dotfiles/bashrc} .bashrc
      ln -fsn ${./dotfiles/bin} bin
      mkdir .cabal 2>/dev/null || true
      chown codehero:users .cabal
      ln -fs ${./dotfiles/cabal/config} .cabal/config
      ln -fs ${./dotfiles/dmrc} .dmrc
      mkdir .emacs.d 2>/dev/null || true
      chown codehero:users .emacs.d
      ln -fs ${./dotfiles/emacs.d/emacs.org} .emacs.d/emacs.org
      ln -fs ${./dotfiles/emacs.d/init.el} .emacs.d/init.el
      ln -fs ${./dotfiles/fehbg} .fehbg
      ln -fs ${./dotfiles/functions} .functions
      ln -fs ${./dotfiles/gitconfig} .gitconfig
      mkdir .nixpkgs 2>/dev/null || true
      chown codehero:users .nixpkgs
      ln -fs ${./dotfiles/nixpkgs/config.nix} .nixpkgs/config.nix
      mkdir .pulse 2>/dev/null || true
      chown codehero:users .pulse
      ln -fs ${./dotfiles/pulse/default.pa} .pulse/default.pa
      ln -fs ${./dotfiles/xmobarrc} .xmobarrc
      mkdir .xmonad 2>/dev/null || true
      chown codehero:users .xmonad
      ln -fs ${./dotfiles/xmonad/xmonad.hs} .xmonad/xmonad.hs
      ln -fs ${./dotfiles/zshrc.local} .zshrc.local
      ln -fs ${./dotfiles/zshrc} .zshrc
      ln -fs ${./dotfiles/Xresources} .Xresources
    '';
  };
}
