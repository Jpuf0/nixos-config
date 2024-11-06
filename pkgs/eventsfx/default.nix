{
  rustPlatform,
  fetchFromGitHub,
  alsa-lib,
  systemd,
  libinput,
  bash,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "effectsfx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "SaphiraKai";
    repo = "eventsfx";
    rev = "d3984e046b40f05299e5188dea994dd5aa28e87b";
  };

  postInstall = ''
    install -Dm 644 $src/audio/* -t $out/share/eventsfx/audio/
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
