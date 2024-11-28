{ pkgs, ... }:
let
  extensions = with pkgs.gnomeExtensions; [
    dash-to-dock.extensionUuid
    gradient-top-bar.extensionUuid
    blur-my-shell.extensionUuid
    paperwm.extensionUuid
    appindicator.extensionUuid
    system-monitor.extensionUuid
    gradient-top-bar.extensionUuid
    compact-top-bar.extensionUuid
  ];
in
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = extensions;
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        cursor-theme = "McMojave-cursors";
      };
      "org/gnome/shell/extensions/paperwm" = {
        selection-border-size = 5;
        show-focus-mode-icon = false;
        show-window-position-bar = false;
        show-workspace-indicator = false;
        show-open-position-icon = false;
        window-gap = 15;
        vertical-margin = 5;
        vertical-margin-bottom = 8;
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = true;
        static-blur = true;
        unblur-in-overview = true;
      };
      "org/gnome/shell/extensions/blur-my-shell/window-list" = {
        blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell" = {
        hacks-level = 0;
      };
      "org/gnome/shell/extensions/system-monitor" = {
        show-upload = false;
        show-download = false;
      };
      "org/gnome/shell/extensions/org/pshow/gradienttopbar" = {
        opaque-on-maximized = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        focus-mode = "sloppy";
        auto-raise = true;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        dash-max-icon-size = 38;
        custom-theme-shrink = true;
      };
    };
  };
}
