{ parameters
, ...
}:
{
  imports = (if parameters.gaming.enable == true then [
    ./lutris.nix
  ] else [ ]);
}
