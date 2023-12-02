{ lib, input }:

with builtins; with lib; rec {
  lines = splitString "\n" input;

  lineToId = line: fromJSON (removePrefix "Game " (head (splitString ": " line)));

  lineToRawRGBListList = line:
    map (splitString ", ")
      (splitString "; "
        (last (splitString ": " line)));

  # [ "1 blue" "2 red" ] => { blue = 1; red = 2; }
  parseRawRGBList = rawList:
    listToAttrs (map (entry: let
      parts = splitString " " entry;
    in {
      name = last parts;
      value = fromJSON (head parts);
    }) rawList);

  # [ { fst = 1; snd = [ { blue = 1; red = 2; green = 123; } ]; } ]
  games = zipLists (map lineToId lines) (map (map parseRawRGBList) (map lineToRawRGBListList lines));

  rgbPossible = rgb:
    (rgb.red or 0) <= 12 &&
    (rgb.green or 0) <= 13 &&
    (rgb.blue or 0) <= 14;

  possibleGamesLists = filter (game: all rgbPossible game.snd) games;

  result = foldl' add 0 (map (game: game.fst) possibleGamesLists);
}
