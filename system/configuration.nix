# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.kernelModules = [ "wl" ];  # set of kernels modules loaded in second stage of boot process 
  boot.initrd.kernelModules = [ "kvm-intel" "wl" ]; # list of modules always loaded by the initrd

  networking = {
    # Defines hostname
    hostName = "suanix";
    # Enables wireless support
    networkmanager = {
      enable = true;
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    firewall.allowedTCPPorts = [ 3389 ];
  };

  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Set your time zone.
  time.timeZone = "America/Montreal";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14.withPackages (p: [ p.timescaledb ]);
    dataDir = "/data/postgresql";
    settings = {
      shared_preload_libraries = "timescaledb";
    };
  };

  


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable the Plasma 5 Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };


  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "localhost";
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";


  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio = { 
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };


  #boot.extraModprobeConfig = ''
  #options snd slots=snd-hda-intel
  #'';


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sonoflope = {
    isNormalUser = true;
    extraGroups = ["audio" "wheel" "video" "wireshark" "networkmanager" "vboxusers" "docker" ]; # wheel for 'sudo'.
    shell = pkgs.zsh;
  };

  # Sets default shell
  #users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic
    curl
    lsof
    neovim
    vim
    wget
    zsh	  
  ];
   
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation= {
    docker = { 
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  hardware.bluetooth.enable = true;
  
  services = {
    openssh = { 
      enable = true;
      allowSFTP = true;
    };

    # bluetooth control
    blueman.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  
  # don't change this
  system.stateVersion = "21.11";
}

