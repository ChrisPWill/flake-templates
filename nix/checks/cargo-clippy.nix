{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  commonArgs = import ../cargoCommonArgs.nix {inherit pkgs inputs;};
in
  craneLib.cargoClippy (
    commonArgs
    // {
      cargoArtifacts = craneLib.buildDepsOnly commonArgs;
    }
  )
