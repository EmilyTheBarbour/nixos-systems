{python3Packages}:
with python3Packages;
  buildPythonPackage {
    name = "generate_clangd";
    src = ./generate_clangd;
    pyproject = true;
    nativeBuildInputs = [poetry-core];
    propogatedBuildInputs = [];
  }
