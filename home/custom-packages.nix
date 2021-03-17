with import <nixpkgs> {}; # bring all of Nixpkgs into scope

stdenv.mkDerivation rec {
  name = "cbonsai";

  src = fetchFromGitLab {
    owner  = "jallbrit";
    repo   = "cbonsai";
    rev    = "f10e9888";
    sha256 = "0scd719jfmddgnpbmnwbx8d15dj9mk9ndlqkrd1hv6frvb0zi0yg";
  };

  buildInputs = [ ncurses ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp cbonsai $out/bin/cbonsai
    chmod +x $out/bin/cbonsai
  '';
}
