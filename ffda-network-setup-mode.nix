let
  pkgs = import <nixpkgs> {};
in

with pkgs;

stdenv.mkDerivation {
  pname = "ffda-network-setup-mode";
  version = "0.1";

  src = fetchgit {
    url = "https://github.com/freifunk-gluon/community-packages.git";
    rev = "ca08c5446221cee0fc3d65b7dff2f12101a3ca59";
    sha256 = "sha256-c2gXp1JFBU2NgGlfuyVj9PkK8Y/+5Iq6BahxxS//V2o=";
    sparseCheckout = [
      "ffda-network-setup-mode/src"
    ];
    deepClone = false;
  };

  buildPhase = ''
    gcc ffda-network-setup-mode/src/send-network-request.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp a.out $out/bin/send-network-request
  '';

  meta = with lib; {
    description = "send network setup mode packages over specified interface";
  };
}
