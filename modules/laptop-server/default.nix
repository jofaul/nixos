{
  config,
  lib,
  ...
}:
let
  cfg = config.jofaul.laptop-server;
in
{
  options.jofaul.laptop-server = {
    enable = lib.mkEnableOption "contains configuration for my server, mainly homeassistant";
  };

  config = lib.mkIf cfg.enable {
    jofaul = {
      docker.enable = true;
      homeassistant.enable = true;
    };

    services.logind.settings.Login = {
      # Do not suspend when the lid is closed.
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    }; 

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
      extraUpFlags = [
        "--advertise-exit-node"
      ];
    };
      
  };
}
