{ pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		kernelPackages = pkgs.linuxPackages_latest;
		initrd.kernelModules = ["amdgpu"];
	};

#	hardware = {
#		# opengl = {};
#	};
#
#	environment = {
#		systemPackages = with pkgs; [ ];
#	};


	services = {
		xserver = {
			enable = true;
			displayManager.sddm.enable = true;
			desktopManager.plasma5.enable = true;
			layout = "gb";
		};
	};
}
