{self, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      git_commit.only_detached = false;
      git_metrics.disabled = false;
    };
  };
}
