{
  pkgs,
  lib,
  config,
  modulesPath,
  username,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "faker";
    networkmanager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    pulseaudio.enable = false;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      videoDrivers = ["amdgpu"];
      displayManager.gdm.enable = true;
    };

    displayManager.autoLogin.user = username;
    displayManager.autoLogin.enable = true;

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.openrgb.enable = true;

    ratbagd.enable = true;
  };

  security.rtkit.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # utility
    dmidecode
    gpart
    gparted
    rocmPackages.rocm-smi
    wget
    system-config-printer
    nix-prefetch-git
    statix
    hplip
    tree
    btop
    wine
    piper
    git
    mangohud
    libratbag
    nerdfonts
    gnumake #depedency for r.nvim
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    R
    neovim
    emacs
    # rice
    starship
    cava
    lolcat
    pfetch
    hyfetch
    ani-cli
    cool-retro-term
    protonup
    #apps
    catt
    gallery-dl
    veracrypt
    rstudio
    discord
    obsidian
    obs-studio
    vesktop
    zoom
    zoom-us
    vlc
    cinelerra #video editing app
    kitty
    signal-desktop
    mangareader
    sqlite
    sqlitebrowser
    xclip
    qpwgraph
    freetube
    thunderbird
    alacritty
    # teamspeak_client
    input-remapper
    home-manager
    yazi
    ranger
    qbittorrent
    bitwarden-desktop
    github-desktop
    rofi
    # hyprland
    waybar # hyprland plugin
    swww # hyprland plugin
    mako #hyprland plugin
  ];

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # hardware-configuration.nix
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/a81c0627-6646-4ac3-b422-ff0dd165a7f9";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7BFB-D0DD";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
