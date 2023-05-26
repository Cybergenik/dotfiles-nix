{ inputs, ... }@context:
let
  context = {
    inherit inputs;
  };

  configurations = import ./modules/configurations.nix;
  overlays = import ./modules/overlays.nix context;

  darwinModule = { config, lib, pkgs, ... }: {
    config.system.stateVersion = 4;

    imports = with inputs; [
      configurations
      overlays
      home-manager.darwinModules.home-manager
      self.homeConfigurations.luciano.homeModule
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
  system = "aarch64-darwin";
}
