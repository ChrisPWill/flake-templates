{perSystem, ...}:
perSystem.devshell.mkShell {
  imports = [
    (perSystem.devshell.importTOML ./devshell.toml)
  ];

  env = [
    {
      name = "PATH";
      prefix = "bin";
    }
  ];
}
