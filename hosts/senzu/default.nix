# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules>
  ];

  users.users.wsl = {
    isNormalUser = true;
    description = "WSL Machine";
    createHome = true;
    shell = pkgs.bash;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  wsl.enable = true;
  wsl.defaultUser = "wsl";

  networking.hostName = "senzu";

  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_CTYPE = "en_IN";
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  environment.systemPackages = with pkgs; [ home-manager ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
