{ pkgs, ... }: {
  programs.urxvt = {
    enable = true;
    package = pkgs.rxvt-unicode-emoji;
    iso14755 = false;
    fonts = [
      "xft:IosevkaCustom Nerd Font:style=Regular:size=14"
    ];
    scroll.bar = {
      enable = false;
      style = "rxvt";
    };
    keybindings = {
      "Shift-Control-T" = "tabbedalt:new_tab";
      "M-u" = "perl:url-select:select_next";
      "Shift-Control-C" = "eval:section_to_clipboard";
      "Shift-Control-V" = "eval:paste_clipboard";
      "Shift-Up" = "command:\033]720;1\007";
      "Shift-Down" = "command:\033]721;1\007";
      "Control-Left" = "\033[1;5D";
      "Control-Right" = "\033[1;5C";
      "C-equal" = "font-size:reset";
      "C-slash" = "font-size:show";
      "Control-0xffab" = "perl:font-size:increase";
      "Control-0xffad" = "perl:font-size:decrease";
    };
    extraConfig = {
      foreground = "#ffffff";
      background = "#000000";
      cursorColor = "#ffffff";
      color0 = "#000000";
      color8 = "#38372c";
      color1 = "#571dc2";
      color9 = "#7c54b0";
      color2 = "#14db49";
      color10 = "#a2e655";
      color3 = "#403d70";
      color11 = "#9c6f59";
      color4 = "#385a70";
      color12 = "#819ddb";
      color5 = "#384894";
      color13 = "#5e6c99";
      color6 = "#4f3a5e";
      color14 = "#667d77";
      color7 = "#999999";
      color15 = "#ffffff";
      internalBorder = 8;
      cursorBlink = false;
      cursorUnderline = false;
      geometry = "80x240+0+0";
      saveline = 10000;
      termName = "rxvt-unicode-256color";
      perl-lib = "~/.urxvt/ext/";
      perl-ext = "tabbedalt";
      "tabbedalt.new-button" = false;
      "tabbedalt.tabbar-fg" = 15;
      "tabbedalt.tabbar-bg" = 0;
      "tabbedalt.tab-fg" = 15;
      "tabbedalt.tab-bg" = 0;
      "tabbedalt.active-fg" = 3;
      "tabbedalt.actives-fg" = 0;
      "tabbedalt.autohide" = true;
      "tabbedalt.tab-numbers" = false;
      perl-ext-common = "default,selection-to-clipboard,matcher,keyboard-select,font-size,url-select";
      underlineURLs = true;
      url-launcher = "/home/abhi/.nix-profile/bin/firefox";
      "matcher.button" = 1;
      "*clipboard.autocopy" = true;
    };
  };
  home.file = {
    ".urxvt/ext".source = ./perls;
  };
}
