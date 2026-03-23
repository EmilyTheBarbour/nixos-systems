{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # inputs.catppuccin.nixosModules.catppuccin
  ];

  config = {
    stylix = {
      enable = true;
      base16Scheme = "${inputs.tinted-schemes}/base16/catppuccin-macchiato.yaml";
    };

    # catppuccin = {
    #   enable = true;
    #   inherit flavor;
    # };

    # home-manager = {
    #   # Entry-point for the home-manager config modules. Here we enforce that we're only
    #   # applying config for our main user
    #   #
    #   # In the future, this should probably be abstracted for multi-user machines, but
    #   # i'm not really in the business of having those types of PCs
    #   users.${parameters.users.main-user.user-name} = {
    #     # the root of my home-manager config; this file tree can be used in isolation for a
    #     # mostly pure home-manager installation
    #     imports = [
    #       inputs.catppuccin.homeModules.catppuccin
    #     ];

    #     config = {
    #       catppuccin = {
    #         enable = true;
    #         inherit flavor;
    #       };
    #     };
    #   };
    # };
  };
}
