{ pkgs ? import <nixpkgs> { } }:
pkgs.rustPlatform.buildRustPackage {
  pname = "grc-rs";
  version = "0.3.2";
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
  postInstall = ''
    mkdir -p $out/etc
    ln -s ${./config} $out/etc/grc-rs
  '';
}
