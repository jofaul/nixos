{
  betternix,
  config,
  lib,
  pkgs,
  sops-nix,
  ...
}:
let
  cfg = config.jofaul.work;
in
{
  imports = [
    betternix.nixosModules.default
    sops-nix.nixosModules.default
  ];

  options.jofaul.work = {
    enable = lib.mkEnableOption "activate work";
  };

  config = lib.mkIf cfg.enable {

    betternix = {
      hosts.enable = true;
      # postgresql.enable = true;
      # rabbitmq.enable = true;
      trusted-certificates.enable = true;
    };

    environment.systemPackages = with pkgs; [
      subversion
    ];

    #azure-vpn - ssh only?
  };
}
