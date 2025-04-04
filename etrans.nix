{ lib, trivialBuild, request }:
let
  name = "etrans";
  version = "1.0.0";
in
trivialBuild rec {
  pname = "${name}";
  inherit version;
  src = ./.;

  # elisp dependencies
  propagatedUserEnvPkgs = [ request ];
  buildInputs = propagatedUserEnvPkgs;

  meta = with lib; {
    description = "translate text inside emacs";
    homepage = "https://github.com/dpom/etrans";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
