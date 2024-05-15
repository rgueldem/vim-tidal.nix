{fetchFromGitHub, haskellPackages, vimUtils, ...}:
let
  ghc = haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    tidal
  ]);
in vimUtils.buildVimPlugin {
  name = "vim-tidal";
  src = fetchFromGitHub {
    owner = "tidalcycles";
    repo = "vim-tidal";
    rev = "e440fe5bdfe07f805e21e6872099685d38e8b761";
    hash = "sha256-8gyk17YLeKpLpz3LRtxiwbpsIbZka9bb63nK5/9IUoA=";
  };
  postInstall = ''
    substituteInPlace $out/plugin/tidal.vim \
      --replace "let g:tidal_ghci = \"ghci\"" "let g:tidal_ghci = \"${ghc}/bin/ghci\""
  '';
}
