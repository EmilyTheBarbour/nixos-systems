{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    treefmt.programs = let
      linters = [
        "taplo"
        "alejandra"
        "ruff-format"
        "prettier"
        "shfmt"
      ];

      enable_struct = builtins.foldl' (a: b: lib.attrsets.recursiveUpdate a b) {} (builtins.map (x: {"${x}".enable = true;}) linters);
    in
      enable_struct;
  };
}
