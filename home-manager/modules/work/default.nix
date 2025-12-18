{
  betternix,
  config,
  lib,
  ...
}:
let
  cfg = config.paul.work;
in
{
  imports = [
    betternix.homeModules.default
  ];

  options.paul.work = {
    enable = lib.mkEnableOption "enable work stuff";
  };

  config = lib.mkIf cfg.enable {
    betternix.ssh.enable = true;
  };
}
