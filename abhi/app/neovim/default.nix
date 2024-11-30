{ inputs, pkgs-unstable, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./lsp.nix
    ./conform.nix
    ./cmp.nix
    ./nvimtree.nix
    ./tabby.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    package = pkgs-unstable.neovim-unwrapped;
    colorscheme.nightfox = {
      enable = true;
      flavor = "carbonfox";
      luaConfig = ''
        				vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        				'';
    };
    diagnostics.virtual_text = true;
    opts = {
      swapfile = false;
      backup = false;
      undofile = true;
      undodir.__raw = "vim.fs.normalize('~/.nvim/undodir')";
      title = true;
      syntax = "ON";
      compatible = false;

      number = true;
      relativenumber = true;
      mouse = "a";

      ignorecase = true;
      smartcase = true;
      hlsearch = false;
      incsearch = true;

      wrap = false;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      smartindent = true;

      pumheight = 4;
      showtabline = 2;
      laststatus = 3;

      cmdheight = 0;
      sidescrolloff = 15;

      fillchars = "eob: ";

      splitbelow = true;
      splitright = true;

      termguicolors = true;
    };

    globals.mapleader = " ";

    keymaps = [
      # Config reload
      { mode = "n"; key = "<leader>r"; action = ":w | source ~/.config/nvim/init.lua<CR>"; options.desc = "Reload the config"; options.silent = true; }

      # Tabs
      { mode = "n"; key = "<leader>t"; action = ":tabnew<CR>"; options.desc = "Create new tab"; }
      { mode = "n"; key = "<leader>x"; action = ":tabclose<CR>"; options.desc = "Close current tab"; }
      { mode = "n"; key = "<leader>j"; action = ":tabprevious<CR>"; options.desc = "Move to previous tab"; }
      { mode = "n"; key = "<leader>k"; action = ":tabnext<CR>"; options.desc = "Move to next tab"; }

      # Splits
      { mode = "n"; key = "<leader>v"; action = ":vsplit<CR>"; options.desc = "Vertical split"; }
      { mode = "n"; key = "<leader>h"; action = ":split<CR>"; options.desc = "Horizontal split"; }

      # Split navigation
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Navigate left split"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Navigate right split"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Navigate down split"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Navigate up split"; }

      # Buffers
      { mode = "n"; key = "<Tab>"; action = ":bnext<CR>"; options.desc = "Next buffer"; }
      { mode = "n"; key = "<S-Tab>"; action = ":bprevious<CR>"; options.desc = "Previous buffer"; }
      { mode = "n"; key = "<leader>d"; action = ":bd!<CR>"; options.desc = "Delete buffer"; }

      # Resize splits
      { mode = "n"; key = "<C-Left>"; action = ":vertical resize +3<CR>"; options.desc = "Resize split left"; }
      { mode = "n"; key = "<C-Right>"; action = ":vertical resize -3<CR>"; options.desc = "Resize split right"; }
      { mode = "n"; key = "<C-Up>"; action = ":horizontal resize +3<CR>"; options.desc = "Resize split up"; }
      { mode = "n"; key = "<C-Down>"; action = ":horizontal resize -3<CR>"; options.desc = "Resize split down"; }

      # Escape shortcuts
      { mode = "i"; key = "kj"; action = "<Esc>"; options.desc = "Escape with kj"; }
      { mode = "i"; key = "jk"; action = "<Esc>"; options.desc = "Escape with jk"; }

      # Visual mode
      { mode = "v"; key = "<leader>r"; action = "\"hy:%s/<C-r>h//g<left><left>"; options.desc = "Replace all instances"; }
      { mode = "v"; key = "<C-s>"; action = ":sort<CR>"; options.desc = "Sort lines"; }
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.desc = "Move line down"; }
      { mode = "v"; key = "K"; action = ":m '>-2<CR>gv=gv"; options.desc = "Move line up"; }

      # Other
      { mode = "n"; key = ";"; action = ":"; options.desc = "Enter command mode"; }
      { mode = "n"; key = "<C-s>"; action = ":w<CR>"; options.desc = "Save file"; }
      { mode = "n"; key = "<C-a>"; action = "ggVG"; options.desc = "Select all"; }
      { mode = "n"; key = "<A-i>"; action = ":term<CR>"; options.desc = "Open terminal"; }
      { mode = "t"; key = "<C-x>"; action = "<C-\\><C-N>"; options.desc = "Exit terminal mode"; }
      { mode = "v"; key = "d"; action = "\"_d"; options.desc = "Delete without yanking"; }
      { mode = "n"; key = "<leader>u"; action = ":UndotreeToggle<CR>"; options.desc = "Toggle undotree"; }
    ];
    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xsel.enable = true;
        xclip.enable = true;
      };
    };
    performance.byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = { action = "git_files"; mode = "n"; options.desc = "Search within git files"; };
          "<leader>ff" = { action = "find_files"; mode = "n"; options.desc = "Search within all files"; };
          "<leader>fw" = { action = "live_grep"; mode = "n"; options.desc = "Search for word in all files"; };
          "<leader>fb" = { action = "buffers"; mode = "n"; options.desc = "Search for all buffers"; };
          "<leader>fh" = { action = "help_tags"; mode = "n"; options.desc = "Search for all available help tags"; };
        };
      };
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
        };
      };
      treesitter-context.enable = true;
      refactoring = {
        enable = true;
        luaConfig = ''
          				vim.api.nvim_set_keymap("v", "<leader>ir", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
          				'';
      };
      undotree.enable = true;
      neocord.enable = true;
    };
  };
}
