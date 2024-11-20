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
    rev = "15572a1c22fb4731a80017a0e1cb042fcaf8b86b";
    sha256 = "sha256-gfYMlZ2ENlmZLPEqptnyNGwhOdpHGUcLWA6xufe8TrQ=";
  };

  cargoHash = "sha256-0cbfEa2Tyw0plEKIn24quXmMgc/gkYypXm5DIKe0vu0=";

  preBuild = ''
    substituteInPlace src/main.rs --replace "/usr/share/eventsfx/audio" "$out/share/eventsfx/audio"
    sed -n 80p src/main.rs
  '';

  postInstall = ''
    mkdir -p $out/share/eventsfx/audio
    install -Dvm 644 $src/audio/* -t $out/share/eventsfx/audio/

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
