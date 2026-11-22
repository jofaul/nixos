{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.programs.development;
in
{
  options.jofaul.programs.development = {
    android = lib.mkEnableOption "enable Android";
    c_cpp = lib.mkEnableOption "enable C/C++";
    go = lib.mkEnableOption "enable Go";
    godot = lib.mkEnableOption "enable Godot";
    java = lib.mkEnableOption "enable Java";
    javascript = lib.mkEnableOption "enable JavaScript";
    lua = lib.mkEnableOption "enable Lua";
    python = lib.mkEnableOption "enable Python";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.android {
      home.sessionVariables = {
        ANDROID_HOME = "~/.android/sdk"; # because fuck whoever decided to name that folder "Android" instead of ".android"
      };

      home.packages = with pkgs; [
        android-studio
        android-tools
        dbeaver-bin # usually needed with android stuff
      ];
    })
    (lib.mkIf cfg.java {
      environment.etc = {
        "dev/jdk_25".source = "${pkgs.jdk25}/lib/openjdk";
        "dev/maven".source = "${pkgs.maven}/maven";
        "dev/gradle_9".source = gradle_9;
      };

      environment.systemPackages = with pkgs; [
        jdk25
        maven
        gradle_9
      ];

      home.packages = with pkgs; [
        jetbrains.idea
      ];
    })
    (lib.mkIf cfg.python {
      home.packages = with pkgs; [
        (python3.withPackages (
          ps: with ps; [
            requests
            numpy
            jupyter
          ]
        ))
      ];
    })
  ];
}
