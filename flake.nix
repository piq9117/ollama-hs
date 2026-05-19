{
  description = "haskell-hs";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      });
    in
    {
      overlay = final: prev: {
        hsPkgs = prev.haskell.packages.ghc9102.override {
          overrides = hfinal: hprev: {
            openapi3-code-generator = hprev.openapi3-code-generator.overrideAttrs (old: {
              src = (builtins.fetchGit {
                url = "https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.git";
                rev = "26005f4aee16255e1d848afa383ecb98c4061bf3";
                ref = "master";
              }) + "/openapi3-code-generator";
            });
          };
        };
        ollama-hs = final.hsPkgs.callCabal2nix "ollama-hs" ./. { };
      };

      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          generate-api = pkgs.writeScriptBin "generate-api" ''
            GITROOT=$(git rev-parse --show-toplevel)
            
            rm -rf "$GITROOT/generated"
            rm -rf ollama-hs.cabal
            rm -rf "$GITROOT/src"
            rm -rf stack.yaml

            ${pkgs.hsPkgs.openapi3-code-generator}/bin/openapi3-code-generator-exe \
            --output-dir "$GITROOT/generated" \
            --module-name Ollama.Api \
            --package-name ollama-hs \
            "ollama-openapi.yaml"

            rsync -av generated/ .
            rm -rf "$GITROOT/generated"
          '';
        });
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {

          default = pkgs.hsPkgs.shellFor {
            packages = hsPkgs: [ ];
            buildInputs = with pkgs; [
              hsPkgs.cabal-install
              hsPkgs.cabal-fmt
              ormolu
              treefmt
              nixpkgs-fmt
              hsPkgs.openapi3-code-generator
              self.packages.${system}.generate-api
              zlib.dev
              ollama
              process-compose
            ];
            shellHook = ''
              export PS1='[$PWD]\n❄ '
            '';
          };
        });

      apps = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          generate-api = {
            type = "app";
            program = self.packages.${system}.generate-api;
          };
        });
    };
}
