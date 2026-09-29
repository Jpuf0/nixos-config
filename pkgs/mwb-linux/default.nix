# pkgs/mwb-linux/default.nix
{
  buildGoModule,
  fetchFromGitHub,
  lib,
  libei,
  makeWrapper,
  pkg-config,
  wl-clipboard,
  xclip,
  xdotool,
  xsel,
}:
buildGoModule {
  pname = "mwb-linux";
  version = "0.6.3-unstable-pr41";

  src = fetchFromGitHub {
    owner = "lucky-verma";
    repo = "mwb-linux";
    rev = "15036dc52c51b8b08f64b1506cc2cf61e1b4f489"; # git ls-remote https://github.com/lucky-verma/mwb-linux refs/pull/41/head
    hash = "sha256-S2WhrcH7v533Jp8GBBedrHJFxFqA7DbNzkIEsyTY/7Q=";
  };

  vendorHash = "sha256-3uQxvR8jIYGxZWK+g/Q7SbSEWGbeNwIj9eXoUQBueyw=";

  subPackages = ["cmd/mwb"];

  # portal (libei) code is excluded without this tag
  tags = ["wayland_portal"];
  env.CGO_ENABLED = "1";

  nativeBuildInputs = [
    makeWrapper
    pkg-config
  ];

  buildInputs = [libei];

  postInstall = ''
    wrapProgram $out/bin/mwb \
      --prefix PATH : ${
      lib.makeBinPath [
        wl-clipboard
        xclip
        xdotool
        xsel
      ]
    }

    install -Dm644 ${./99-mwb.rules} $out/lib/udev/rules.d/99-mwb.rules
  '';

  __structuredAttrs = true;

  meta = {
    description = "Mouse Without Borders client for Linux (keyboard, mouse and clipboard sharing with Windows)";
    homepage = "https://github.com/lucky-verma/mwb-linux";
    license = lib.licenses.mit;
    mainProgram = "mwb";
    platforms = lib.platforms.linux;
  };
}
