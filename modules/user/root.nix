{
  config,
  lib,
  ...
}:
let
  cfg = config.jonathan.user.root;
in
{
  options.jonathan.user.root = {
    enable = lib.mkEnableOption "activate user root";
  };

  config = lib.mkIf cfg.enable {
    users.users.root = {
      # trust noone
    };
  };
}
