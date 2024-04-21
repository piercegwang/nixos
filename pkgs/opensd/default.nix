{ stdenv
, lib
, fetchurl
, cmake
}:
stdenv.mkDerivation {
  name = "opensd";
  version = "0.52";

  src = fetchurl {
    url = "https://codeberg.org/OpenSD/opensd/archive/v0.52.tar.gz";
    hash = "sha256-TEvkF+y+KOmN0zuqetIa2e+cPeM51EFYlPa0Hc7g4i0=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [];

  cmakeFlags = [
    "-DUDEV_RULE_DIR=${placeholder "out"}/lib/udev/rules.d"
    "-DOPT_INSTALL_GROUP=OFF"
  ];

  meta = {
    description = "Userspace driver for Steam Deck input";
    license = lib.licenses.gpl3Plus;
  };
}
