{ lib, unstable, fInputs, cVars, config, pkgs, host, ... }:

{
#	imports = (
#		import ../modules/?.nix
#	);

  nix = {
	  package = pkgs.nixVersions.unstable;
	  settings = {
			auto-optimise-store = true;
			experimental-features = [ "nix-command" "flakes" ];
	  };
	  # gc = {
	  # 	automatic = true;
	  #       dates = "weekly";
	  #       options = "--delete-older-than 7d";
	  # };
	}; 

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  		# Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = host.hostName;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services = {
		printing.enable = false;

		pipewire = {
			enable = true;
			alsa = {
				enable = true;
				support32Bit = true;
			};
			pulse.enable = true;
			jack.enable = true;
		};

		openssh = {
			enable = true;
		#	allowSFTP = true;
		#	extraConfig = ''
		#		HostKeyAlgorithms +ssh-rsa
		#	'';
		};
	};

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security = {
		rtkit.enable = true;
		polkit.enable = true;
		sudo.wheelNeedsPassword = false;
	};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
		variables = {
			TERMINAL = "${cVars.terminal}";
			EDITOR = "${cVars.editor}";
			VISUAL = "${cVars.editor}";
		};

		systemPackages = with pkgs; [
			# CLI
			pkgs."${cVars.terminal}" 	# Terminal emulator
			btop 								# Resource manager
			curl 								# Fetch stuff
			difftastic					# Diff visualiser
			direnv							# Dynamic shell configs
			dwdiff							# Another diff visualiser
			fzf									# Find stuff
			git									# Version
			home-manager 				# Nix home dir manaager
			iperf								# Network performance
			neovim							# The only editor
			tmux								# Terminal super powers
			ranger 							# File manager
			tldr 								# Man docs helper

			# Audio/Video
			alsa-utils 					# Audio control
			feh 								# Image viewer
			mpv 								# Media player
			pipewire 						# Audio server/control
			pulseaudio					# Audio server/control
			vlc 								# Media player

			# Apps

			# File Management
			okular 							# PDF viewer
			p7zip 							# File encryption
			rsync 							# File transfer
			unzip 							# Zip files
			unrar 							# Rar files
			zip 								# Zip
		] ++
		(with unstable; [
			# Apps
			_1password-gui  		# Secrets
			brave 							# Web browser
		]);
	};

	fonts.packages = with pkgs; [
		carlito 										# NixOS
		vegur 											# NixOS
		jetbrains-mono
		font-awesome
		(nerdfonts.override {
			fonts = [
				"FiraCode"
			];
		})
	];

  programs = {
		zsh.enable = true;
	};

  users.users.${cVars.primaryUser} = {
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ]; # "wheel" -> Enable ‘sudo’ for the user.
    initialPassword = "Passw0rd!";
    isNormalUser = true;
  };

	home-manager.users.${cVars.primaryUser} = {
		home.stateVersion = "23.05";
		programs.home-manager.enable = true;
	};

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

