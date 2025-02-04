{ config, pkgs, pkgs-unstable, inputs, ... }: {
  imports = [ ./desktop ./app ];

  home = {
    username = "abhi";
    homeDirectory = "/home/abhi";
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home.packages = (with pkgs; [
    bat
    brave
    bottles
    coreutils
    desktop-file-utils
    fastfetch
    fd
    foliate
    fzf
    gcc
    gdb
    glxinfo
    gnome-tweaks
    hello
    imagemagick
    inotify-tools
    jdk
    jetbrains.idea-ultimate
    jq
    libnotify
    linuxKernel.packages.linux_6_6.v4l2loopback
    mangohud
    newsflash
    nixd
    nodejs_23
    node2nix
    nvitop
    patchelf
    qbittorrent
    quickemu
    ripgrep
    rssguard
    swtpm
    unzip
    vesktop
    w3m
    wl-clipboard
    xclip
    xorg.xev
    xsel
    zip
  ]) ++ (with pkgs.gnomeExtensions; [ compact-top-bar dash-to-dock ]);

  news.display = "silent";

  home.sessionVariables = {
    BAT_THEME = "OneHalfDark";
    XCURSOR_THEME = "McMojave-cursors";
    LC_CTYPE = "en_IN.utf8";
    JAVA_HOME = "${pkgs.jdk}";
  };

  home.sessionPath =
    [ ".npm-packages/bin/" "$HOME/.emacs.d/bin" "${pkgs.jdk}/bin" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
