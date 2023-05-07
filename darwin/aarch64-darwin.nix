{ inputs, ... }@context:
let
  darwinModule = { config, lib, pkgs, ... }: {
    imports = with inputs; [
      home-manager.darwinModules.home-manager
      self.darwin.modules.configurations
      self.darwin.modules.overlays
      self.homeConfigurations.luciano.nixosModule
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        users.users.luciano = {
          description = "Luciano Remes";
          name = "luciano";
          home = "/Users/luciano";
        };
      }
    ];
    config.system.stateVersion = 4;
  };
in
inputs.darwin.lib.darwinSystem {
  modules = [
    darwinModule
  ];
  system = "aarch64-darwin";
}
