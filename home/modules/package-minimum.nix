{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = with pkgs; [
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
      ];
    };
  };
}
