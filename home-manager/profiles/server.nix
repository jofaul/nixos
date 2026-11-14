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

    home.packages = with pkgs; [
      gparted 
      obsidian
      zen-browser.packages.${stdenv.hostPlatform.system}.default
    ];
    
  };
}
