{
  programs.nixvim.plugins = {
    luasnip.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lua.enable = true;
    friendly-snippets.enable = true;
    cmp = {
      enable = true;
      settings = {
        experimental = { ghost_text = true; };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        mapping = {
          "<C-p>" =
            "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace })";
          "<C-n>" =
            "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace })";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
        };
        snippet = {
          expand = "luasnip";
          loadFromVscode = true;
        };
        sources = [
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lua"; }
        ];
      };
    };
  };
}
