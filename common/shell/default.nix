{
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
        eval "$(direnv hook bash)"
        	if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
        		[[ -s "/home/abhi/.sdkman/bin/sdkman-init.sh" ]] && source "/home/abhi/.sdkman/bin/sdkman-init.sh"
        			'';
      initExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };

    nushell = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
        cls = "clear";
        cat = "bat";
        rr = "ranger";
      };
      configFile = {
        text = ''
          $env.config.show_banner = false
        '';
      };
    };

    git = {
      enable = true;
      delta = {
        enable = true;
        options = {
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
            hunk-header-decoration-style = "yellow box";
          };
          features = "unobtrusive-line-numbers decorations";
          line-numbers = "true";
          unobtrusive-line-numbers = {
            line-numbers = "true";
            line-numbers-minus-style = "#444444";
            line-numbers-zero-style = "#444444";
            line-numbers-plus-style = "#444444";
            line-numbers-left-format = "{nm:>4}┊";
            line-numbers-right-format = "{np:>4}│";
            line-numbers-left-style = "blue";
            line-numbers-right-style = "blue";
          };
          hyperlinks = "true";
          side-by-side = "true";
          whitespace-error-style = "22 reverse";
          diff-so-fancy = "true";
        };
      };
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
      options = [ "--cmd cd" ];
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

    zellij.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.file.".config/zellij".source = ./zellij;
}
