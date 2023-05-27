{ inputs, ... }@context:
let
  context = {
    inherit inputs;
  };

  configurations = import ./modules/configurations.nix;
  overlays = import ./modules/overlays.nix context;

  darwinModule = { config, lib, pkgs, ... }: {
    config.system.stateVersion = 4;

    imports = [
      configurations
      overlays
      inputs.home-manager.darwinModules.home-manager
      inputs.self.homeConfigurations.luciano.homeModule
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        users.users.luciano = {
          description = "Darwin only configs";
          name = "luciano";
          home = "/Users/luciano";
        };
      }
    ];
  };
in
inputs.darwin.lib.darwinSystem {
  modules = [
    darwinModule
  ];
  system = "x86_64-darwin";
}
