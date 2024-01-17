{ pkgs, pkgs-unstable, home-manager, vars, lib, config, ... }:

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
    initrd.kernelModules = [ "amdgpu" ];
  };

  #	hardware = {
  #		# opengl = {};
  #	};
  #
  environment = {
    systemPackages = with pkgs; [
    ] ++ (with pkgs-unstable; [
      whatsapp-for-linux
    ]);
  };


  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      layout = "gb";
    };
  };

  # nixpkgs.overlays = [
  #   (final: prev: { 
  #     discord = prev.discord.overrideAttrs (_: { 
  #       src = builtins.fetchTarball <link-to-tarball>; 
  #     }); 
  #   })
  # ];


  # Manage Dotfiles
  home-manager.users.${vars.primaryUser} = {
    home.file = {
      ".config/alacritty" = {
        source = ../../../alacritty/.config/alacritty;
        recursive = true;
      };
      ".config/git" = {
        source = ../../../git/.config/git;
      };
      ".config/nvim" = {
        source = ../../../nvim/.config/nvim;
        # source = config.lib.file.mkOutOfStoreSymlink ../../../nvim/.config/nvim;
        recursive = true;
      };
      ".config/tmux" = {
        source = ../../../tmux/.config/tmux;
        recursive = true;
      };
      ".zshenv".source = ../../../zsh/.zshenv;
      ".config/zsh" = {
        source = ../../../zsh/.config/zsh;
        #source = lib.mkOutOfStoreSymlink ../../../nvim/.config/nvim;
        recursive = true;
      };
    };
  };
}
