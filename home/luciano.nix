{ inputs, ... }@flakeContext:
let
  homeModule = { config, lib, pkgs, ... }: {
    imports = with inputs.self.home.modules; [
      default
      #activation
      package-darwin
      package-minimum
    ];
    config = {
      home = {
        stateVersion = "23.05";
      };
    };
  };
  nixosModule = { ... }: {
    home-manager.users.luciano = homeModule;
  };
in
(
  (
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        homeModule
      ];
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
    }
  ) // { inherit nixosModule; }
)
