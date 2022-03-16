# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "suanix"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montreal";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

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
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "localhost";
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  boot.extraModprobeConfig = ''
  options snd slots=snd-hda-intel
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sonoflope = {
    isNormalUser = true;
    extraGroups = ["audio" "wheel" "video" "wireshark" "networkmanager" "vboxusers" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # Sets default shell
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic
    vim
    neovim

    lsof
    zsh	  
    wget
    curl
  ];


  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.kernelModules = [ "wl" ];  # set of kernels modules loaded in second stage of boot process 
  boot.initrd.kernelModules = [ "kvm-intel" "wl" ]; # list of modules always loaded by the initrd
   
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #programs.java.enable = true;
  
  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true; 
  virtualisation.docker.enable = true;
  # Enable the Oracle Extension Pack.
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  hardware.bluetooth.enable = true;
  # List services that you want to enable:
  services = {
    openssh.enable = true;

    # bluetooth control
    blueman.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Allow unfree packages system-wide. To allow access to unfree packages
  # in nix-env, also set:
  #
  # ~/.config/nixpkgs/config.nix to { allowUnfree = true; }
  #nixpkgs.config.allowUnfree = true;

  # don't change this
  system.stateVersion = "21.11";
}

