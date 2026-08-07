{
  config,
  lib,
  pkgs,
  nixpkgs-stable,
  ...
}:
let
  cfg = config.jofaul.homeassistant;
in
{
  options.jofaul.homeassistant = {
    enable = lib.mkEnableOption "activate homeassistant";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers = {
        backend = "docker"; 
        containers.homeassistant = {
          image = "ghcr.io/home-assistant/home-assistant:stable";
          volumes = [
            "home-assistant:/config"
            "/etc/localtime:/etc/localtime:ro"
          ];
          environment.TZ = "Europe/Berlin";
          extraOptions = [
            "--network=host"
          ];
        };

        containers.matter-server = {
          image = "ghcr.io/home-assistant-libs/python-matter-server:stable";
          volumes = [
            "matter-server-data:/data"
          ];
          extraOptions = [
            "--network=host"
            "--env" "MATTERMGR_LISTEN_HOST=0.0.0.0"
            "--env" "MATTERMGR_LISTEN_PORT=5580"
          ];
        };
      };

      networking.firewall.allowedTCPPorts = [ 8123 ];
  };
}