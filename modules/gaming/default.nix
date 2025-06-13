{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.gaming;
in
{
  options.jofaul.gaming = {
    enable = lib.mkEnableOption "activate gaming programs and options";
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
        ];
        extraLibraries = pkgs: [
          # List library dependencies here
        ];
      })
    ];
  };
}
