{ pkgs, ... }:
let
  extensions = with pkgs.gnomeExtensions; [
    dash-to-dock.extensionUuid
    blur-my-shell.extensionUuid
    # paperwm.extensionUuid
    appindicator.extensionUuid
    system-monitor.extensionUuid
    gradient-top-bar.extensionUuid
    compact-top-bar.extensionUuid
    desktop-icons-ng-ding.extensionUuid
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
        hot-keys = false;
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
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        toggle-maximized = [ "<Super>m" ];
        toggle-fullscreen = [ "<Super>f" ];

        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];

        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
      };
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        switch-to-application-10 = [ ];
        toggle-message-tray = [ ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "wezterm";
        name = "Launch terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>b";
        command = "firefox";
        name = "Launch firefox";
      };
    };
  };
}
