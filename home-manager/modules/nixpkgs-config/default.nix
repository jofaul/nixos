{
  config,
  lib,
  ...
}:
{
  options = {
    jofaul.nixpkgs-config.enable = lib.mkEnableOption "nixpkgs config";
  };

  config = lib.mkIf config.jofaul.nixpkgs-config.enable {
    nixpkgs.config = import ./nixpkgs-config.nix;
    xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
  };
}
