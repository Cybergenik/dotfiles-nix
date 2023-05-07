{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    nixpkgs = {
      overlays = [
        (self: super: {
          raycast = inputs.raycast-overlay.packages.${super.system}.raycast;
        })
      ];
    };
  };
}
