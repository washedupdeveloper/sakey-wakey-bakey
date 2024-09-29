{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.opengl = {
    enable = true;
    enable32Bit = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "breeze";
      settings = {
        General = {
          DisplayCommand = "/run/current-system/sw/bin/sleep 30";
          Background = "~/Pictures/thetree.png";
        };
      };
    };
    desktopManager.plasma6.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.pretender = {
    isNormalUser = true;
    description = "pretender";
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.firefox.enable = true;

  #enable open RGB
  services.hardware.openrgb.enable = true;

  # depedency for piper
  services.ratbagd.enable = true;

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

  # Environment session variables
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOL_PATHS = "/home/pretender/.steam/root/compatibilitytools.d";
  };
  #fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];
}
