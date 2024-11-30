{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        ts-ls.enable = true;
        clangd = {
          enable = true;
          cmd = [ "clangd" ];
        };
        rust-analyzer = {
          enable = true;
          cmd = [ "rust-analyzer" ];
          installCargo = false;
          installRustc = false;
        };
        tailwindcss.enable = true;
        gopls.enable = true;
        rnix.enable = true;
      };
      keymaps = {
        diagnostic = {
          "<A-j>" = "goto_next";
          "<A-k>" = "goto_prev";
          "<keader>wd" = "open_float";
        };
        lspBuf = {
          gd = "definition";
          K = "hover";
          gD = "declaration";
          gr = "references";
          gi = "implementation";
          gt = "type_definition";
          gs = "signature_help";
          "<F2>" = "rename";
          "<F3>" = "format({async = true})";
          "<F4>" = "code_action";
          "<leader>ws" = "workspace_symbol";
        };
      };
    };
    lint = {
      enable = true;
      lintersByFt =
        builtins.listToAttrs (map
          (ft: {
            name = ft;
            value = "eslint_d";
          }) [ "javascript" "typescript" "javascriptreact" "typescriptreact" ]);
    };
    lsp-format.enable = true;
    none-ls = {
      enable = true;
      enableLspFormat = true;
      settings.update_in_insert = false;

      sources = {
        code_actions = {
          gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          cppcheck.enable = true;
          statix.enable = true;
        };
        formatting = {
          clang_format.enable = true;
          gofumpt.enable = true;
          rustywind.enable = true;
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
            settings.withArgs = ''
              						{
              							extra_args = {"--single-quote"},
              						}
              						'';
          };
        };
      };
    };
  };
}
