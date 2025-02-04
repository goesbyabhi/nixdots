{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = ''
        	function(bufnr)
        	local disable_filetypes = {}
        		return {
        	timeout_ms = 500,
        	lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
        	}
        end
        	'';
      formatter_by_ft = {
        cpp = [ "clang-format" ];
        c = [ "clang-format" ];
      } // builtins.listToAttrs (map (ft: {
        name = ft;
        value = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
      }) [
        "javascript"
        "typescript"
        "javascriptreact"
        "typescriptreact"
        "html"
        "css"
        "json"
        "yaml"
        "graphql"
      ]);
    };
  };
}
