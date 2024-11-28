{ pkg, inputs, ... }: {
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = false;
      theme = spicePkgs.themes.sleek;
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
      ];
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        beautifulLyrics
        seekSong
      ];
    };
}
