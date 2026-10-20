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

  nordwand-mono = stdenv.mkDerivation {
    name = "nordwand-mono";
    version = "1.3.1";
    src = ./fonts/NordwandMono.zip;

    buildInputs = [ coreutils unzip ];
    nativeBuildInputs = [ coreutils unzip ];

    installPhase = ''
      unzip $src
      mkdir -p $out/share/fonts/truetype/nordwand-mono
      cp -r NordwandMono/*.ttf $out/share/fonts/truetype/nordwand-mono
      mkdir -p $out/share/doc/nordwand-mono
      cp NordwandMono/OFL.txt $out/share/doc/nordwand-mono
    '';
  };
}
