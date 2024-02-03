# Note: Home Manager module
{
  self,
  upkgs,
  pkgs,
  inputs,
  system,
  ...
}: {
  programs.wofi = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.wofi;
    settings = {
      allow_images = true;
      allow_markup = true;
      content_halign = "fill";
      dynamic_lines = true;
      filter_rate = 100;
      gtk_dark = true;
      halign = "fill";
      height = "30%";
      image_size = 32;
      insensitive = true;
      location = "center";
      matching = "fuzzy"; # fuzzy | contains | multi-contains
      no_actions = true;
      orientation = "vertical";
      prompt = "Search...";
      show = "drun";
      terminal = "alacritty";
      width = "50%";
    };
    style = ''
      *{
      	font-family: "JetBrainsMono Nerd Font";
      	min-height: 0;
      	/* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
      	font-size: 98%;
      	font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      	padding: 0px;
      	margin-top: 1px;
      	margin-bottom: 1px;
      }

      #window {
        background-color: #323232;
        border-radius: 8px;
      }

      #outer-box {
        padding: 10px;
      }

      #input {
        background-color: #323232;
        /*border: 1px solid #1e1e2e;*/
        padding: 4px 6px;
        color: #585b70;
      }

      #scroll {
        margin-top: 10px;
        margin-bottom: 10px;
      }

      #inner-box {
        border-radius: 8px;
      }

      #img {
        padding-right: 5px;
      }

      #text {
        color: white;
      }

      #text:selected {
        color: black;
      }

      #entry {
        padding: 3px;
      }

      #entry:selected {
        background: linear-gradient(90deg, #89b4fa, #b4befe, #89b4fa);
        border-radius: 8px;
      }

      #unselected { }

      #selected { }

      #input, #entry:selected {
        border-radius: 10px;
        border: 1px solid #b4befe;
      }
    '';
    # style = ''
    #   window {
    #       margin: 0px;
    #       border: 5px solid #1e1e2e;
    #       background-color: #cdd6f4;
    #       border-radius: 0px;
    #   }

    #   #input {
    #       padding: 4px;
    #       margin: 4px;
    #       padding-left: 20px;
    #       border: none;
    #       color: #cdd6f4;
    #       font-weight: bold;
    #       background-color: #1e1e2e;
    #      	outline: none;
    #       border-radius: 15px;
    #       margin: 10px;
    #       margin-bottom: 2px;
    #   }
    #   #input:focus {
    #       border: 0px solid #1e1e2e;
    #       margin-bottom: 0px;
    #   }

    #   #inner-box {
    #       margin: 4px;
    #       border: 10px solid #1e1e2e;
    #       color: #cdd6f4;
    #       font-weight: bold;
    #       background-color: #1e1e2e;
    #       border-radius: 15px;
    #   }

    #   #outer-box {
    #       margin: 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: #1e1e2e;
    #   }

    #   #scroll {
    #       margin-top: 5px;
    #       border: none;
    #       border-radius: 15px;
    #       margin-bottom: 5px;
    #       /* background: rgb(255,255,255); */
    #   }

    #   #img:selected {
    #       background-color: #89b4fa;
    #       border-radius: 15px;
    #   }

    #   #text:selected {
    #       color: #cdd6f4;
    #       margin: 0px 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: #89b4fa;
    #   }

    #   #entry {
    #       margin: 0px 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: transparent;
    #   }

    #   #entry:selected {
    #       margin: 0px 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: #89b4fa;
    #   }
    # '';
  };
}
