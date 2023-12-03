#!/usr/bin/env nu

def complete [] {
  ls 2023 | get names | filter { not ($in str-endswith ".in") }
}

# Run a specified AoC solution.
def main [
  year_day_part_ext: string@complete # The file to run. For example `2023/1-2.py` or `2023/1-2.nix`.
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
