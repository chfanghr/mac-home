{
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "zkapp-cli";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "o1-labs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-jBGZAbudC/e8j5GflIMPPAucnW/Cbabe9BdQfIV2Ry8=";
  };

  dontNpmBuild = true;

  npmDepsHash = "sha256-ah75Qp1pxKF2RrcsaGUbH0y7irLlNcbTyyVxSQ/zsdk=";
}
