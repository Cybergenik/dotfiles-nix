{ inputs, ... }@flakeContext:
let
  darwinModule = { config, lib, pkgs, ... }: {
    imports = with inputs; [
      home-manager.darwinModules.home-manager
      self.darwin.modules.default
      self.darwin.modules.overlay
      self.home.modules
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
    config.system.stateVersion = 4;
  };
in
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    darwinModule
  ];
  system = "x86_64-darwin";
}
