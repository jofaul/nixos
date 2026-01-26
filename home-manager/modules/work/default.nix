{
  betternix,
  config,
  lib,
  ...
}:
let
  cfg = config.jofaul.work;
in
{
  imports = [
    betternix.homeModules.default
  ];

  options.jofaul.work = {
    enable = lib.mkEnableOption "enable work stuff";
  };

  config = lib.mkIf cfg.enable {
    betternix.ssh.enable = true;
    betternix.packages.enable = true;
  };
}
