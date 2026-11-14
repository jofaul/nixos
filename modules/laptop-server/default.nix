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
    enable = lib.mkEnableOption "keeps the laptop awake with lid closed";
  };

  config = lib.mkIf cfg.enable {

    services.logind.settings.Login = {
      # Do not suspend when the lid is closed.
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

  };
}
