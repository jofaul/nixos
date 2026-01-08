{
  pkgs,
  ...
}:
{
  config = {

    jofaul = {
      programs.direnv.enable = true;
      programs.git.enable = true;
      programs.zsh.enable = true;
      nixpkgs-config.enable = true;
    };

    # Home-manager nixpkgs config
    nixpkgs = {
      overlays = [ ];
    };

    # Include man-pages
    manual.manpages.enable = true;

    # Install these packages for my user
    home.packages = with pkgs; [
      asciinema # share terminal sessions
      croc # send files
      dnsutils
      glances # cooler htop
      neofetch # hardware specs
      nil # nix language server
      nix-tree # browse nix dependencies
      nixfmt # TODO: change to "nixfmt" once it is replaced
      openssl
      ripgrep
      # tmux # zellij but older
      unixtools.xxd
      unzip
      usbutils
      zellij # tmux but cooler
    ];

    programs.yazi.enable = true; # file manager but duck

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.stateVersion = "25.05";

  };
}
