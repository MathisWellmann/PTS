{
  description = "Flake for PTS, a parallel tree search symbolic regression project";

  inputs = {
    nixpks.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        python_pkgs = ps: with ps; [
          torchWithCuda
          click
          pandas
          scipy
          scikit-learn
        ];
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              (python3.withPackages python_pkgs)
            ];
          };
        }
    );
}
