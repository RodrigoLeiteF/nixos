# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./vfio.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "home"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking = {
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
    hosts = {
      "0.0.0.0" = [ "www.facebook.com" "facebook.com" "twitter.com" ];
    };
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = true;
    displayManager = { sddm.enable = true; };
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    videoDrivers = [ "amdgpu" ];
  };

  services.k3s.enable = false;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sky = {
    isNormalUser = true;
    createHome = true;
    description = "Sky Leite";
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "input" ];
    group = "users";
    home = "/home/sky";
    hashedPassword =
      "$6$BxcfpoGqb.I$msdWrRc75bsmegjGBvrC.qRS1Hw5KR0OjseqTZnxoN.U7W52srD5WWT0w4Z5QhFjZaq7/gzQXQ1YUfSlvcE13.";
    uid = 1234;
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    albert
    bitwarden
    discord
    docker
    docker-compose
    dolphin
    editorconfig-core-c
    emacs
    fd
    firefox
    flameshot
    git
    gparted
    neovim
    nixfmt
    pciutils
    peek
    plasma-desktop
    python3
    ripgrep
    teams
    unityhub
    yakuake
    wget
    xclip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.sshd.enable = true;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

