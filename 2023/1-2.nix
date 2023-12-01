{ lib, input }:

with builtins; with lib; rec {
  digits = {
    zero  = "0";
    one   = "1";
    two   = "2";
    three = "3";
    four  = "4";
    five  = "5";
    six   = "6";
    seven = "7";
    eight = "8";
    nine  = "9";
  };

  toDigit = maybeDigit: if digits ? "${maybeDigit}" then
    digits.${maybeDigit}
  else
    maybeDigit;

  allNeedles = flatten (mapAttrsToList (key: value: [ key (toString value) ]) digits); 
  allNeedlesReverse = map reverseString allNeedles;

  reverseString = string: concatStrings (reverseList (stringToCharacters string));

  firstMatch = haystack: needles: let
      prefixNeedle = findFirst (needle: hasPrefix needle haystack) null needles;
    in if prefixNeedle != null then
      prefixNeedle
    else
      firstMatch (substring 1 (stringLength haystack - 1) haystack) needles;

  firstLast = line: let
    first = firstMatch line allNeedles;
    last = reverseString (firstMatch (reverseString line) allNeedlesReverse);
  in fromJSON (toDigit first + toDigit last);

  lines = splitString "\n" input;

  result = foldl' add 0 (map firstLast lines);
}
