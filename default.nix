{pkgs, ...}:
let
  ghc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    tidal
  ]);
in pkgs.vimUtils.buildVimPlugin {
  name = "vim-tidal";
  src = pkgs.fetchFromGitHub {
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
