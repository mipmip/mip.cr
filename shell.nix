with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "crystal";

#THIS IS ESSENTIAL TO MAKE CRYSTAL WORK
nativeBuildInputs = [ pkg-config ];
buildInputs = [
  openssl
  crystal
  shards
  webkitgtk
];
}




