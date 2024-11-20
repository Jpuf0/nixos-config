{
  rustPlatform,
  fetchFromGitHub,
  alsa-lib,
  systemd,
  libinput,
  bash,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "eventsfx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "SaphiraKai";
    repo = "eventsfx";
    rev = "d3984e046b40f05299e5188dea994dd5aa28e87b";
    sha256 = "sha256-gfYMlZ2ENlmZLPEqptnyNGwhOdpHGUcLWA6xufe8TrQ=";
  };

  cargoHash = "sha256-0cbfEa2Tyw0plEKIn24quXmMgc/gkYypXm5DIKe0vu0=";

  postInstall = ''
    mkdir -p $out/share/eventsfx/audio
    install -Dvm 644 $src/audio/* -t $out/share/eventsfx/audio/
    # Add a check to verify files were copied
    if [ ! -d "$out/share/eventsfx/audio" ] || [ -z "$(ls -A $out/share/eventsfx/audio)" ]; then
      echo "Failed to copy audio files or directory is empty"
      exit 1
    fi
  '';

  buildInputs = [
    alsa-lib
    systemd
    libinput
    bash
  ];

  nativeBuildInputs = [
    pkg-config
  ];
}
