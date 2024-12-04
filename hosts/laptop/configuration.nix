{lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/drivers/nvidia.nix
    ../../modules/drivers/pipewire.nix
    ../../modules/drivers/bluetooth.nix
    ../../modules/syncthing.nix

    ../../modules/greetd.nix
    ../../modules/locales/en_dk.nix
    ../../modules/global-pkgs.nix
    ../../modules/fonts.nix
    ../../modules/stylix
    ../../modules/thunar.nix
    ../../modules/home-manager/qt.nix

    ../../modules/hyprland.nix
      
     # Laptop specifics
     ./boot.nix
     ./networking.nix
     ./pkgs.nix
  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  nixpkgs.config.allowBroken = true;

  # Setup home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {

      "sveske" = import ./home.nix;
    };
  };

  /* programs.uwsm.package = {
    enable = true;
    waylandCompositors = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  }; */


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.sveske = {
    isNormalUser = true;
    description = "Sveske Juice";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.sessionVariables = {
    # https://discussion.fedoraproject.org/t/gdk-message-error-71-protocol-error-dispatching-to-wayland-display/127927/1
    GSK_RENDERER = "gl";
  };

  system.stateVersion = "24.05";

}
