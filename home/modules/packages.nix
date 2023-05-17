{ inputs, ... }@context:
{ config, lib, pkgs, ... }: {
  config.home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cacert
    nix
    cachix
    direnv
    coreutils
    llvm
    rustup
    go
    python312
    nodejs
    tmux
    bat
    htop
    curl
    wget
    ripgrep
    git
    jq
    mcfly
    gnupg
    neovim
    fzf
    fd
    tree-sitter
    entr
    mpv-unwrapped
    neofetch
    discord
    nodePackages_latest.gatsby-cli
    pnpm
  ] ++ (lib.optionals pkgs.stdenv.isDarwin [
    qemu
    lima
    colima
    docker
    terraform
    smimesign
    ffmpeg
    yt-dlp
    zathura
    iterm2
    raycast
    zoom-us
  ]) ++ (lib.optionals pkgs.stdenv.isLinux [
    qemu
    docker
    terraform
    flyctl
    ffmpeg
    yt-dlp
    zathura
    vscode
    zoom-us
  ]);
}
