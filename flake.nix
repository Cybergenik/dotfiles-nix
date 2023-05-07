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
      darwinConfigurations = {
        aarch64-darwin = import ./darwin/aarch64-darwin.nix flakeContext;
        x86_64-darwin = import ./darwin/x86_64-darwin.nix flakeContext;
      };

      nixosConfiguration = {};
    };
}
