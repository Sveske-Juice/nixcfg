{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    btop
    tmux
    unzip
    killall
    (import ../coolscript.nix { inherit config pkgs; })
  ];
}
