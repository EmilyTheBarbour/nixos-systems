# The intent here these are directly exported as an output of 
# this flake, which can be either conditionally consumed, or 
# wholely consumed using builtins.attrValues 
{
  vscode = import ./vscode.nix;
  firefox = import ./firefox.nix;
  git = import ./git.nix;
  common = import ./common.nix;
  terminator = import ./terminator.nix;
  video-editing = import ./video-editing.nix;
  zsh = import ./zsh.nix;
}
