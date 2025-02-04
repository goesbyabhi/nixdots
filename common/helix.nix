{ pkgs-unstable, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    package = pkgs-unstable.helix;
    languages.language = [
      {
        name = "javascript";
        formatter = {
          command = "prettierd";
          args = [ ".js" ];
        };
        auto-format = true;
      }
      {
        name = "typescript";
        formatter = {
          command = "prettierd";
          args = [ ".ts" ];
        };
        auto-format = true;
      }
      {
        name = "jsx";
        formatter = {
          command = "prettierd";
          args = [ ".jsx" ];
        };
        auto-format = true;
      }
      {
        name = "tsx";
        formatter = {
          command = "prettierd";
          args = [ ".tsx" ];
        };
        auto-format = true;
      }
    ];
    settings = {
      theme = "curzon";
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
        insert = { j = { j = "normal_mode"; }; };
      };
    };
  };
}
