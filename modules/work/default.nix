{
  config,
  lib,
  ...
}:
let
  cfg = config.jofaul.work;
in
{
  options.jofaul.work = {
    enable = lib.mkEnableOption "activate work";
  };

  config = lib.mkIf cfg.enable {
    # internal hosts
    networking.hosts = {
      "192.168.2.222" = [
        "build.bettertec.internal"
        "jenkins.bettertec.internal"
        "artifactory.bettertec.internal"
        "git.bettertec.internal"
      ];
    };

    #azure-vpn
    #teams? outlook? ew
    #also mount disk
  };
}
