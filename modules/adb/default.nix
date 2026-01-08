{
  config,
  lib,
  ...
}:
let
  cfg = config.jofaul.adb;
in
{
  options.jofaul.adb = {
    enable = lib.mkEnableOption "Enable Android development tools";
  };

  config = lib.mkIf cfg.enable {
    users.users.jonathan.extraGroups = [ "adbusers" ];
    networking.firewall.allowedTCPPorts = [ 8081 ];
    networking.firewall.allowedUDPPorts = [ 8081 ];
  };
}
