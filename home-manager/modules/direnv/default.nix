{
  config,
  lib,
  ...
}:
let
  cfg = config.jofaul.programs.direnv;
in
{
  options.jofaul.programs.direnv = {
    enable = lib.mkEnableOption "activate direnv";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      git = {
        ignores = [ ".direnv/" ];
      };

      # vscode = {
      #   extensions = with pkgs.vscode-extensions; [ mkhl.direnv ];
      # };

    };

  };
}
