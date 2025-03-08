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
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
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
      language-server = {
        ruff = {
          command = "ruff";
          args = [ "server" ];
        };
        biome = {
          command = "biome";
          args = [ "lsp-proxy" ];
        };
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
