{ pkgs-unstable, ... }: {
  programs.helix = {
    enable = true;
		defaultEditor = true;
		package = pkgs-unstable.helix;
		settings = {
			theme = "autumn_night";
			editor = {
				bufferline = "multiple";
				cursor-shape.insert = "bar";
				line-number = "relative";
				lsp.display-messages = true;
			};
			keys = {
				normal = {
					space = {
						space = "file_picker";
						w = ":w";
						q = ":q";
						esc = [ "collapse_selection" "keep_primary_selection" ];
					};
				};
				insert = {
					j = {
						j = "normal_mode";
					};
				};
			};
		};
  };
}
