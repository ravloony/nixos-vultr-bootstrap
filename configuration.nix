{ config, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernel = {
      sysctl."vm.overcommit_memory" = "1";
    };

    loader = {
      grub.device = "/dev/vda";
      grub.enable = true;
      grub.version = 2;
    };
  };
  
  fileSystems = [
   # Mount the root file system
   #
     { mountPoint = "/";
       device = "/dev/vda1";
       label = "root";
     }
  ];

  environment = {
    systemPackages = with pkgs; [
      curl
      gcc
      git
      nix-repl
      tmux
      vim
      wget
    ];

    variables = {
      EDITOR = "vim";
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    hostName = "merkle";
  };

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  programs = {
    bash = {
      enableCompletion = true;
    };

    ssh = {
      startAgent = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "prohibit-password";
    };
  };

  time.timeZone = "America/New_York";

  users = {
    extraUsers = {
      ghost = {
        extraGroups = [ "wheel" ];
        isNormalUser = true;
        openssh.authorizedKeys.keys = with import ./ssh-keys.nix; [ bobbles ];
      };

      root = {
        openssh.authorizedKeys.keys = with import ./ssh-keys.nix; [ bobbles ];
      };
    };
  };

  system.stateVersion = "18.03";
}
