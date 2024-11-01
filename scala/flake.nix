{
  description = "A Scala devcontainer flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  inputs.niksi-devcontainer.url = "git+ssh://git@version.aalto.fi/niksi/niksi-devcontainer";

  outputs = {
    self,
    nixpkgs,
    niksi-devcontainer,
  }: let
    supportedSystems = ["x86_64-linux" "x86_64-darwin"];

    forallSystems = nixpkgs.lib.genAttrs supportedSystems;

    nixpkgsFor = forallSystems (system: import nixpkgs {inherit system;});
  in {
    packages = forallSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = niksi-devcontainer.lib.mkDevcontainer {
        inherit pkgs;
        name = "niksi-scala";
        paths = with pkgs; [
          bash
          coreutils-full
          scala_3
          git
          sbt
          metals
          bloop
          coursier
          jdk

          xorg.libX11
          xorg.libXext
          xorg.libXtst
        ];
      };
    });
  };
}
