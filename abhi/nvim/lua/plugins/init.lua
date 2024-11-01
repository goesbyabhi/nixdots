local function setColor(colorscheme)
	-- code
	vim.cmd("colorscheme " .. colorscheme)
	vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
end

local plugins = {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		lazy = true,
		cmd = "Telescope",
		config = function()
			require "plugins.configs.telescope"
		end,
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'folke/trouble.nvim',
		event = "BufReadPre",
		config = function()
			require "plugins.configs.trouble"
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			require "plugins.configs.treesitter"
		end,
	},
	{
		"theprimeagen/harpoon",
		event = "BufReadPre",
		config = function()
			require "plugins.configs.harpoon"
		end,
	},
	{
		"theprimeagen/refactoring.nvim",
		lazy = true,
		config = function()
			require "plugins.configs.refactoring"
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			require "plugins.configs.undotree"
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context"
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = 'v1.x',
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require "plugins.configs.lsp"
		end,
		dependencies =
		{
			{ 'neovim/nvim-lspconfig',
				config = function()
					require'lspconfig'.rust_analyzer.setup {
						cmd = { "rust-analyzer" },
					}
				end,
			},
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{
				'hrsh7th/nvim-cmp',
				--	event = "InsertEnter",
				dependencies = {
					{ 'hrsh7th/cmp-buffer' },
					{ 'hrsh7th/cmp-path' },
					{ 'saadparwaiz1/cmp_luasnip' },
					{ 'hrsh7th/cmp-nvim-lsp' },
					{ 'hrsh7th/cmp-nvim-lua' },
					-- Snippets
					{
						'L3MON4D3/LuaSnip',
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
					{ 'rafamadriz/friendly-snippets' },
				}
			},
		}
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
		config = function()
			require "plugins.configs.nvimtree"
		end,
	},
	{
		"github/copilot.vim",
		-- event = "InsertEnter",
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.configs.formatting")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.configs.linting")
		end,
	},
	{
		'nanozuki/tabby.nvim',
		event = 'VimEnter', -- if you want lazy load, see below
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("plugins.configs.tabline")
		end,
	},
	{
		'freddiehaddad/feline.nvim',
		opts = {},
		config = function(_, opts)
			require('plugins.configs.feline').config(_, opts)
		end,
		dependencies = {
			'EdenEast/nightfox.nvim',
			'lewis6991/gitsigns.nvim',
			'nvim-tree/nvim-web-devicons',
			{
				'linrongbin16/lsp-progress.nvim',
				opts = {
					spinner = { '⠋', '⠙', '⠸', '⢰', '⣠', '⣄', '⡆', '⠇' },
					client_format = function(_, spinner, series_messages)
						return #series_messages > 0 and
								(spinner .. ' LSP') or ' LSP'
					end,
					format = function(client_messages)
						local sign = ' LSP'
						if #client_messages > 0 then return table.concat(client_messages) end
						if #vim.lsp.get_clients() > 0 then return sign end
						return '󱏎 LSP'
					end,
				},
			},
		},
		init = function()
			-- update statusbar when there's a plugin update
			vim.api.nvim_create_autocmd('User', {
				pattern = 'LazyCheck',
				callback = function() vim.opt.statusline = vim.opt.statusline end,
			})

			-- update statusbar with LSP progress
			vim.api.nvim_create_augroup('feline_augroup', { clear = true })
			vim.api.nvim_create_autocmd('User', {
				group = 'feline_augroup',
				pattern = 'LspProgressStatusUpdated',
				callback = function() vim.opt.statusline = vim.opt.statusline end,
			})

			-- hide the mode
			vim.opt.showmode = false

			-- hide search count on command line
			vim.opt.shortmess:append({ S = true })
		end,
		opts = {
			force_inactive = { filetypes = { '^dapui_*', '^help$', '^neotest*', '^NvimTree$', '^qf$' } },
			disable = { filetypes = { '^alpha$' } },
		},
	},
	-- {
	-- 	'andweeb/presence.nvim',
	-- 	config = function()
	-- 		require("plugins.configs.presence")
	-- 	end
	-- },
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup()
		end
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require("colorizer").setup()
		end
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("carbonfox")
		end
	},
	{
		"kdheepak/monochrome.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("monochrome")
		end
	},
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("lackluster-mint")
		end
	},
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			-- Required dependency for nvim-dap-ui
			'nvim-neotest/nvim-nio',

			-- Installs the debug adapters for you
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',
			'theHamsta/nvim-dap-virtual-text',
			'nvim-telescope/telescope-dap.nvim',
			'rcarriga/cmp-dap',
			-- Add your own debuggers here
			'leoluz/nvim-dap-go',
		},
		config = function()
			require("plugins.configs.debugger")
		end
	},
	{
		'MeanderingProgrammer/markdown.nvim',
		-- name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		config = function()
			require('render-markdown').setup({})
		end,
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		config = function()
			require('Comment').setup()
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "┊" },
			whitespace = { highlight = { "Whitespace", "NonText" } },
		},
	},
	{
		"SunnyTamang/pendulum.nvim",
		config = function()
			require "pendulum".setup()
		end
	},
	-- { 'wakatime/vim-wakatime', lazy = false },
	{
		'https://github.com/fresh2dev/zellij.vim.git',
		lazy = false,
		keys = {
			{ '<leader>tt', ':ZellijNewPane<CR>',       mode = { 'n' },      { noremap = true } },
			{ '<M-f>',      ':ZellijNewPane<CR>',       mode = { 'n', 'i' }, { noremap = true } },
			{ '<M-t>',      ':ZellijNewPaneSplit<CR>',  mode = { 'n', 'i' }, { noremap = true } },
			{ '<M-v>',      ':ZellijNewPaneVSplit<CR>', mode = { 'n', 'i' }, { noremap = true } },
		},
	}
}

local opts = {}

require("lazy").setup(plugins, opts)
