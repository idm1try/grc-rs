{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };
  outputs = { self, nixpkgs }:
    let
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = nixpkgs.legacyPackages;
    in {
      packages = forAllSystems (system: {
        default = pkgsFor.${system}.callPackage ./default.nix { };
      });
      devShells = forAllSystems
        (system: { default = pkgsFor.${system}.callPackage ./shell.nix { }; });
    };
}
