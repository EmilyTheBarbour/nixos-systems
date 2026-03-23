{inputs, ...}: {
  config = {
    stylix = {
      enable = true;
      base16Scheme = "${inputs.tinted-schemes}/base16/catppuccin-macchiato.yaml";
    };
  };
}
