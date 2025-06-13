{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.programs.git;
in
{
  options.jofaul.programs.git = {
    enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      ignores = [
        ".vscode/"
        ".idea/"
      ];
      extraConfig = {
        pull.rebase = false;
      };
      userEmail = "54673768+jofaul@users.noreply.github.com";
      userName = "jofaul";
      safe.directory = "/home/jonathan/.dotfiles";
    };

    home.packages = with pkgs; [
      pre-commit
      git-crypt
      transcrypt
    ];

  };
}
