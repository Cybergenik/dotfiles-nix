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
    };
}
