final: prev: {
  osu-lazer-bin = prev.osu-lazer-bin.overrideAttrs (oldAttrs: rec {
    version = "2025.808.0-tachyon";

    src = prev.fetchurl {
      url = "https://github.com/ppy/osu/releases/download/${version}/osu.AppImage";
      sha256 = "31a4beaed5f573067ca91852bccbc54436963a5b8357bca822542af71af1aa6f";
    };
  });
}
