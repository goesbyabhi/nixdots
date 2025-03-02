{ stdenv, fetchzip, autoPatchelfHook, glibc, gcc-unwrapped, makeWrapper, alsa-lib }: stdenv.mkDerivation rec {
  pname = "Zed Editor";
  version = "0.175.6";

  src = fetchzip {
    url = "https://github.com/zed-industries/zed/releases/download/v0.175.6/zed-linux-x86_64.tar.gz";
    hash = "sha256-J1ztgakpSx40EKu7mFQGMfZx7TSBxu+FAK1EctBIZpk=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [ glibc gcc-unwrapped alsa-lib ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/libexec
    mkdir -p $out/lib
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps
    mkdir -p $out/share/icons/hicolor/1024x1024/apps

    install -m755 bin/zed $out/bin/zed
    install -m755 libexec/zed-editor $out/libexec/zed-editor

    cp -r lib/* $out/lib/
    cp -r share/applications/zed.desktop $out/share/applications/
    cp -r share/icons/hicolor/512x512/apps/zed.png $out/share/icons/hicolor/512x512/apps/
    cp -r share/icons/hicolor/1024x1024/apps/zed.png $out/share/icons/hicolor/1024x1024/apps/

    wrapProgram $out/bin/zed \
      --set ZED_BUNDLE_PATH $out/libexec

    runHook postInstall
  '';
}
