{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  commonArgs = {
    src = craneLib.cleanCargoSource ../.;
    strictDeps = true;

    buildInputs = [];
  };
in
  craneLib.buildPackage (
    commonArgs
    // {
      cargoArtifacts = craneLib.buildDepsOnly commonArgs;
    }
  )
