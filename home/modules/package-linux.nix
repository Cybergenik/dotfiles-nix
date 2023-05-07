{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = with pkgs; [
        qemu
        docker
        terraform
        flyctl
        ffmpeg
        yt-dlp
        zathura
        vscode
        zoom-us
      ];
    };
  };
}
