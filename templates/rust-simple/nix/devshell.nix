{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
  devshell = pkgs.devshell.mkShell {
    imports = [(pkgs.devshell.importTOML ./devshell.toml)];
  };
  moldDevshellDevShell = craneLib.devShell.override {
    # For example, use the mold linker
    mkShell = pkgs.mkShell.override {
      stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.stdenv;
    };
  };
in
  moldDevshellDevShell {
    inputsFrom = [devshell];
    packages = [] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [pkgs.gcc];
  }
