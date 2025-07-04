{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.jofaul.fonts;
in
{
  options.jofaul.fonts = {
    enable = lib.mkEnableOption "activate fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      fontDir.enable = true;

      packages = with pkgs; [
        carlito
        dejavu_fonts
        ipafont
        kochi-substitute
        meslo-lgs-nf
        source-code-pro
        source-sans-pro
        source-serif-pro
        noto-fonts-emoji
        corefonts
        recursive
        ttf_bitstream_vera
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Recursive Sans Casual Static Medium" ];
          sansSerif = [ "Recursive Sans Linear Static Medium" ];
          monospace = [ "MesloLGS NF" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
