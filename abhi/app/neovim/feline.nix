{ pkgs, ... }: {
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      feline-nvim
      lsp-progress-nvim
    ];
    feline-nvim.extraConfigLua = ''
      			require('lsp-progress').setup({
      					spinner = { '⠋', '⠙', '⠸', '⢰', '⣠', '⣄', '⡆', '⠇' },
      					client_format = function(_, spinner, series_messages)
      					return #series_messages > 0 and (spinner .. ' LSP') or ' LSP'
      					end,
      					format = function(client_messages)
      					local sign = ' LSP'
      					if #client_messages > 0 then return table.concat(client_messages) end
      					if #vim.lsp.get_clients() > 0 then return sign end
      					return '󱏎 LSP'
      					end,
      					})

      		-- Feline configuration
      			local colorscheme = vim.g.colors_name
      			local palette = require('nightfox.palette').load(colorscheme)
      			local feline = require('feline')
      			local vi_mode = require('feline.providers.vi_mode')
      			local file = require('feline.providers.file')
      			local separators = require('feline.defaults').statusline.separators.default_value
      			local lsp = require('feline.providers.lsp')

      			-- Define the theme and components as before
      			local theme = {
      				fg = palette.fg1,
      				bg = palette.bg1,
      				-- Other colors here...
      			}

      		local c = {
      			-- Define components as in the previous config
      		}

      		local active = {
      			{ c.vim_status },
      			{ c.vi_mode },
      		}

      		local inactive = {
      			{ },
      			{ c.in_file_info },
      		}

      		feline.setup({
      				components = { active = active, inactive = inactive },
      				})
      		feline.use_theme(theme)

      			-- Auto commands and statusline updates
      			vim.api.nvim_create_autocmd('User', {
      					pattern = 'LazyCheck',
      					callback = function() vim.opt.statusline = vim.opt.statusline end,
      					})

      		vim.api.nvim_create_augroup('feline_augroup', { clear = true })
      			vim.api.nvim_create_autocmd('User', {
      					group = 'feline_augroup',
      					pattern = 'LspProgressStatusUpdated',
      					callback = function() vim.opt.statusline = vim.opt.statusline end,
      					})

      		-- Additional settings
      			vim.opt.showmode = false
      			vim.opt.shortmess:append({ S = true })
      			'';
  };
}


