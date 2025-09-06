{
  parameters,
  lib,
  ...
}: {
  imports =
    if parameters.gaming.enable == true
    then
      lib.trace "enabling gaming modules in nixOS" [
        ./steam
      ]
    else [];
}
