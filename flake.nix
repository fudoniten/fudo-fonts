{
  description = "Fonts to add to Fudo systems.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages."${system}";
      in { packages = pkgs.callPackage ./fonts.nix { }; }) // {
        overlays = rec {
          default = fudoFonts;
          fudoFonts = final: prev:
            let fonts = self.packages."${prev.system}";
            in { inherit (fonts) oxanium; };
        };

        nixosModules = rec {
          default = fudoFonts;
          fudoFonts = {
            imports = [ ./module.nix ];

            config.nixpkgs.overlays = [ self.overlays.default ];
          };
        };
      };
}
