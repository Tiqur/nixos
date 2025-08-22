final: prev: {
  osu-lazer-bin = prev.osu-lazer-bin.overrideAttrs (oldAttrs: rec {
    version = "2025.816.0-lazer";

    src = prev.fetchurl {
      url = "https://github.com/ppy/osu/releases/download/${version}/osu.AppImage";
      sha256 = "sha256-mOihQ8mtHEiq0FElkJiZl0mhBqPi8CoGowN358Jc72A=";
    };
  });
}
