{ config, pkgs, ... }:

{
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvp";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  environment.systemPackages = with pkgs; [
    curl wget
    gnupg
    fish tmux
    iftop nethogs
    ghc cabal-install stack
    vim vimPlugins.ghc-mod-vim
    git gitAndTools.git-annex
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvp";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;
  
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
}
