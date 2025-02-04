{ pkgs, inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymap.nix
    ./lazy.nix
    ./lsp.nix
    ./cmp.nix
    ./lint.nix
    ./tabby.nix
    ./misc.nix
    ./format.nix
  ];
  home.packages = with pkgs; [
    statix
    clang-tools
    htmlhint
    ktlint
    pylint
    golangci-lint
  ];
  programs.nixvim = {
    enable = true;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      swapfile = false;
      backup = false;
      undofile = true;
      undodir.__raw = ''os.getenv("HOME") .. "/.nvim/undodir"'';
      updatetime = 50;
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
      softtabstop = 2;
      shiftwidth = 2;
      laststatus = 3;
      signcolumn = "auto";
      expandtab = false;
      smartindent = true;
      showcmd = true;
      # cmdheight = 2;
      sidescrolloff = 15;
      fillchars = "eob: ";
      completeopt.__raw = ''{"menuone", "noselect"}'';
      splitbelow = true;
      splitright = true;
      termguicolors = true;
    };

    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xclip.enable = true;
        xsel.enable = true;
      };
    };

    # colorschemes.nightfox = {
    # 	enable = false;
    # 	flavor = "carbonfox";
    # };

    autoCmd = [
      {
        desc = "True text centering";
        event = [ "CursorMoved" "CursorMovedI" ];
        pattern = [ "*" ];
        callback = {
          __raw = ''
            function()
            local pos = vim.fn.getpos('.')
            vim.cmd('normal! zz')
            vim.fn.setpos('.', pos)
            end
          '';
        };
      }
      {
        desc = "Remove line numbers from terminal";
        event = [ "TermOpen" ];
        pattern = [ "*" ];
        command = "setlocal nonumber norelativenumber";
      }
      {
        desc = "Remove trailing whitespaces on save";
        event = [ "BufWritePre" ];
        pattern = [ "*" ];
        command = "%s/\\s\\+$//e";
      }
    ];

    autoGroups = { lint_auGroup = { clear = true; }; };

    extraConfigLua = ''
      vim.cmd('set path+=**')
      vim.cmd('filetype plugin on')
      vim.cmd('set wildmenu')
      vim.diagnostic.config({
      	virtual_text = true,
      	float = {
      		focusable = true,
      		border = "rounded",
      		source = "always",
      	},
      	signs = true,
      	underline = true,
      	update_in_insert = true
      })
      local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
      for type, icon in pairs(signs) do
      		local hl = "DiagnosticSign" .. type
      		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.api.nvim_create_autocmd("CursorHold", {
      	buffer = bufnr,
      	callback = function()
      		local opts = {
      			focusable = false,
      			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      			border = 'rounded',
      			source = 'always',
      			prefix = ' ',
      			scope = 'cursor',
      						}
      		vim.diagnostic.open_float(nil, opts)
      	end
      })
    '';
  };
}
