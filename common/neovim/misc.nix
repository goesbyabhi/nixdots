{
  programs.nixvim.plugins = {
    nvim-autopairs.enable = true;
    gitsigns.enable = true;
    colorizer.enable = true;
    neocord = {
      enable = true;
      settings = { global_timer = true; };
    };
    direnv.enable = true;
  };
}
