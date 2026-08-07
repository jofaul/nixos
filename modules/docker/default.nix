{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.docker;
in
{
  options.jofaul.docker = {
    enable = lib.mkEnableOption "activate docker";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ docker-compose ];

    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--all" ];
      };

      daemon.settings = {
        dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
    };

    virtualisation.oci-containers = {
      backend = "docker";
    };

    users.extraGroups.docker.members = lib.mkIf config.jofaul.user.jonathan.enable [ "jonathan" ];

  };
}
