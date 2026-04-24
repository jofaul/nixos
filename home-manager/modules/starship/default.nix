{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.programs.starship;
in
{
  options.jofaul.programs.starship = {
    enable = lib.mkEnableOption "enable starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
          hostname = {
            format = "[$hostname]($style) ";
          };
          username = {
            format = "[$user]($style)@";
          };
          directory = {
            truncation_length = 10;
            truncation_symbol = "⋯/";
            substitutions = {
              "/run/media/${config.home.username}" = "󰕓";
            };
          };
        };
    };
  };
}
