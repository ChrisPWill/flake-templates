{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  commonArgs = import ../cargoCommonArgs.nix {inherit pkgs inputs;};
in
  craneLib.cargoNextest (
    commonArgs
    // {
      cargoArtifacts = craneLib.buildDepsOnly commonArgs;
      cargoNextestPartitionsExtraArgs = "--no-tests=pass";
    }
  )
