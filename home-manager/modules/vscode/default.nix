{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.programs.vscode;
in
{
  options.jofaul.programs.vscode = {
    enable = lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf cfg.enable {
    # Enable Wayland support, disabeled for now because it breaks obsidian (and maybe other electron apps)
    # home.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
