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
    
  };
}
