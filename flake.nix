{
  description = "Home Manager configuration of abhi";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, aagl, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
	nixos = lib.nixosSystem {
	  inherit system;
	  modules = [
		  ./configuration.nix
	  	  {
			  imports = [ aagl.nixosModules.default ];
			  nix.settings = aagl.nixConfig; # Set up Cachix
			  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
		  }
	  ];
	};
      };

      homeConfigurations."abhi" = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
        modules = [ ./home.nix ];
	extraSpecialArgs = {
	  inherit pkgs-unstable;
	};
      };
    };
}
