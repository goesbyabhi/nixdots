{ pkgs-unstable, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs-unstable.helix;
    languages = {
      language = [
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
        {
          name = "python";
          auto-format = true;
          language-servers = [ "ruff" ];
          formatter = {
            command = "black";
            args = [
              "--quiet"
              "-"
            ];
          };
        }
      ];
      language-server.ruff = {
        command = "ruff";
        args = [ "server" ];
      };
    };
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
            esc = [
              "collapse_selection"
              "keep_primary_selection"
            ];
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
