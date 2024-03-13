{ self
, pkgs
, ...
}: {
  programs.starship = {
    enable = true;
    settings =
      let
        flavour = "mocha";
      in
      {
        add_newline = true;
        git_commit.only_detached = false;
        git_metrics.disabled = false;
        palette = "catppuccin_${flavour}";
        container = {
          format = "[$symbol \[$name\]]($style) ";
        };
      }
      // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          }
        + /palettes/${flavour}.toml));
  };
}
