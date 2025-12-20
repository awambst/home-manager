{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      # Formatters pour différents langages
      nixfmt-rfc-style # .nix
      rustfmt # .rs
      black # .py
      prettierd # .js, .ts, .json, .html, .css
      clang-tools # .c, .cpp, .java
      shfmt # .sh
      stylua # .lua
    ];

    autoCmd = [
      {
        event = "FileType";
        pattern = "conf";
        command = "setlocal shiftwidth=4 tabstop=4 expandtab";
      }
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal shiftwidth=2 tabstop=2 expandtab";
      }
      {
        event = "FileType";
        pattern = "css";
        command = "setlocal iskeyword+=@-@"; # Permet @ dans les mots CSS : NON
      }
    ];

    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        nix = [ "nixfmt" ];
        rust = [ "rustfmt" ];
        python = [ "black" ];
        javascript = [ "prettierd" ];
        typescript = [ "prettierd" ];
        json = [ "prettierd" ];
        html = [ "prettierd" ];
        css = [ "prettierd" ];
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        sh = [ "shfmt" ];
        lua = [ "stylua" ];
        java = [ "clang_format" ];
        conf = [ "clang_format" ]; # machin trim avant, Nettoie les espaces
        cs = [ "csharpier" ];
      };

      settings.formatters = {

        nixfmt = {
          prepend_args = [
            "--indent=2"
            "--width=80"
          ];
        };
        # Rust - rustfmt
        rustfmt = {
          prepend_args = [
            "--config"
            "tab_spaces=4,max_width=80"
          ];
        };

        # Python - black
        black = {
          prepend_args = [
            "--line-length"
            "80"
            "--skip-string-normalization"
          ];
        };

        # JavaScript/TypeScript - prettier
        prettierd = {
          prepend_args = [
            "--tab-width"
            "4"
            "--print-width"
            "80"
            "--use-tabs"
            "false"
          ];
        };

        # C/C++ - clang-format
        clang_format = {
          prepend_args = [
            "--style=file"
            "--fallback-style=LLVM"
            "$FILENAME"
          ];
        };

        # Shell - shfmt
        shfmt = {
          prepend_args = [
            "-i"
            "4" # 4 espaces d'indentation
            "-ci" # Indenter case
          ];
        };

        # Lua - stylua
        stylua = {
          prepend_args = [
            "--indent-type"
            "Spaces"
            "--indent-width"
            "4"
            "--column-width"
            "80"
          ];
        };
        csharpier = {
          prepend_args = [
            "--write-stdout"
            "--print-width"
            "80"
            "--tab-width"
            "4"
            "--use-tabs"
            "false"
          ];
        };
      };
    };
  };
}
