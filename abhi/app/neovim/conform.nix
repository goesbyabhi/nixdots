{
  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        formatters_by_ft = {
          rust = [ "rustfmt" ];
        } // builtins.listToAttrs (map
          (ft: {
            name = ft;
            value = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
          }) [ "html" "css" "javascript" "javascriptreact" "typescript" "typescriptreact" "markdown" "json" "svelte" "astro" "graphql" ]);
      };
    };
  };
}
