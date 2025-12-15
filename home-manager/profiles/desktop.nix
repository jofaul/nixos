{
  flake-self,
  lib,
  pkgs,
  system-config,
  ...
}:
{
  config = {
    jofaul = {
      programs.gnome-settings.enable = true;
      programs.vscode.enable = true;
      programs.ghostty.enable = true;

      programs.development = {
        android = true;
        java = true;
        python = true;
      };
    };

    programs = {
      firefox = {
        enable = true;
        package = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { });
      };
    };

    # Install these packages for my user
    home.packages =
      with pkgs;
      [
        audacity
        discord
        gnome-graphs # plot data
        gparted # disk stuff manager
        inkscape # vector graphic editor
        jellyfin-mpv-shim
        krita # painting (gimp?)
        libreoffice
        # mattermost-desktop # some coding shit that i dont know a server for
        # mixxx # dj app
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
        wasistlos
        vdhcoapp
        firefox
        # cooked ahh notation
        flake-self.inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
      ]
      # only install these packages on x86_64-linux systems
      ++ lib.optionals (system-config.nixpkgs.hostPlatform.isx86_64) [
        nvtopPackages.full
      ];
  };
}
