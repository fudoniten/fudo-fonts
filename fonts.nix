{ config, lib, pkgs, stdenv, coreutils, ... }:

{
  oxanium = stdenv.mkDerivation {
    name = "oxanium";
    version = "1.0";
    src = ./fonts/Oxanium.zip;

    installPhase = ''
      ${coreutils}/bin/mkdir -p $out/share/fonts/truetype/oxanium
      ${coreutils}/bin/cp -r Oxanium-VariableFont_wght.ttf $out/share/fonts/truetype/oxanium
      ${coreutils}/bin/cp -r static/*.ttf $out/share/fonts/truetype/oxanium
    '';
  };
}
