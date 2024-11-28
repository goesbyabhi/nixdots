_: {
  programs = {
    bash = {
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

    git = {
      enable = true;
      userEmail = "83471520+goesbyabhi@users.noreply.github.com";
      userName = "Abhishek Panda";
      extraConfig = {
        init.defaultBranch = "main";
        color.ui = "auto";
        pull.rebase = false;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    ranger = {
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

    zellij = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  home.file.".config/zellij".source = ./zellij;
}
