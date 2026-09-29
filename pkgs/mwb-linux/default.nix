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
    rev = "PASTE_COMMIT_SHA"; # git ls-remote https://github.com/lucky-verma/mwb-linux refs/pull/41/head
    hash = lib.fakeHash;
  };

  vendorHash = lib.fakeHash;

  subPackages = [ "cmd/mwb" ];

  # portal (libei) code is excluded without this tag
  tags = [ "wayland_portal" ];
  env.CGO_ENABLED = "1";

  nativeBuildInputs = [
    makeWrapper
    pkg-config
  ];

  buildInputs = [ libei ];

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
