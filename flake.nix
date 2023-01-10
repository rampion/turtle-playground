{
  description = "A haskell environment with turtle available";
  inputs.nixpkgs.url = "nixpkgs";
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      });
    in
    {
      overlay = (final: prev: {
        turtle-playground = final.haskellPackages.callCabal2nix "turtle-playground" ./. {};
      });
      packages = forAllSystems (system: {
         turtle-playground = nixpkgsFor.${system}.turtle-playground;
      });
      defaultPackage = forAllSystems (system: self.packages.${system}.turtle-playground);
      checks = self.packages;
      devShell = forAllSystems (system: let haskellPackages = nixpkgsFor.${system}.haskellPackages;
        in haskellPackages.shellFor {
          packages = p: [self.packages.${system}.turtle-playground];
          withHoogle = true;
          buildInputs = with haskellPackages; [
            haskell-language-server
            ghcid
            cabal-install
          ];
          # Change the prompt to show that you are in a devShell
          shellHook = "export PS1='\\e[1;34mdev > \\e[0m'";

          name="turtle-playground";
        });
  };
}
