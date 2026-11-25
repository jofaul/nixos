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
    java = lib.mkEnableOption "enable Java";
    python = lib.mkEnableOption "enable Python";
    vibecoding = lib.mkEnableOption "enable Vibecoding";
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
    (lib.mkIf cfg.vibecoding {
      home.packages = with pkgs; [
        claude-code
        claude-agent-acp
        mistral-vibe
      ];
    })
  ];
}
