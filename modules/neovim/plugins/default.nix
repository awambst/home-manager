{ pkgs, ... }:
{
  imports = [ ./formatting ];

  programs.nixvim = {

    plugins = {
      gitsigns.enable = true;
      web-devicons.enable = true;

      # Plugin spécialisé pour le folding intelligent
      nvim-ufo = {
        enable = false;
        settings = {
          provider_selector = ''
            function(bufnr, filetype, buftype)
              if filetype == "c" or filetype == "cpp" or filetype == "java" then
                return {"treesitter", "indent"}
              else
                return {"indent"}
              end
            end
          '';
          fold_virt_text_handler = ''
            function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = ('  %d lines '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0

              for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                  table.insert(newVirtText, chunk)
                else
                  chunkText = truncate(chunkText, targetWidth - curWidth)
                  local hlGroup = chunk[2]
                  table.insert(newVirtText, {chunkText, hlGroup})
                  chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  break
                end
                curWidth = curWidth + chunkWidth
              end

              table.insert(newVirtText, {suffix, 'Comment'})
              return newVirtText
            end
          '';
        };
      };

      # File explorer
      neo-tree = {
        enable = true;
        settings.window = {
          width = 40; # Adjust this number (default is usually 40)
        };
      };

      # Fuzzy finder
      telescope = {
        enable = true;
        extensions = {
          live-grep-args.enable = true;
          ui-select = {
            enable = true;
            settings.specific_opts = {
              codeactions = true;
            };
          };
        };
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
          };
          "<leader>fg" = {
            action = "live_grep";
          };
        };
      };

      # LSP - LE TRUC IMPORTANT !
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          pyright.enable = true;

          # LSP pour Java
          jdtls = {
            enable = true;
            extraOptions = {
              cmd = [
                "jdtls"
                "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
              ];
            };
          };

          # LSP pour C/C++
          clangd.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          cssls.enable = true;
          html.enable = true;
          ltex.enable = true;
          ocamllsp.enable = true;
          postgres_lsp.enable = true;
          matlab_ls.enable = true;
          gitlab_ci_ls.enable = true;

        };
      };

      # AUTOCOMPLÉTION
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; } # Suggestions du LSP
            { name = "buffer"; } # Mots du fichier
            { name = "path"; } # Chemins de fichiers
            { name = "luasnip"; } # Snippets
          ];
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
          };
        };
      };

      # Plugins pour l'autocomplétion
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;

      # Snippets prédéfinis
      friendly-snippets.enable = true;
      comment.enable = true;
      luasnip.enable = true;

      # Syntax highlighting
      treesitter = {
        enable = true;
        nixGrammars = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          angular
          bash
          c
          cpp
          css
          haskell
          html
          htmldjango
          ini
          java
          json
          lua
          markdown
          nix
          python
          rust
          sql
          toml
          yaml
          # Add other languages you need
        ];

        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection.enable = true;
          fold = {
            enable = true;
            # Seulement les éléments spécifiés
            fold_one_liner = false;
          };
        };
      };

      # Interface - the bar at the bottom
      lualine.enable = true;

    };
  };
}
