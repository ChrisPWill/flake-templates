{
  flake,
  pkgs,
  inputs,
  system,
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
      taplo
      # miniserve
    ];

    shellHook = ''
      echo "Welcome to ${flake.packages.${system}.default.pname}!\n"

      echo Use "just <recipe>" to run a common flow
      just --list
    '';
  }
