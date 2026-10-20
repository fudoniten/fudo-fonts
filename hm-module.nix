{ self }:
{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.fudo.fonts;
  fudoFonts = self.packages."${pkgs.stdenv.hostPlatform.system}";
in {
  options.fudo.fonts = with types; {
    enable = mkEnableOption "Enable Fudo font collection.";
  };

  # On macOS, Home Manager copies fonts from home.packages into
  # ~/Library/Fonts/HomeManager; on Linux, fontconfig picks them up.
  config = mkIf cfg.enable (mkMerge [
    { home.packages = with fudoFonts; [ oxanium nordwand-mono ]; }
    (mkIf pkgs.stdenv.hostPlatform.isLinux {
      fonts.fontconfig.enable = mkDefault true;
    })
  ]);
}
