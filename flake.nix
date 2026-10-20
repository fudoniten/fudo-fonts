{
  description = "Fonts to add to Fudo systems.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";

    utils.url = "github:numtide/flake-utils";

    oxanium = {
      url = "github:sevmeyer/oxanium/2.000";
      flake = false;
    };

    nordwand-mono = {
      url = "github:tywr/Nordwand-Mono/1.3.1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, oxanium, nordwand-mono, ... }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages."${system}";
      in {
        packages = pkgs.callPackage ./fonts.nix {
          oxanium-src = oxanium;
          nordwand-mono-src = nordwand-mono;
        };
      }) // {
        overlays = rec {
          default = fudoFonts;
          fudoFonts = final: prev:
            let fonts = self.packages."${prev.system}";
            in { inherit (fonts) oxanium nordwand-mono; };
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
