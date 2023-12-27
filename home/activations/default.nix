{ lib, pkgs, config, ... }:
{
  /** TODO(kyle): this is handy for moving stuff in codespaces, keeping as a reference
  home.activation = {
    correctSshPermissions = lib.hm.dag.entryAfter ["linkGeneration"] ''
      cp ~/.ssh/kyle ~/.ssh/default && \
      cp ~/.ssh/kyle.pub ~/.ssh/default.pub && \
      chmod 644 ~/.ssh/default.pub && \
      chmod 600 ~/.ssh/default
    '';
  };
  **/
}