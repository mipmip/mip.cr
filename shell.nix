with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "crystal";

#THIS IS ESSENTIAL TO MAKE CRYSTAL WORK
nativeBuildInputs = [
  pkg-config
  cmake
  fswatch
];
buildInputs = [
  fswatch
  openssl
  crystal
  nodejs
  yarn
  shards
  webkitgtk
  cmake
];
}




