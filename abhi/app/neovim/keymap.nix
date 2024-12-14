{
	programs.nixvim = {
		keymaps = [
		{ mode = "n"; key = "<leader>t"; action = ":tabnew<CR>"; options.desc = "Create new tab"; }
		{ mode = "n"; key = "<leader>x"; action = ":tabclose<CR>"; options.desc = "Close current tab"; }
		{ mode = "n"; key = "<leader>j"; action = ":tabprevious<CR>"; options.desc = "Move to previous tab"; }
		{ mode = "n"; key = "<leader>k"; action = ":tabnext<CR>"; options.desc = "Move to next tab"; }
		{ mode = "n"; key = "<leader>v"; action = ":vsplit<CR>"; options.desc = "Create vertical split"; }
		{ mode = "n"; key = "<leader>h"; action = ":split<CR>"; options.desc = "Create horizontal split"; }
		{ mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Move to left split"; }
		{ mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Move to right split"; }
		{ mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Move to bottom split"; }
		{ mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Move to top split"; }
		{ mode = "n"; key = "<Tab>"; action = ":bnext<CR>"; options.desc = "Next buffer"; }
		{ mode = "n"; key = "<S-Tab>"; action = ":bprevious<CR>"; options.desc = "Previous buffer"; }
		{ mode = "n"; key = "<leader>d"; action = ":bd!<CR>"; options.desc = "Delete current buffer"; }
		{ mode = "n"; key = "<C-Left>"; action = ":vertical resize +3<CR>"; options.desc = "Increase vertical split size"; }
		{ mode = "n"; key = "<C-Right>"; action = ":vertical resize -3<CR>"; options.desc = "Decrease vertical split size"; }
		{ mode = "n"; key = "<C-Up>"; action = ":horizontal resize +3<CR>"; options.desc = "Increase horizontal split size"; }
		{ mode = "n"; key = "<C-Down>"; action = ":horizontal resize -3<CR>"; options.desc = "Decrease horizontal split size"; }
		{ mode = "n"; key = "<C-n>"; action = "<cmd>NvimTreeToggle<CR>"; options.desc = "Toggle NvimTree"; }
		{ mode = "i"; key = "jj"; action = "<Esc>"; options.desc = "Exit insert mode"; }
		{ mode = "v"; key = "<leader>r"; action = "\"hy:%s/<C-r>h//g<left><left>"; options.desc = "Replace all instances of highlighted words"; }
		{ mode = "v"; key = "<C-s>"; action = ":sort<CR>"; options.desc = "Sort highlighted text"; }
		{ mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.desc = "Move line down"; }
		{ mode = "v"; key = "K"; action = ":m '>-2<CR>gv=gv"; options.desc = "Move line up"; }
		{ mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Telescope find files"; }
		{ mode = "n"; key = "<leader>fw"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Telescope live grep"; }
		{ mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Telescope buffers"; }
		{ mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<CR>"; options.desc = "Telescope help tags"; }
		{ mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope git_files<CR>"; options.desc = "Telescope git files"; }
		{ mode = "n"; key = ";"; action = ":"; options.desc = "Enter command mode"; }
		{ mode = "n"; key = "<C-s>"; action = ":w<CR>"; options.desc = "Save file"; }
		{ mode = "n"; key = "<C-a>"; action = "ggVG"; options.desc = "Select all"; }
		{ mode = "t"; key = "<C-x>"; action = "<C-\\><C-N>"; options.desc = "Exit terminal mode"; }
		{ mode = "n"; key = "<A-i>"; action = ":term<CR>"; options.desc = "Launch terminal"; }
		{ mode = "v"; key = "d"; action = "\"_d"; options.desc = "Delete without yanking"; }
		{ mode = "n"; key = "G"; action = "Gzz"; options.desc = "Move to bottom and center"; }
		{ mode = "n"; key = "<leader>u"; action = "<Esc><Cmd>UndotreeToggle<CR>"; }
		{ mode = "v"; key = "<leader>ir"; action = "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>"; options = {noremap = true; silent = true; expr = false; }; }
		{ mode = "n"; key = "<leader>mk"; action = "<Esc><Cmd>lua function() conform.format({lsp_fallback = true, async = false, timeout_ms = 500,})"; options.silent = true;}
		];

		plugins.lsp.keymaps = {
			diagnostic = {
				"gz" = "open_float";
				"<leader>k" = "goto_prev";
				"<leader>j" = "goto_next";
			};
			lspBuf = {
				"K" = "hover";
				"gd" = "definition";
				"gD" = "declaration";
				"gi" = "implementation";
				"go" = "type_definition";
				"gr" = "references";
				"gs" = "signature_help";
				"<F2>" = "rename";
				"<F3>" = "format";
				"<F4>" = "code_action";
			};
		};
	};
}
