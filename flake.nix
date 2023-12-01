{
  description = "RGBCube's Advent of Code Solutions.";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { nixpkgs, ... }: let
    lib = nixpkgs.lib;

    pathToResult = path: (import ./${path}.nix {
      inherit lib;

      input = builtins.concatStringsSep "\n"
        (builtins.filter (line: line != "")
          (lib.splitString "\n" (builtins.readFile ./${path}.in)));
    }).result;
  in lib.genAttrs [
    "2023/1-1"
    "2023/1-2"
  ] pathToResult;
}
