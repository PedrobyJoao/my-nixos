{ config
, pkgs
, inputs
, ...
}:

{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      # for some reasons some configs are not being loaded from plugins `config`
      # files, so I'll just write the lua code below.
      extraLuaConfig = ''
        vim.g.mapleader = ' '
        ${builtins.readFile ../nvim/keybinds.lua}
        ${builtins.readFile ../nvim/settings.lua}
        ${builtins.readFile ../nvim/configs/treesitter.lua}
        ${builtins.readFile ../nvim/configs/telescope.lua}
      '';

      plugins = with pkgs.vimPlugins; [
        # telescope and requireds
        telescope-nvim
        plenary-nvim

        # icons (required for nvim-tree)
        nvim-web-devicons

        nvim-cmp
        luasnip
        # {
        #     plugin = nvim-lspconfig;
        #     config = builtins.readFile ../nvim/configs/lsp.lua;
        #     type = "lua";
        # }

        {
          plugin = conform-nvim;
          config = builtins.readFile ../nvim/configs/formatting.lua;
          type = "lua";
        }

        {
          plugin = gruvbox-nvim;
          config = builtins.readFile ../nvim/configs/gruvbox.lua;
          type = "lua";
        }

        {
          plugin = nvim-tree-lua;
          config = builtins.readFile ../nvim/configs/nvim-tree.lua;
          type = "lua";
        }

        {
          plugin = toggleterm-nvim;
          type = "lua";
          config = builtins.readFile ../nvim/configs/toggleterm.lua;
        }

        {
          plugin = (
            nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-go
              p.tree-sitter-rust
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
            ])
          );
        }

        {
          plugin = nvim-autopairs;
          config = ''
            require("nvim-autopairs").setup({})
          '';
          type = "lua";
        }

        {
          plugin = codeium-nvim;
          config = ''
            vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#Clear']() end, { expr = true })
          '';
          type = "lua";
        }
      ];

      extraPackages = with pkgs; [
        # Nix
        # statix
        nixfmt-rfc-style
        nixpkgs-fmt

        # Go
        gofumpt
        goimports-reviser
        # gopls
        # golangci-lint

        # Lua
        stylua

        # Shell scripting
        shellcheck

        # Python
        black

        # web tools
        nodePackages_latest.prettier

        # Telescope tools
        ripgrep
      ];
    };
}
