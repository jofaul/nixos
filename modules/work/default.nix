{
  betternix,
  config,
  lib,
  pkgs,
  sops-nix,
  ...
}:
let
  cfg = config.jofaul.work;
in
{
  imports = [
    betternix.nixosModules.default
    sops-nix.nixosModules.default
  ];

  options.jofaul.work = {
    enable = lib.mkEnableOption "activate work";
  };

  config = lib.mkIf cfg.enable {

    betternix = {
      hosts.enable = true;
      java.enable = true;
      # postgresql.enable = true;
      # rabbitmq.enable = true;
      trusted-certificates.enable = true;
    };

    environment.systemPackages = with pkgs; [
      subversion
    ];

    environment.variables = {
      JAVA_HOME = "/etc/static/bettertec/jdk_21";
      GRADLE_LOCAL_JAVA_HOME = "/etc/static/bettertec/jdk_21";
    };
  };
}
