{
  config,
  lib,
  ...
}:
{
  options = {
    jonathan.nixpkgs-config.enable = lib.mkEnableOption "nixpkgs config";
  };

  config = lib.mkIf config.jonathan.nixpkgs-config.enable {
    nixpkgs.config = import ./nixpkgs-config.nix;
    xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
  };
}
