{lib, config, pkgs, ... }:

{
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true; # Use alias vi = nvim
    vimAlias = true; # Use alias vim = nvim
    vimdiffAlias = true; # Use nvim for vimdiff

    extraPackages = with pkgs; [
      tree-sitter
      ripgrep # dep for telescope

      nodejs
      dotnetCorePackages.sdk_9_0
      clang
      nil # nix
      gcc
      cargo # dep for most lsps

      # Formatters
      clang-tools # C/C++
      jq # JSON
      stylua # Lua
    ];

    extraLuaConfig = ''
      ${builtins.readFile .nvim/options.lua}

      ${builtins.readFile .nvim/plugin/comment.lua}
      ${builtins.readFile .nvim/plugin/conform.lua}
      ${builtins.readFile .nvim/plugin/lsp.lua}
      ${builtins.readFile .nvim/plugin/telescope.lua}
      ${builtins.readFile .nvim/plugin/treesitter.lua}
    '';

    plugins = with pkgs.vimPlugins; [
    	# Lsp
        mason-nvim
        mason-lspconfig-nvim
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
        fidget-nvim
      	nvim-lspconfig

        # Telescope
        plenary-nvim
        telescope-ui-select-nvim
        telescope-nvim
        trouble-nvim

       	nvim-treesitter.withAllGrammars
        nvim-treesitter-context

        which-key-nvim

        comment-nvim

        conform-nvim

        # themes
        tokyonight-nvim
        kanagawa-nvim
        gruvbox-nvim
        everforest
        onedark-nvim
        nordic-nvim
        vscode-nvim
        {
          plugin = rose-pine;
          config = "colorscheme kanagawa";
        }
    ];

  };
}
