{ flake, pkgs, lib, ... }:

let
  user = flake.config.people.users.${flake.config.people.myself};
  user_name = user.name;
  user_email = user.email;
in

{
  programs.git = {
    enable = true;
    userEmail = "${user_email}";
    userName = "${user_name}";
  };
}
