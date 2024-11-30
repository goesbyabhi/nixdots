let
  HEIGHT_RATIO = 0.8;
  WIDTH_RATIO = 0.5;
in
{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    disableNetrw = true;
    hijackNetrw = true;
    respectBufCwd = true;
    syncRootWithCwd = true;
    view = {
      number = false;
      signcolumn = "no";
    };
    width.__raw = ''function()
							math.floor(vim.opt.columns:get() * ${WIDTH_RATIO})
						end
      		'';
    float = {
      enable = true;
      openWinConfig = {
        border = "rounded";
        style = "minimal";
        relative = "editor";
      } // (
        let
          screen_w.__raw = ''vim.opt.columns:get()'';
          screen_h.__raw = ''vim.opt.lines:get() - vim.opt.cmdheight:get()'';
          window_w = screen_w * WIDTH_RATIO;
          window_h = screen_h * HEIGHT_RATIO;
          window_w_int = builtins.floor (window_w);
          window_h_int = builtins.floor (window_h);
          center_x = (screen_w - window_w) / 2;
          center_y.__raw = ''((vim.opt.lines:get() - ${window_h}) / 2 - vim.opt.cmdheight:get())'';
        in
        {
          row = center_y;
          col = center_x;
          width = window_w_int;
          height = window_h_int;
        }
      );
    };
  };
}
