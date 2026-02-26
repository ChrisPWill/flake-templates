{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  src = (import ../cargoCommonArgs.nix {inherit pkgs inputs;}).src;
in
  craneLib.cargoFmt {inherit src;}
