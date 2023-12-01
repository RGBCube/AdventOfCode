#!/usr/bin/env nu

# Run a specified AoC challenge.
def main [
  year_day_part_ext: string # The file to run. For example `2023/1-2.py` or `2023/1-2.nix`.
] {
  match ($year_day_part_ext | path parse | get extension) {
    "nix" => {
      nix eval (".#" + ($year_day_part_ext | str replace ".nix" ""))
    }
    "py" => {
      cd ($year_day_part_ext | path dirname)
      python ($year_day_part_ext | path basename)
      cd -
    }
  }
}
