{ config, pkgs, inputs, ... }:

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

    plugins = with pkgs.vimPlugins; [

      {
        plugin = gruvbox-nvim;
        config = toLuaFile ../nvim/lua/configs/gruvbox.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ../nvim/lua/configs/telescope.lua;
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-go
          p.tree-sitter-rust
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        # config = toLuaFile ../nvim/lua/configs/treesitter.lua;
      }

    ];

    # for some reasons some configs are not being loaded from plugins `config`
    # files, so I'll just write the lua code below.
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      ${builtins.readFile ../nvim/lua/configs/telescope.lua}
      ${builtins.readFile ../nvim/lua/configs/keybinds.lua}
      ${builtins.readFile ../nvim/lua/configs/settings.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };
}
