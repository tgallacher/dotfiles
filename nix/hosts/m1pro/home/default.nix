{
self,
config,
pkgs,
upkgs,
inputs,
system,
vars,
...
}: {
	imports = [
		../../../../home/terminal
		../../../../home/nvim
	];

	home = {
		username = vars.username;
		homeDirectory = "/Users/${vars.username}";
		stateVersion = "23.11";
	};

	home.packages = [];

	# Let Home Manager manage itself (standalone use)
	programs.home-manager.enable = true;
}
