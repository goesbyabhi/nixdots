{ config, pkgs, pkgs-unstable, inputs, ... }:
# let
#   nurPkgs = import inputs.nixpkgs {
#     config =
#       {
#         allowUnfree = true;
#       };
#     system = pkgs.system;
#     overlays = [ inputs.nur.overlay ];
#   };
# in
{
  imports = [
    inputs.carburetor.homeManagerModules.default
    ./desktop
    ./app
    ./shell/cli.nix
  ];

  home.username = "abhi";
  home.homeDirectory = "/home/abhi";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home.packages = (with pkgs; [
    bat
    coreutils
    desktop-file-utils
    dosbox
    fastfetch
    fd
    fzf
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
    ripgrep
    rssguard
    unzip
    vesktop
    w3m
    wl-clipboard
    xclip
    xorg.xev
    xsel
    zip
    # openbox-menu
    # obconf
    # lxappearance
    # plank
    # picom
    # nitrogen
    # menumaker
    # networkmanager_dmenu
    # calc
    # rofi
    # polybar
    # material-icons
    # sassc
    # xfce.xfce4-settings
    # pcmanfm
    # dunst
    # scrot
    # dmenu
    # blueman
  ]) ++ (with pkgs-unstable; [
    # neovim
    vscode
  ]) ++ (with pkgs.gnomeExtensions; [
    dash-to-dock
    blur-my-shell
    paperwm
    appindicator
    gradient-top-bar #manually upgrade from extensions.gnome.org site if outdated
    compact-top-bar
    # ]) ++ (with nurPkgs; [
    #   nur.repos.nltch.spotify-adblock
  ]);

  home.file = {
    # ".config/nvim".source = ./nvim;
  };

  news.display = "silent";

  # Run unset __HM_SESS_VARS_SOURCED ; . .profile
  # after you've built the stuff. This will do some weird refresher as the sessionas are not set properly
  home.sessionVariables = {
    EDITOR = "nvim";
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    BAT_THEME = "OneHalfDark";
    XCURSOR_THEME = "McMojave-cursors";
    LC_CTYPE = "en_IN.utf8";
    JAVA_HOME = "${pkgs.jdk}";
  };

  home.sessionPath = [
    # "$HOME/.cargo/bin"
    ".npm-packages/bin/"
    "$HOME/.emacs.d/bin"
    "${pkgs.jdk}/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
