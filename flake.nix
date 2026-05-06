{
  description = "Lisp Comp Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Ocaml
          ocaml

          # Dev Tools
          dune
          utop
          ocamlformat
          ocaml-lsp-server
          ocp-indent
        ];
        shellHook = ''
          echo "Dev Ready!"
        '';
      };
    };
}
