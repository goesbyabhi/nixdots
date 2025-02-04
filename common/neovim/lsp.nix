{
  programs.nixvim.plugins.lsp = {
    enable = true;
    capabilities =
      "capabilities.textDocument.completion.completionItem.snippetSupport = true";
    inlayHints = true;
    servers = {
      arduino_language_server.enable = true;
      clangd.enable = true;
      cssls = {
        enable = true;
        extraOptions = { capabilities.__raw = "capabilities"; };
      };
      eslint = {
        enable = true;
        extraOptions = {
          on_attach.__raw = ''
            function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end
          '';
        };
      };
      gopls.enable = true;
      graphql.enable = true;
      html.enable = true;
      java_language_server.enable = true;
      kotlin_language_server.enable = true;
      nixd.enable = true;
      postgres_lsp.enable = true;
      pyright.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      statix.enable = true;
      tailwindcss.enable = true;
      ts_ls.enable = true;
    };
  };
}
