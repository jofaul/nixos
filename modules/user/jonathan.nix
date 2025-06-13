{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.user.paulmiro;
in
{
  options.jofaul.user.jonathan = {
    enable = lib.mkEnableOption "activate user jofaul";
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
      openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys; # looks stupid but does the job
    };

    nix.settings = {
      allowed-users = [ "jonathan" ];
    };
  };
}
