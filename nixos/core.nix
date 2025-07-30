{lib, ...}: {
  # We share the definition of a user between both NixOS space and home-manager space
  # So in order to make our home-manager modules trivially runnable on a non NixOS machine
  # we have to define orthogonal config definition points to maintain consistency
  #
  # We'll force these options to be synced to our NixOS config when we realize it through
  # this closure
  main-user = (import ../types/user.nix) lib;
}