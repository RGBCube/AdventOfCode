{
  description = "RGBCube's Advent of Code solutions.";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { nixpkgs, ... }: let
    lib = nixpkgs.lib;

    solutions = [
      "2023/1-1"
      "2023/1-2"
      "2023/2-1"
      "2023/2-2"
    ];
  in with builtins; with lib; genAttrs solutions (path: (import ./${path}.nix {
    inherit lib;

    input = let
      inputPath = head (splitString "-" path);
      inputStringLines = splitString "\n" (readFile ./${inputPath}.in);
      inputStringNoEmpty = concatStringsSep "\n" (filter (line: line != "") inputStringLines);
    in inputStringNoEmpty;
  }).result);
}
