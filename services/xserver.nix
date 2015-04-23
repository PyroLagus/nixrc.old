{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    xkbOptions = "ctrl:nocaps";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = self: [pkgs.haskellngPackages.edit-distance];
    };
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands = ''
    xmobar &                        # start xmobar
    [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
    eval $(cat ~/.fehbg) &          # set wallpaper
    xcompmgr &                      # for transparent terminals
    urxvtd &                        # start urxvt-daemon
    (emacs --daemon && emacsclient -c) &
    # TODO: move to user services
  '';
    desktopManager.default = "none";
  };
}
