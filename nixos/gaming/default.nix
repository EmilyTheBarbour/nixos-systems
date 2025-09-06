{ parameters
, ...
}:
{
  imports = (if parameters.gaming.enable == true then [
    ./steam
  ] else [ ]);
}
