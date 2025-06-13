{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jonathan.common;
in
{
  options.jonathan.common = {
    enable = lib.mkEnableOption "contains configuration that is common to all systems";
  };

  config = lib.mkIf cfg.enable {
    programs.bash.enable = true;

    jonathan = {
      locale.enable = true;
      nix-common.enable = true;
    #   openssh.enable = true;
      user = {
        jofaul.enable = true;
        root.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      #dnsutils
      git
      wget
    ];
  };
}
