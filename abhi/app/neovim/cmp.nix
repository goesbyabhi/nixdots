let
  cmp_select = "{cmp.SelectBehavior.Select}";
in
{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = { ghost_text = true; };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntire = 30;
        };
        snippet = { expand = "luasnip"; };
        formatting = { fields = [ "abbr" "kind" "menu" ]; };
        mapping = {
          "<C-p>" = "cmp.mapping.select_prev_item(${cmp_select})";
          "<C-n>" = "cmp.mapping.select_next_item(${cmp_select})";
          "<C-y>" = "cmp.mapping.confirm({select = true})";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<Tab>" = "nil";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
        };
      };
    };
    # cmp dependencies
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lua.enable = true;
    # snippets
    luasnip = {
      enable = true;
      fromVscode = [{ }];
    };
    friendly-snippets.enable = true;
  };
}
