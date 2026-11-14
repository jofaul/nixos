{
  lib,
  pkgs,
  system-config,
  zen-browser,
  ...
}:
{
  config = {
    jofaul = {
      programs.gnome-settings.enable = true;
      programs.vscode.enable = true;
      programs.ghostty.enable = true;

      work.enable = true;

      programs.development = {
        android = true;
        java = true;
        python = true;
      };
    };

    # disable firefox, we have zen
    programs.firefox.enable = false;

    # Install these packages for my user
    home.packages = with pkgs; [
      discord
      gnome-graphs # plot data
      gparted # disk stuff manager
      inkscape # vector graphic editor
      jellyfin-mpv-shim
      krita # painting (gimp?)
      libreoffice
      mpv
      obsidian
      oneko # very important
      onlyoffice-desktopeditors # libreoffice but weird
      signal-desktop
      sl # also important
      spotify
      switcheroo # convert imagetypes
      textpieces # checksums and shit idk
      thunderbird-bin
      tor-browser
      ungoogled-chromium
      karere
      # cooked ahh notation
      zen-browser.packages.${stdenv.hostPlatform.system}.default
    ];
  };
}
