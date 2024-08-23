{pkgs, ...}: {
  programs.starship = {
    enable = true;
    settings = let
      flavour = "mocha";
    in {
      add_newline = true;
      git_commit.only_detached = false;
      git_metrics.disabled = false;
      # palette = "catppuccin_${flavour}";
      format = ''$username$hostname$directory$git_branch$git_state$git_status $cmd_duration$line_break$character'';
      right_format = ''$localip$kubernetes$docker_context$package$golang$lua$nodejs$pulumi$rust$terraform$python$nix_shell$aws$gcloud$direnv$sudo$container'';
      container.format = "[$symbol \[$name\]]($style) ";
      # directory.style = "blue";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = "[$branch]($style)";
        # style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        # style = "cyan";
        conflicted = "";
        untracked = "";
        modified = "";
        staged = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        # style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        # style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style) ";
        # style = "bright-black";
      };
    };
    # // builtins.fromTOML (builtins.readFile
    #   (pkgs.fetchFromGitHub
    #     {
    #       owner = "catppuccin";
    #       repo = "starship";
    #       rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
    #       sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    #     }
    #     + /palettes/${flavour}.toml));
  };
}
