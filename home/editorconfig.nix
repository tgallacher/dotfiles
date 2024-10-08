{self, ...}: {
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        end_of_line = "lf";
        # indent_size = 2;
        charset = "utf-8";
      };
      # "*.py" = {
      #   indent_size = 4;
      # };
    };
  };
}
