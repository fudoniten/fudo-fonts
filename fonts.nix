{ stdenv, stdenvNoCC, python3, oxanium-src, nordwand-mono-src, ... }:

{
  oxanium = stdenvNoCC.mkDerivation {
    pname = "oxanium";
    version = "2.000";
    src = oxanium-src;

    installPhase = ''
      mkdir -p $out/share/fonts/truetype/oxanium
      cp fonts/variable/*.ttf fonts/ttf/*.ttf $out/share/fonts/truetype/oxanium
      mkdir -p $out/share/doc/oxanium
      cp OFL.txt $out/share/doc/oxanium
    '';
  };

  nordwand-mono = stdenv.mkDerivation {
    pname = "nordwand-mono";
    version = "1.3.1";
    src = nordwand-mono-src;

    nativeBuildInputs = [
      (python3.withPackages (ps:
        with ps; [
          booleanoperations
          fonttools
          numpy
          skia-pathops
          ttfautohint-py
          ufolib2
        ]))
    ];

    # Upstream ships no prebuilt fonts, so generate them from source.
    buildPhase = ''
      cd src
      python generate_font.py --ttf
    '';

    installPhase = ''
      mkdir -p $out/share/fonts/truetype/nordwand-mono
      cp fonts/ttf/NordwandMono-*.ttf $out/share/fonts/truetype/nordwand-mono
      mkdir -p $out/share/doc/nordwand-mono
      cp ../LICENSE-FONT.txt $out/share/doc/nordwand-mono/OFL.txt
    '';
  };
}
