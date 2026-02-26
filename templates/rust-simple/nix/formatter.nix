{
  flake,
  pname,
  pkgs,
}: let
  formatter = pkgs.writeShellApplication {
    name = pname;

    runtimeInputs = with pkgs; [];

    text = ''
      set -euo pipefail

      # If no arguments are passed, default to formatting the whole project
      if [[ $# = 0 ]]; then
        prj_root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
        set -- "$prj_root"
      fi

      set -x

      nix develop --command treefmt "$@"
    '';

    meta = {
      description = "format your project";
    };
  };
  check =
    pkgs.runCommand "format-check" {
      nativeBuildInputs = [formatter pkgs.git];
    }
    ''
      export HOME=$NIX_BUILD_TOP/home

      # keep timestamps so that treefmt is able to detect mtime changes
      cp --no-preserve=mode --preserve=timestamps -r ${flake} source
      cd source
      git init --quiet
      git add .
      shopt -s globstar
      ${pname} **/*.nix
      if ! git diff --exit-code; then
        echo "-------------------------------"
        echo "aborting due to above changes ^"
        exit 1
      fi
      touch $out
    '';
in
  formatter
  // {
    passthru =
      formatter.passthru
      // {
        tests = {
          check = check;
        };
      };
  }
