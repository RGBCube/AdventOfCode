{ lib, input }:

with lib; with builtins; let
  lines = splitString "\n" input;

  linesChars = map (splitString "") lines;

  linesOnlyNumbers = map (filter (char: (match "[0-9]" char) != null)) linesChars;

  firstAndLastConcatted = list: (head list) + (last list);

  linesNumbers = map firstAndLastConcatted linesOnlyNumbers;

  sumOfLinesNumbers = foldl' add 0 (map fromJSON linesNumbers);

  result = sumOfLinesNumbers;
in result
