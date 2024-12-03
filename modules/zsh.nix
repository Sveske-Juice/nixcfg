{lib, config, pkgs, ... }:

{
  programs.lsd = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
    shellAliases = {
      ls = "lsd";
      nixrebuild = "sudo nixos-rebuild switch --flake /home/sveske/nixos#laptop";
      dev = "nix develop --command zsh";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    # Plugins
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
	"sudo"
      ];
      theme = "robbyrussell";
    };
  };
}
