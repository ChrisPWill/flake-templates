{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  commonArgs = import ./cargoCommonArgs.nix {inherit pkgs inputs;};
in
  craneLib.buildPackage (
    commonArgs
    // {
      cargoArtifacts = craneLib.buildDepsOnly commonArgs;
      doCheck = false; # Using nextest
    }
  )
