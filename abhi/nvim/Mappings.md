# Basic Remaps

```lua
vim.g.mapleader = " "		-- sets leader key

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- reload config
map("n", "<leader>r", ":w | source ~/.config/nvim/init.lua<CR>") -- reload the cofig

-- Tab bindings
map("n", "<leader>t", ":tabnew<CR>")			-- space+t creates new tab
map("n", "<leader>x", ":tabclose<CR>")			-- space+x closes current tab
map("n", "<leader>j", ":tabprevious<CR>")		-- space+j moves to previous tab
map("n", "<leader>k", ":tabnext<CR>")			-- space+k moves to next tab

-- Easy split generation
map("n", "<leader>v", ":vsplit<CR>")				-- space+v creates a veritcal split
map("n", "<leader>h", ":split<CR>")					-- space+h creates a horizontal split:w

-- easy split navigation
map("n", "<C-h>", "<C-w>h")						-- control+h switches to left split
map("n", "<C-l>", "<C-w>l")						-- control+l switches to right split
map("n", "<C-j>", "<C-w>j")						-- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k")						-- control+k switches to top split

-- buffer navigation
map("n", "<Tab>", ":bnext <CR>")				-- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>")			-- Shift+Tab goes to previous buffer
map("n", "<leader>d", ":bd! <CR>")				-- Space+d deletes current buffer

-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>")		-- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>")	-- Control+Right resizes vertical split -
map("n", "<C-Up>", ":horizontal resize +3<CR>")		-- Control+Up resizes  horizontal split +
map("n", "<C-Down>", ":horizontal resize -3<CR>")	-- Control+Down resizes horizontal split -

-- Open netrw in 25% split in tree view (DISABLED)
-- map("n", "<leader>e", ":Ex<CR>")			-- space+e toggles netrw tree view (DISABLED)
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>") -- Opens the NvimTree file explorer
-- Easy way to get back to normal mode from home row
map("i", "kj", "<Esc>")					-- kj simulates ESC
map("i", "jk", "<Esc>")					-- jk simulates ESC

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")			    -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>")									-- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")								-- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")								-- Move current line up

-- Telescope mappings
map('n', '<leader>ff', '<cmd> Telescope find_files<CR>')
map('n', '<leader>fw', '<cmd> Telescope live_grep <CR>')
map('n', '<leader>fb', '<cmd> Telescope buffers <CR>')
map('n', '<leader>fh', '<cmd> Telescope help_tags <CR>')
map('n', '<leader>fg', '<cmd> Telescope git_files <CR>')

-- Random Fixes
map("n", ";", ":")
map("n", "<C-s>", ":w<CR>")
map("n", "<C-a>", "ggVG")
-- Attempt at fixing terminal mode
map("t", "<C-x>", "<C-\\><C-N>") -- exit terminal mode with Ctrl + x
map("n", "<A-i>", ":term<CR>") -- Launch terminal mode with Alt + i

-- Clipboards shortcuts
map("v", "d", '"_d') -- this deletes the text without yanking into the Clipboardj

-- New movement fixes
map("n", "G", "Gzz") -- this centers the screen when moving to the bottom of the file
```

# LSP Remaps

```lua
['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
['<C-y>'] = cmp.mapping.confirm({ select = true }),
["<C-Space>"] = cmp.mapping.complete(),

vim.keymap.set("n", "<A-.>", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>wd", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "<leader>wca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>wrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>wrn", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
```

# Trouble
```lua
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
```

# Harpoon
```lua
vim.keymap.set("n", "<A-a>", mark.add_file)
vim.keymap.set("n", "<A-r>", mark.rm_file)
vim.keymap.set("n", "<A-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end)
```

# Undotree
```lua
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
```

# Refactoring
```lua
vim.api.nvim_set_keymap("v", "<leader>ir", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
```
