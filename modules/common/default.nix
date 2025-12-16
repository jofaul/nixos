{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.common;
in
{
  options.jofaul.common = {
    enable = lib.mkEnableOption "contains configuration that is common to all systems";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
    
    jofaul = {
      locale.enable = true;
      nix-common.enable = true;
      openssh.enable = true;
      user = {
        jonathan.enable = true;
        root.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      dnsutils
      git
      wget
    ];
  };
}
