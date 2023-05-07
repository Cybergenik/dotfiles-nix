{
  description = "Cybergenik";

  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";

    utils.url = "flake:flake-utils";

    darwin = {
      url = "flake:nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "flake:home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    raycast-overlay = {
      url = "github:stepbrobd/raycast-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      context = {
        inherit inputs;
      };
    in
    {
      homeConfigurations = {
        luciano = import ./home/luciano.nix context;
      };
      darwinConfigurations = {
        aarch64-darwin = import ./darwin/aarch64-darwin.nix context;
        x86_64-darwin = import ./darwin/x86_64-darwin.nix context;
      };
      nixosConfigurations = { };

      # these two are unnecessary, find a way to fix (remove) them by directly importing them in their respective modules
      home.modules = {
        configurations = import ./home/modules/configurations.nix context;
        packages = import ./home/modules/packages.nix context;
        activation = import ./home/modules/activation.nix context;
      };
      darwin.modules = {
        configurations = import ./darwin/modules/configurations.nix context;
        overlays = import ./darwin/modules/overlays.nix context;
      };
    };
}
