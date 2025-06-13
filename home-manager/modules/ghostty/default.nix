{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.programs.ghostty;
in
{
  options.jofaul.programs.ghostty = {
    enable = lib.mkEnableOption "enable ghostty";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ ghostty ];
    xdg.configFile."ghostty/config".source = ./config;
  };
}
