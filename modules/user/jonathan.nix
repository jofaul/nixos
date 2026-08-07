{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.user.jonathan;
in
{
  options.jofaul.user.jonathan = {
    enable = lib.mkEnableOption "activate user jonathan";
  };

  config = lib.mkIf cfg.enable {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jonathan = {
      isNormalUser = true;
      description = "Jonathan";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = lib.mkIf config.programs.zsh.enable pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEbfCJB2FMujpl1+s+M7GG2HuvTk6s9vrgR8rFMwTZoC jonathan@DESKTOP-48R4TIG"
      ];
    };

    nix.settings = {
      allowed-users = [ "jonathan" ];
    };
  };
}
