{ config, pkgs, pkgs-unstable, firefox-addons, inputs, ... }:
let
  nurPkgs = import inputs.nixpkgs {
    config =
      {
        allowUnfree = true;
      };
    system = pkgs.system;
    overlays = [ inputs.nur.overlay ];
  };
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
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
    w3m
    rxvt-unicode-emoji
    xorg.xev
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
  ]) ++ (with nurPkgs; [
    nur.repos.nltch.spotify-adblock
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
    XCURSOR_THEME = "McMojave-cursors";
  };

  home.sessionPath = [
    # "$HOME/.cargo/bin"
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
      rr = "ranger";
    };
    historyIgnore = [
      "ls"
      "l"
      "nvim"
      "cd"
      "exit"
      "ranger"
    ];
    bashrcExtra = ''
      			function ranger {
      				local quit_cd_wd_file="$HOME/.cache/ranger/quit_cd_wd"        # The path must be the same as <file_saved_wd> in map.
      					command ranger --cmd="map X quitall_cd_wd $quit_cd_wd_file" "$@"
      					if [ -s "$quit_cd_wd_file" ]; then
      						cd "$(cat $quit_cd_wd_file)"
      							true > "$quit_cd_wd_file"
      							fi
      			}
      		'';
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

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = false;
      theme = spicePkgs.themes.sleek;
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
      ];
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        beautifulLyrics
        seekSong
      ];
    };

  programs.ranger = {
    enable = true;
    plugins = [
      {
        name = "ranger-zoxide";
        src = builtins.fetchGit {
          url = "https://github.com/jchook/ranger-zoxide.git";
          rev = "281828de060299f73fe0b02fcabf4f2f2bd78ab3";
        };
      }
      {
        name = "fzf-filter";
        src = builtins.fetchGit {
          url = "https://github.com/MuXiu1997/ranger-fzf-filter.git";
          rev = "bf16de2e4ace415b685ff7c58306d0c5146f9f43";
        };
      }
    ];
    extraConfig = ''
      			set preview_images_method iterm2
      			map X quitall_cd_wd
      			map f console fzf_filter%space
      			map z console z%space
      			map Z zi
      			'';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
