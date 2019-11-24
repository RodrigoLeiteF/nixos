{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    lutris
    sc-controller
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  # Enable OpenGL for 32 bit programs
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;
  hardware.steam-hardware.enable = true; 
}
