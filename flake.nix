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

      input = let
        inputPath = lib.head (lib.splitString "-" path);
      in builtins.concatStringsSep "\n"
        (builtins.filter (line: line != "")
          (lib.splitString "\n" (builtins.readFile ./${inputPath}.in)));
    }).result;
  in lib.genAttrs [
    "2023/1-1"
    "2023/1-2"
    "2023/2-1"
    "2023/2-2"
  ] pathToResult;
}
