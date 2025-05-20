{ config, lib, pkgs, stdenv, coreutils, unzip, ... }:

{
  oxanium = stdenv.mkDerivation {
    name = "oxanium";
    version = "1.0";
    src = ./fonts/Oxanium.zip;

    buildInputs = [ coreutils unzip ];
    nativeBuildInputs = [ coreutils unzip ];

    installPhase = ''
      unzip $src
      mkdir -p $out/share/fonts/truetype/oxanium
      cp -r Oxanium-VariableFont_wght.ttf $out/share/fonts/truetype/oxanium
      cp -r static/*.ttf $out/share/fonts/truetype/oxanium
    '';
  };
}
