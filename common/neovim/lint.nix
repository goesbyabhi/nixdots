{
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      javascript = [ "eslint" ];
      typescript = [ "eslint" ];
      javascriptreact = [ "eslint" ];
      typescriptreact = [ "eslint" ];
      svelte = [ "eslint" ];
      astron = [ "eslint" ];
      cpp = [ "clangtidy" ];
      html = [ "htmlhint" ];
      go = [ "golangcilint" ];
      kotlin = [ "ktlint" ];
      nix = [ "statix" ];
      python = [ "pylint" ];
    };
    autoCmd = {
      event = [ "BufEnter" "BufWritePost" "InsertLeave" ];
      group = "lint_auGroup";
      callback = {
        __raw = ''
          function()
            local lint = require("lint")
            lint.try_lint()
          end
          '';
      };
    };
  };
}
