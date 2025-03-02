{
  description = "Home Manager configuration of abhi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nur = { url = "github:nix-community/NUR"; };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, nixos-wsl, home-manager, aagl, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit (nixpkgs) lib;
    in {
      nixosConfigurations = {
        nimbus = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nimbus
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig; # Set up Cachix
              programs.anime-game-launcher.enable =
                true; # Adds launcher and /etc/hosts rules
            }
          ];
        };

        senzu = lib.nixosSystem {
          inherit system;
          modules = [ nixos-wsl.nixosModules.default ./hosts/senzu ];
        };
      };

      homeConfigurations."abhi" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit pkgs-stable;
          inherit system;
          overlays = [
            (import ./overlays/zed-editor.nix)
          ];
        };
        modules = [ ./users/abhi ./common ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit inputs;
          inherit system;
        };
      };

      homeConfigurations."wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit pkgs-unstable;
          inherit system;
        };
        modules = [ ./users/wsl ./common ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit inputs;
          inherit system;
        };
      };
    };
}
