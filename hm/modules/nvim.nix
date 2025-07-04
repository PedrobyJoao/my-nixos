{ config
, pkgs
, inputs
, ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # for some reasons some configs are not being loaded from plugins `config`
    # files, so I'll just write the lua code below.
    extraLuaConfig = ''
      vim.g.codeium = "${pkgs.codeium}/bin/codeium"
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

      luasnip
      cmp-nvim-lsp
      nvim-cmp
      none-ls-nvim
      lspkind-nvim

      {
        plugin = Coqtail;
        config = builtins.readFile ../nvim/configs/coq.lua;
        type = "lua";
      }

      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ../nvim/configs/lsp.lua;
        type = "lua";
      }

      # {
      #   plugin = nvim-lint;
      #   config = builtins.readFile ../nvim/configs/linter.lua;
      #   type = "lua";
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
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-nim
          p.tree-sitter-elm
          p.tree-sitter-haskell
          p.tree-sitter-go
          p.tree-sitter-rust
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]);
      }

      {
        plugin = nvim-autopairs;
        config = ''
          require("nvim-autopairs").setup({})
        '';
        type = "lua";
      }

      {
        plugin = windsurf-vim;
        config = ''
          vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
          vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        '';
        type = "lua";
      }

    ];

    # Maybe I should activate these pkgs on the code shells instead for each repo
    extraPackages = with pkgs; [
      # Nix
      nil
      statix
      nixfmt-rfc-style
      nixpkgs-fmt

      # Go
      go
      gofumpt
      goimports-reviser
      golangci-lint
      gopls

      # Lua
      lua-language-server
      # stylua
      # lua54Packages.luacheck

      # elm
      elmPackages.elm-language-server

      # Shell scripting
      shellcheck

      # Python
      # use nix flakes of projects

      # Haskell
      haskellPackages.haskell-language-server
      stylish-haskell

      # web tools (js mostly)
      nodePackages_latest.prettier
      eslint_d

      # Telescope tools
      ripgrep

      # lsps
      codeium
    ];
  };
}
