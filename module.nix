{ config, lib, pkgs, ... }:

with lib;
let cfg = config.fudo.fonts;
in {
  options.fudo.fonts = with types; {
    enable = mkEnableOption "Enable Fudo font collection.";
  };

  config = mkIf cfg.enable { fonts.packages = with pkgs; [ oxanium ]; };
}
