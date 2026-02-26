{
  pkgs,
  inputs,
  ...
}: let
  crane = inputs.crane;
  craneLib = crane.mkLib pkgs;
in
  craneLib.devShell {
    packages = with pkgs; [
      bacon
      just
      # miniserve
    ];

    # NEXTEST_PROFILE = "local";
  }
