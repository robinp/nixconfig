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

  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enableNaCl = true;
    };
  };
  environment.systemPackages = with pkgs; [
    curl wget
    gnupg gnupg1compat
    fish tmux
    iftop nethogs htop
    ghc cabal-install stack
    vim vimPlugins.ghc-mod-vim
    git gitAndTools.git-annex gitAndTools.gitRemoteGcrypt
    chromium
    skype kde4.konversation
    vlc mplayer
    blender povray glxinfo
    python
    graphviz imagemagick
    unrar unzip
  ];

  security.polkit = {
    enable = true;
    extraConfig =
      ''
          polkit.addRule(function(action, subject) {
            if (action.id == "org.freedesktop.login1.suspend") {
              return polkit.Result.YES;
            }
          });

          /* Log authorization checks. */
          polkit.addRule(function(action, subject) {
            polkit.log("subject " +  subject + " is attempting action " + action);
          });
      '';
  };

  programs.ssh.startAgent = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    xkbOptions = "eurosign:e";
    displayManager.kdm.enable = true;
    desktopManager.kde4.enable = true;
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      accelFactor = "0.01";
    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
}
