{pkgs, ...}: {
  #TODO(emily): home file config?
  home.packages = with pkgs; [
    obsidian
  ];
}
