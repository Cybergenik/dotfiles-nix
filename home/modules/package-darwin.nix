{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = with pkgs; [
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
      ];
    };
  };
}
