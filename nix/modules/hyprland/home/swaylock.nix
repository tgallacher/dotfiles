{
  self,
  inputs,
  system,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      font = "JetBrainsMono Nerd Font";

      clock = true;
      timestr = "%R";
      datestr = "%a, %e of %B";
      # Add current screenshot as wallpaper;
      screenshots = true;
      # Add an image as a background;
      # image=~/.cache/current_wallpaper.jpg;
      # Fade in time;
      fade-in = 1;
      # Effect for background;
      effect-blur = "5x2";
      # effect-greyscale;
      # effect-pixelate=5;
      # Show/Hide indicator circle;
      indicator = true;
      # smaller indicator;
      indicator-radius = 200;
      # bigger indicator;
      # indicator-radius=300;
      indicator-thickness = 20;
      indicator-caps-lock = true;
      # Define all colors;
      key-hl-color = 00000066;
      separator-color = 00000000;
      inside-color = 00000033;
      inside-clear-color = "ffffff00";
      inside-caps-lock-color = "ffffff00";
      inside-ver-color = "ffffff00";
      inside-wrong-color = "ffffff00";
      ring-color = "ffffff";
      ring-clear-color = "ffffff";
      ring-caps-lock-color = "ffffff";
      ring-ver-color = "ffffff";
      ring-wrong-color = "ffffff";

      line-color = 00000000;
      line-clear-color = "ffffffFF";
      line-caps-lock-color = "ffffffFF";
      line-ver-color = "ffffffFF";
      line-wrong-color = "ffffffFF";

      text-color = "ffffff";
      text-clear-color = "ffffff";
      text-ver-color = "ffffff";
      text-wrong-color = "ffffff";

      bs-hl-color = "ffffff";
      caps-lock-key-hl-color = "ffffffFF";
      caps-lock-bs-hl-color = "ffffffFF";
      disable-caps-lock-text = true;
      text-caps-lock-color = "ffffff";
    };
  };
}
