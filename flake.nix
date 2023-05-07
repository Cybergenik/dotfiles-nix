{
  description = "Cybergenik";

  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";

    nix-darwin = {
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
      flakeContext = {
        inherit inputs;
      };
    in
    {
      darwin = {
        aarch64-darwin = import ./darwin/aarch64-darwin.nix flakeContext;
        x86_64-darwin = import ./darwin/x86_64-darwin.nix flakeContext;
        modules = {
            default = import ./darwin/modules/default.nix flakeContext;
            overlay = import ./darwin/modules/overlay.nix flakeContext;
        };
      };
      home = {
        luciano = import ./home/luciano.nix flakeContext; 
        modules = {
            default = import ./home/modules/default.nix flakeContext;
            #activation = import ./home/modules/activation.nix flakeContext;
            package-darwin = import ./home/modules/package-darwin.nix flakeContext;
            package-linux = import ./home/modules/package-linux.nix flakeContext;
            package-minimum = import ./home/modules/package-minimum.nix flakeContext;
        };
      };
      darwinConfigurations = {
        aarch64-darwin = import ./darwin/aarch64-darwin.nix flakeContext;
        x86_64-darwin = import ./darwin/x86_64-darwin.nix flakeContext;
      };
      nixosConfiguration = {};
    };
}
