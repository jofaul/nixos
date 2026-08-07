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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEbfCJB2FMujpl1+s+M7GG2HuvTk6s9vrgR8rFMwTZoC jonathan@DESKTOP-48R4TIG"
      ];
    };
  };
}
