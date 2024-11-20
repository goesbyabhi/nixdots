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
    # zellij
    gdb
    wl-clipboard
    qbittorrent
    ranger
    w3m
    rxvt-unicode-emoji
    xorg.xev
    tmux
  ]) ++ (with pkgs-unstable; [
    neovim
    vscode
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
    # ".config/zellij".source = ./zellij;
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

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    prefix = "M-z";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      cpu
      yank
      {
        plugin = mode-indicator;
        extraConfig = "set -g status-right '%Y-%m-%d %H:%M #{tmux_mode_indicator}";
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          					set -g @continuum-restore 'on'
          					set -g @continuum-save-interval '60'
          				'';
      }
    ];
    extraConfig = ''
            					set-option -sa terminal-overrides ",xterm*:Tc"
                  		source ./tmux/carbonfox.tmux
                  		bind - split-window -v -c "#{pane_current_path}"
                  		bind _ split-window -h -c "#{pane_current_path}"

                  		bind -r k select-pane -U
                  		bind -r j select-pane -D
                  		bind -r h select-pane -L
                  		bind -r l select-pane -R

      								bind-key -T copy-mode-vi v send-keys -X begin-selection
      								bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      								bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
                  		'';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
