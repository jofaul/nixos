{
  config,
  lib,
  pkgs,
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
    # better hosts
    networking.hosts = {
      "127.0.0.1" = [
        "localhost"
        "postgres"
      ];

      "10.0.0.4" = [ "bettertest-sftp-1" ];
      "10.0.0.5" = [ "bettertest-web-1" ];
      "10.0.0.6" = [ "bettertest-db-2" ];
      "10.0.0.7" = [ "bettertest-worker-2" ];
      "10.0.0.8" = [ "bettertest-worker-1" ];
      "10.0.0.9" = [ "bettertest-sftp-2" ];
      "10.0.0.10" = [ "bettertest-db-1" ];
      "10.0.0.11" = [ "bettertest-web-3" ];
      "10.0.0.12" = [ "bettertest-web-4" ];
      "10.0.0.13" = [ "bettertest-monitor" ];
      "10.0.0.14" = [ "bettertest-worker-3" ];
      "10.0.0.15" = [ "bettertest-web-2" ];
      "10.0.0.16" = [ "bettertest-worker-4" ];
      "10.0.0.17" = [ "bettertest-sftp-3" ];
      "10.0.0.18" = [ "bettertest-sftp-4" ];
      "10.0.0.19" = [ "bettertest-db-3" ];
      "10.0.0.21" = [ "bettertest-monitor-1" ];
      "10.0.0.22" = [ "bettertest-db-4" ];
      "10.0.0.23" = [ "bettertest-db-5" ];

      "10.3.2.4" = [ "ncetest-net-1" ];
      "10.3.2.5" = [ "ncetest-work-1" ];
      "10.3.2.6" = [ "ncetest-net-2" ];
      "10.3.2.7" = [ "ncetest-work-2" ];

      "192.168.2.41" = [ "admin.ubuntu-test-dlr" ];

      "10.2.2.4" = [ "bettertec-db-1" ];
      "10.2.2.5" = [ "bettertec-worker-3" ];
      "10.2.2.6" = [ "bettertec-web-3" ];
      "10.2.2.7" = [ "bettertec-worker-4" ];
      "10.2.2.8" = [ "bettertec-web-4" ];
      "10.2.2.9" = [ "bettertec-monitor" ];
      "10.2.2.10" = [ "bettertec-db-2" ];
      "10.2.2.11" = [ "bettertec-sftp-3" ];
      "10.2.2.12" = [ "bettertec-sftp-4" ];
      "10.2.2.13" = [ "bettertec-worker-1" ];
      "10.2.2.14" = [ "bettertec-worker-2" ];
      "10.2.2.15" = [ "bettertec-sftp-1" ];
      "10.2.2.16" = [ "bettertec-sftp-2" ];
      "10.2.2.17" = [ "bettertec-web-1" ];
      "10.2.2.18" = [ "bettertec-web-2" ];
      "10.2.2.19" = [ "bettertec-db-3" ];
      "10.2.2.20" = [ "bettertec-db-4" ];
      "10.2.2.21" = [ "bettertec-monitor-1" ];

      "10.4.2.4" = [ "nce-net-1" ];
      "10.4.2.5" = [ "nce-work-1" ];
      "10.4.2.6" = [ "nce-net-2" ];
      "10.4.2.7" = [ "nce-work-2" ];

      "192.168.2.68" = [ "betterstorage" ];

      "192.168.2.148" = [
        "betterbuild-local.btc"
        "jenkins.betterbuild-local.btc"
        "artifactory.betterbuild-local.btc"
        "apt.betterbuild-local.btc"
        "puppetboard.betterbuild-local.btc"
        "sonarqube.betterbuild-local.btc"
      ];

      "192.168.2.150" = [
        "betterbuild"
        "betterbuild.local"
        "jenkins.betterbuild.local"
        "artifactory.betterbuild.local"
        "apt.betterbuild.local"
      ];

      "192.168.2.222" = [
        "build.bettertec.internal"
        "git.bettertec.internal"
        "artifactory.bettertec.internal"
        "jenkins.bettertec.internal"
      ];
    };

    environment.systemPackages = with pkgs; [
      subversion
    ];

    #azure-vpn - ssh only?
  };
}
