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
    programs.git.includes = [
      {
        condition = "gitdir:~/source/";
        contents = {
          user.name = "Jonathan Faulkner";
          user.email = "jf@bettertec-services.com";
        };
      }
    ];
  
    # fix for git config issue in idea programs
    home.file = {
      # home-manager wrongly thinks it doesn't manage (and thus shouldn't clobber) this file due to the activation script
      ".ssh/config".force = true;
    };

    home.activation = {
      # https://github.com/nix-community/home-manager/issues/322
      fixSshPermissions = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        run install -d -m 0700 "$HOME/.ssh"
        if [ -L "$HOME/.ssh/config" ]; then
          src="$(readlink -f "$HOME/.ssh/config")"
          run rm -f "$HOME/.ssh/config"
          run install -m 0600 "$src" "$HOME/.ssh/config"
        fi
      '';
    };
  };

}
