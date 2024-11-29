{
  description = "A plain devcontainer flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.niksi-devcontainer.url = "github:niksi-aalto/niksi-devcontainer";

  outputs = {
    nixpkgs,
    flake-utils,
    niksi-devcontainer,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        overrides = pkgs.lib.optional (builtins.pathExists ./overrides.nix) (import ./overrides.nix {inherit pkgs;});
      in {
        packages.default = niksi-devcontainer.lib.mkDevcontainer ({
            inherit pkgs;
            name = "plain";
          }
          // (pkgs.lib.mergeAttrsList overrides));
      }
    );
}
