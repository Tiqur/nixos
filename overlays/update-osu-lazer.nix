final: prev: {
  osu-lazer-bin = prev.osu-lazer-bin.overrideAttrs (oldAttrs: rec {
    version = "2025.729.0-tachyon";

    src = prev.fetchurl {
      url = "https://github.com/ppy/osu/releases/download/${version}/osu.AppImage";
      sha256 = "sha256:615d4eb83edd6fd64c5f0c3df03cc825e8e5d5e6476e91b0930d4785b29e5494";
    };
  });
}
