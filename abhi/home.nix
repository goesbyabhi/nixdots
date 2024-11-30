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
    ./desktop/gnome.nix
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
    hello
    discord
    fastfetch
    glxinfo
    nvitop
    mangohud
    gnome-tweaks
    inotify-tools
    libnotify
    jq
    unzip
    ripgrep
    fzf
    bat
    gdb
    wl-clipboard
    xsel
    xclip
    qbittorrent
    w3m
    xorg.xev
    patchelf
    linuxKernel.packages.linux_6_6.v4l2loopback
    rssguard
    dosbox
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
    neovim
    vscode
    gcc
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
    ".config/nvim".source = ./nvim;
  };

  # Run unset __HM_SESS_VARS_SOURCED ; . .profile
  # after you've built the stuff. This will do some weird refresher as the sessionas are not set properly
  home.sessionVariables = {
    EDITOR = "nvim";
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    BAT_THEME = "OneHalfDark";
    XCURSOR_THEME = "McMojave-cursors";
    LC_CTYPE = "en_IN.utf8";
  };

  home.sessionPath = [
    # "$HOME/.cargo/bin"
  ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
