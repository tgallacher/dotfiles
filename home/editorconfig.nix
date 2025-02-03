{self, ...}: {
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        end_of_line = "lf";
        indent_size = 2;
        charset = "utf-8";
      };
      "*.sh" = {
        # like -i=4
        indent_style = "space";
        indent_size = 2;
        # --language-variant
        shell_variant = "bash";
        binary_next_line = true;
        # --case-indent
        switch_case_indent = true;
        space_redirects = true;
        keep_padding = true;
        # --func-next-line
        function_next_line = true;
      };
      # "*.py" = {
      #   indent_size = 4;
      # };
    };
  };
}
