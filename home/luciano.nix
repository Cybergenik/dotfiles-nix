{ inputs, ... }@context:
let
  homeModule = { config, lib, pkgs, ... }: {
    config.home.stateVersion = "23.05";
    imports = with inputs.self.home.modules; [
      configurations
      activation
      packages
    ];
  };
  nixosModule = { ... }: {
    home-manager.users.luciano = homeModule;
  };
in
(
  inputs.utils.lib.eachSystem [
    "aarch64-darwin"
    "x86_64-darwin"
    "aarch64-linux"
    "x86_64-linux"
  ]
    (system:
      inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          homeModule
        ];
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      }
    ) // { inherit nixosModule; }
)
