{
  config,
  lib,
  ...
}:
let
  cfg = config.jofaul.user.root;
in
{
  options.jofaul.user.root = {
    enable = lib.mkEnableOption "activate user root";
  };

  config = lib.mkIf cfg.enable {
    users.users.root = {
      # trust noone
    };
  };
}
