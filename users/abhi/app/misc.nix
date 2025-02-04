{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
	programs.sioyek = {
		enable = true;
		bindings = {
			"move_up" = "k";
			"move_down" = "j";
			"move_left" = "h";
			"move_right" = "l";
			"screen_down" = "<c-d>";
			"screen_up" = "<c-u>";
			"add_highlight" = "H";
			"goto_mark" = "gm";
		};
	};
}
