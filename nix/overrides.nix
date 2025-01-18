final: prev:

let
  inherit (final) lib awesomeNeovimPlugins;

  dependencies =
    self: super:
    lib.mapAttrs
      (
        attrName: dependencies:
        super.${attrName}.overrideAttrs (_: {
          inherit dependencies;
        })
      )
      (
        with awesomeNeovimPlugins;
        {
          nvim-srcerite = [ nvim-highlite ];
          telescope-bibtex-nvim = [ telescope-nvim ];
        }
      );

  andMore = self: super: { };
in
{
  vimPluginsPersonalSelection = prev.vimPluginsPersonalSelection.extend (
    lib.composeManyExtensions [
      dependencies
      andMore
    ]
  );
}
