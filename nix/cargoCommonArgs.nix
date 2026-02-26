{
  pkgs,
  inputs,
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
in {
  src = craneLib.cleanCargoSource ../.;
  strictDeps = true;

  buildInputs = [];
}
