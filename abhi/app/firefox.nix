{ inputs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.abhi = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        darkreader
        ublock-origin
        vimium
      ];
    };
  };
}
