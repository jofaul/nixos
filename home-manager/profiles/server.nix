{
  pkgs,
  ...
}:
{
  config = {
    jofaul = {
      programs.gnome-settings.enable = true;
      programs.vscode.enable = true;
      programs.ghostty.enable = true;
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
      extraUpFlags = [
        "--advertise-exit-node"
      ];
    };

    home.packages = with pkgs; [
      gparted 
      obsidian
      zen-browser.packages.${stdenv.hostPlatform.system}.default
    ];
    
  };
}
