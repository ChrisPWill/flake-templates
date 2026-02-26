{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  moldDevShell = craneLib.devShell.override {
    # For example, use the mold linker
    mkShell = pkgs.mkShell.override {
      stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.stdenv;
    };
  };
in
  moldDevShell {
    packages = with pkgs; [
      bacon
      just
      # miniserve
    ];

    # NEXTEST_PROFILE = "local";
  }
