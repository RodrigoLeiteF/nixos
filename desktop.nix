{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    i3-gaps
    wmfocus
    i3-layout-manager
    i3lock-fancy
    i3status-rust
    alacritty
    lsd
    flameshot
    mesa_drivers
    dunst
    mpd
    mpd-mpris
    playerctl
    firefox
    rofi
    xclip
    font-awesome_4
    compton
  ];

  # Enable the KDE and i3 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "intl";
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
    extraClientConf = ''
	    autospawn=yes
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable services
  services.openssh.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = "/mnt/hdd/Music";
    extraConfig = ''
    audio_output {
	    type "pulse"
	    name "pulse"
    }
    '';
  };

}

