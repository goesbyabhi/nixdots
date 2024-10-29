local conform = require("conform")

conform.setup({
	format_on_save = function(bufnr)
		local disable_filetypes = {}
		return {
			timeout_ms = 500,
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		}
	end,
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		astro = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		php = { "prettyphp", "phpcbf" },
		cpp = { "clang-format" },
		c = { "clang-format" }
	},
})

vim.keymap.set({ "n", "v" }, "<leader>mk", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end)
