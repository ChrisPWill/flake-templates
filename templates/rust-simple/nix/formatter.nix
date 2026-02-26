{
  pname,
  pkgs,
}:
pkgs.writeShellApplication {
  name = pname;

  runtimeInputs = with pkgs; [
    deadnix
    alejandra
  ];

  text = ''
    set -euo pipefail

    # If no arguments are passed, default to formatting the whole project
    if [[ $# = 0 ]]; then
      prj_root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
      set -- "$prj_root"
    fi

    set -x

    deadnix --no-lambda-pattern-names --edit "$@"

    alejandra "$@"
  '';

  meta = {
    description = "format your project";
  };
}
