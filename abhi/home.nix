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
  ]) ++ (with pkgs-unstable; [
	neovim
  ]) ++ (with pkgs.gnomeExtensions; [
	dash-to-dock
	blur-my-shell
	paperwm
	appindicator
	gradient-top-bar #manually upgrade from extensions.gnome.org site if outdated
	compact-top-bar
  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };

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
			};
			"org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
					blur = false;
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
		};
	};

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      cls = "clear";
    };
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };

  programs.firefox = {
  	enable = true;
	profiles.abhi = {
		userChrome = builtins.readFile firefox/userChrome.css;
		userContent = builtins.readFile firefox/userContent.css;
		extraConfig = builtins.readFile firefox/user.js;
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
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
