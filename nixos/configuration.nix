# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
	imports =
		[
# Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Bootloader.
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
		systemd-boot.configurationLimit = 3;
	};

	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.
	i18n = {
		defaultLocale = "en_IN";
		inputMethod = {
			type = "ibus";
			ibus.engines = with pkgs.ibus-engines; [
				uniemoji
			];
		};
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
# Enable the X11 windowing system.
	services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome = {
		enable = true;
		extraGSettingsOverridePackages = with pkgs;[
			nautilus
		];
	};
# services.xserver.windowManager.openbox.enable = true;
	services.xserver.windowManager.session = [{
		name = "onyx";
		start = "/home/abhi/Documents/Dev/projs/cpp/onyx/result/bin/onyx_x86_64-linux";
	}];

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Enable CUPS to print documents.
	services.printing.enable = true;

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
	hardware.nvidia.modesetting.enable = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
	hardware.nvidia.nvidiaSettings = true;
	hardware.nvidia.forceFullCompositionPipeline = true;
	hardware.nvidia.prime = {
		offload = {
			enable = true;
			enableOffloadCmd = true;
		};

		amdgpuBusId = "PCI:5:0:0";
		nvidiaBusId = "PCI:1:0:0";
	};

	specialisation = {
		gaming.configuration = {
			hardware.nvidia.prime.sync.enable = lib.mkForce true;
			hardware.nvidia.prime.offload = {
				enable = lib.mkForce false;
				enableOffloadCmd = lib.mkForce false;
			};
		};
	};

	programs.steam = {
		enable = true;
		gamescopeSession.enable = true;
		extraCompatPackages = with pkgs;[
			proton-ge-bin
		];
	};

	programs.gamemode.enable = true;

	services.udev.packages = [ pkgs.gnome-settings-daemon ];

# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
	};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.abhi = {
		isNormalUser = true;
		description = "Abhishek Panda";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [
#  thunderbird
		];
	};

# Install firefox.
	programs.firefox.enable = true;

	programs.droidcam.enable = true;

	virtualisation.docker = {
		enable = true;
		rootless = {
			enable = true;
			setSocketVariable = true;
		};
		daemon.settings = {
			data-root = "~/.docker-data";
			userland-proxy = false;
			experimental = true;
			metrics-addr = "0.0.0.0:9323";
			ipv6 = true;
			fixed-cidr-v6 = "fd00::/80";
		};
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
# vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
# wget
# git
		gjs
			wineWowPackages.stable
			wineWowPackages.waylandFull
			winetricks
			auto-cpufreq
			(
			 let base = pkgs.appimageTools.defaultFhsEnvArgs; in
			 pkgs.buildFHSUserEnv (base // {
				 name = "fhs";
				 targetPkgs = pkgs:
# pkgs.buildFHSUserEnv provides only a minimal FHS environment,
# lacking many basic packages needed by most software.
# Therefore, we need to add them manually.
#
# pkgs.appimageTools provides basic packages required by most software.
				 (base.targetPkgs pkgs) ++ (with pkgs; [
					 pkg-config
					 ncurses
# Feel free to add more packages here if needed.
				 ]
				 );
				 profile = "export FHS=1";
				 runScript = "bash";
				 extraOutputsToInstall = [ "dev" ];
				 })
			)
				];

			environment.gnome.excludePackages = with pkgs; [
				gnome-calendar
					gnome-contacts
					gnome-maps
					epiphany
					snapshot
					geary
					yelp
			];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

			services.power-profiles-daemon.enable = false;
			services.auto-cpufreq.enable = true;
			services.flatpak.enable = true;

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

			networking.firewall.allowedTCPPorts = lib.range 1714 1764;
			networking.firewall.allowedUDPPorts = lib.range 1714 1764;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
			system.stateVersion = "24.05"; # Did you read the comment?

				nix = {
					settings.experimental-features = [ "nix-command" "flakes" ];
					settings.auto-optimise-store = true;
					optimise.automatic = true;
					settings.extra-substituters = [
						"https://nix-community.cachix.org"
							"https://nix-gaming.cachix.org"
							"https://ezkea.cachix.org"
					];
					settings.trusted-public-keys = [
						"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
							"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
							"ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
					];
					gc = {
						automatic = true;
						dates = "weekly";
						options = "--delete-older-than 7d";
					};
				};
}
