{
  description = "A very basic flake with devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        devShells.exploit = pkgs.mkShell {
          nativeBuildInputs = [pkgs.python311 pkgs.python311Packages.requests];
        };

        devShells.slides =
          pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.pandoc
              pkgs.texlive.combined.scheme-medium
            ];
          };

        devShells.default = devShells.slides;
      });
}
