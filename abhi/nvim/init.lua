require("set")
require("remap")

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local augroup = vim.api.nvim_create_augroup
local AbhishekGroup = augroup('Abhishek', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

require("plugins")

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd({ "BufWritePre" }, {
	group = AbhishekGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25
