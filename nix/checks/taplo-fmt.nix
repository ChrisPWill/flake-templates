{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  src = (import ../cargoCommonArgs.nix {inherit pkgs inputs;}).src;
in
  craneLib.taploFmt {
    src = pkgs.lib.sources.sourceFilesBySuffices src [".toml"];
    # taplo arguments can be further customized below as needed
    # taploExtraArgs = "--config ./taplo.toml"
  }
