vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.g.netrw_banner = 0  -- gets rid of the annoying banner of NetRW
-- vim.g.netrw_browse_split = 4 	-- open in prior window
vim.g.netrw_altv = 1    -- change from left splitting to right splitting
-- vim.g.netrw_liststyle = 3 	-- tree style view in netRW
vim.opt.title = true    -- show title/file name
vim.cmd('set path+=**') -- search curr directory recursively
vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.compatible = false    -- turn off vi compatibility mode
vim.opt.number = true         -- line numbers
vim.opt.relativenumber = true -- relative linenumbers
vim.opt.mouse = 'a'           -- enable mouse in all modes
vim.opt.ignorecase = true     -- enable case insensitive searching
vim.opt.smartcase = true      -- all searches are case insensitive
vim.opt.hlsearch = false      -- disable highlight search
vim.opt.incsearch = true      -- enable incremental search
vim.opt.wrap = false          -- disable line wrapping
vim.opt.tabstop = 2           -- tabs = 4 spaces
vim.opt.shiftwidth = 2
vim.opt.pumheight = 4         -- number of items in popup menu
vim.opt.showtabline = 2       -- always show tab line
vim.opt.laststatus = 3        -- always show statusline (switch to 2 if you want a statusline for each window, set to 3 if you want a global statusline)
vim.opt.signcolumn = "auto"
vim.opt.expandtab = false     -- expand tab
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.cmdheight = 0
-- vim.opt.scrolloff = 20		-- scroll page when cursor is 8 lines
vim.opt.sidescrolloff = 15 -- scroll page when cursor is 8 lines
vim.opt.fillchars = 'eob: '
-- Random ass clipboard fix lol
-- vim.g.clipboard = {
-- 	name = 'win32yank',
-- 	copy = {
-- 		["+"] = 'win32yank.exe -i --crlf',
-- 		["*"] = 'win32yank.exe -i --crlf',
-- 	},
-- 	paste = {
-- 		["+"] = 'win32yank.exe -o --lf',
-- 		["*"] = 'win32yank.exe -o --lf',
-- 	},
-- 	cache_enabled = 0,
-- }
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.splitbelow = true -- split go below
vim.opt.splitright = true -- vertical split to right
vim.opt.termguicolors = true
vim.cmd('filetype plugin on')
vim.cmd('set wildmenu') -- enable wildmenu

-- Terminal bs
-- vim.api.nvim_create_autocmd({"TermOpen", "BufEnter"}, {
-- 	pattern = { "term://*" },
-- 	callback = function()
-- 		vim.wo.relativenumber = false
-- 		vim.wo.number = false
-- 		vim.opt.signcolumn = "no"
--
-- 		-- vim.cmd([[ startinsert ]])
-- 	end,
-- })

-- Test
-- vim.api.nvim_create_autocmd({"InsertEnter"}, {
-- 	callback = function()
-- 		vim.cmd("norm zz")
-- 	end
-- })

-- True text centering
vim.api.nvim_exec2([[
  autocmd CursorMoved,CursorMovedI * lua Center_cursor()
]], { output = false })

function Center_cursor()
	local pos = vim.fn.getpos('.')
	vim.cmd('normal! zz')
	vim.fn.setpos('.', pos)
end

-- Neovide related settings
if vim.g.neovide then
	-- vim.o.guifont = "IosevkaCustom Nerd Font:h12"
	-- vim.o.guifont = "FantasqueSansM Nerd Font Mono:h14"
	vim.o.guifont = "Berkeley Mono:h14"
	vim.g.neovide_transparency = 1
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_theme = 'auto'
	vim.g.neovide_refresh_rate_idle = 5
end

-- Theme application
-- function ApplyTheme()
-- 	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 	-- vim.cmd("highlight LineNr guifg=#add2f7")
-- 	vim.cmd("highlight FloatBorder guibg=NONE")
-- 	vim.cmd("highlight NvimTreeNormalFloat guifg=Normal guibg=Normal")
-- end

-- Apply theme on colorscheme change
-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--         vim.schedule(ApplyTheme)
--     end,
-- })

-- Set initial colorscheme
-- vim.cmd.colorscheme("default")

-- Apply theme after initial load
-- vim.schedule(ApplyTheme)

-- vim.cmd.colorscheme("quiet")

vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")
