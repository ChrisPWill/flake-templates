{
  description = "Rust Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    crane.url = "github:ipetkov/crane";
  };

  outputs = inputs:
    inputs.blueprint {
      inherit inputs;

      prefix = "nix/";
      nixpkgs.overlays = [
        inputs.crane.overlays.default
        inputs.devshell.overlays.default
      ];
    };
}
