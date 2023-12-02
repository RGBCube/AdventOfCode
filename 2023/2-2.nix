{ lib, ... } @ args:

with builtins; with lib; rec {
  games = (import ./2-1.nix args).games;

  getMaxRGB = { maxRGB ? { red = 0; green = 0; blue = 0; }, rgbs }: if length rgbs == 0 then
    maxRGB
  else getMaxRGB {
    maxRGB = mapAttrs (name: max (head rgbs).${name} or 0) maxRGB;
    rgbs = sublist 1 (length rgbs - 1) rgbs;
  };

  makeOneIfZero = number: if number == 0 then 1 else number;

  getPower = rgb: foldl' (accum: next: accum * makeOneIfZero next) 1 (attrValues rgb);

  gamesMaxRGBs = map (game: getMaxRGB { rgbs = game.snd; }) games;

  gamesPowers = map getPower gamesMaxRGBs;

  result = foldl' add 0 gamesPowers;
}
