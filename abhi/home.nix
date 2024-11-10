{ config, pkgs, pkgs-unstable, firefox-addons, ... }:

{
  home.username = "abhi";
  home.homeDirectory = "/home/abhi";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  home.packages = (with pkgs; [
    hello
    discord
    wezterm
    fastfetch
    glxinfo
    nvitop
    mangohud
    gnome.gnome-tweaks
    inotify-tools
    libnotify
    jq
    unzip
    ripgrep
    fzf
    bat
    obsidian
    zellij
    gdb
    wl-clipboard
    qbittorrent
    ranger
    w3m
    rxvt-unicode-emoji
    xorg.xev
  ]) ++ (with pkgs-unstable; [
    neovim
    go
    zig
    rustup
  ]) ++ (with pkgs.gnomeExtensions; [
    dash-to-dock
    blur-my-shell
    paperwm
    appindicator
    gradient-top-bar #manually upgrade from extensions.gnome.org site if outdated
    compact-top-bar
  ]);

  home.file = {
    ".config/nvim".source = ./nvim;
    ".wezterm.lua".source = ./wezterm/wezterm.lua;
    ".config/zellij".source = ./zellij;
    ".Xdefaults".source = ./urxvt/xdefaults;
  };

  # Run unset __HM_SESS_VARS_SOURCED ; . .profile
  # after you've built the stuff. This will do some weird refresher as the sessionas are not set properly
  home.sessionVariables = {
    EDITOR = "nvim";
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    BAT_THEME = "OneHalfDark";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          dash-to-dock.extensionUuid
          gradient-top-bar.extensionUuid
          blur-my-shell.extensionUuid
          paperwm.extensionUuid
          appindicator.extensionUuid
          system-monitor.extensionUuid
          gradient-top-bar.extensionUuid
          compact-top-bar.extensionUuid
        ];
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell/extensions/paperwm" = {
        selection-border-size = 5;
        show-focus-mode-icon = false;
        show-window-position-bar = false;
        show-workspace-indicator = false;
        show-open-position-icon = false;
        window-gap = 15;
        vertical-margin = 5;
        vertical-margin-bottom = 8;
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = true;
        static-blur = true;
        unblur-in-overview = true;
      };
      "org/gnome/shell/extensions/blur-my-shell/window-list" = {
        blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell" = {
        hacks-level = 0;
      };
      "org/gnome/shell/extensions/system-monitor" = {
        show-upload = false;
        show-download = false;
      };
      "org/gnome/shell/extensions/org/pshow/gradienttopbar" = {
        opaque-on-maximized = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        focus-mode = "sloppy";
        auto-raise = true;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        dash-max-icon-size = 38;
        custom-theme-shrink = true;
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      cls = "clear";
      cat = "bat";
    };
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };

  programs.firefox = {
    enable = true;
    profiles.abhi = {
      extensions = with firefox-addons.packages."x86_64-linux"; [
        bitwarden
        darkreader
        ublock-origin
        vimium
      ];
    };
  };

  programs.git = {
    enable = true;
    userEmail = "83471520+goesbyabhi@users.noreply.github.com";
    userName = "Abhishek Panda";
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = "auto";
      pull.rebase = false;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
