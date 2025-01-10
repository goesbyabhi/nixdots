{ pkgs, ... }:
{
	home = {
		username = "wsl";
		homeDirectory = "/home/wsl";
		stateVersion = "24.05"; # Please read the comment before changing.
	};

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home.packages = with pkgs; [
    bat
    coreutils
    fastfetch
    fd
    fzf
    jq
    nvitop
    patchelf
    ripgrep
    unzip
    w3m
    wl-clipboard
    xclip
    xorg.xev
    xsel
    zip
  ];

  news.display = "silent";

  home.sessionVariables = {
    EDITOR = "nvim";
    LC_CTYPE = "en_IN.utf8";
    JAVA_HOME = "${pkgs.jdk}";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
