{ config, pkgs, ... }:
let
  username = "juselara";
  home_path = "/home/${username}";
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.username = "${username}";
  home.homeDirectory = "${home_path}";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # general
    git gnumake

    # images
    sxiv zathura inkscape

    # command line
    zoxide bat jq fzf unzip zip btop tree gh tmux
    nix-search-cli monaspace chezmoi starship

    # browser
    google-chrome

    # password
    pass

    # desktop
    eww pulsemixer grim slurp wl-clipboard swww

    # text editor
    neovim tree-sitter

    # terminal emulator
    alacritty
  ];

  programs.home-manager.enable = true;
}
