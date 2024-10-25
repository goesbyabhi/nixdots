{ config, pkgs, pkgs-unstable, ... }:

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
	protonup
  ]) ++ (with pkgs-unstable; [
	neovim
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
