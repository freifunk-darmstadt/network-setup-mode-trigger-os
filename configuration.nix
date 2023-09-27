
{ config, pkgs, lib, ... }:
{
  #isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  boot.kernelParams = [ "net.ifnames=0" ];

  services.openssh.enable = lib.mkForce false;
  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  time.timeZone = "Europe/Berlin";

  networking.hostName = "setup-mode-trigger";

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "de";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    htop
    nano
    wget
    curl
    tcpdump
    ethtool
    tmux
    (import ./ffda-network-setup-mode.nix)
  ];

  networking = {
    useNetworkd = true;
    usePredictableInterfaceNames = false;
    useDHCP = false;
  };

  services.getty.helpLine = lib.mkForce ''
    #####################################################################
    #                                                                   #
    # Run `sudo send-network-request eth0` to start sending requests. #
    #                                                                   #
    #####################################################################
  '';

  programs.ssh.extraConfig = ''
    Host 192.168.0.1 192.168.1.1 192.168.8.1 192.168.88.1 192.168.1.254 192.168.1.20 fdc3:67ce:cc7e:9001::1:1 fdc3:67ce:cc7e:9040::1:1 fd01:67c:2ed8:10*::1:1
      StrictHostKeyChecking no
      UserKnownHostsFile /dev/null
      LogLevel QUIET

    Host *
      LogLevel ERROR
      User root
  '';

  systemd.network = {
    networks = {
      "99-default" = {
        matchConfig.Name = "*";
        networkConfig = {
          IPv6AcceptRA = true;
          DHCP = "yes";
        };
      };
    };
  };
  
}
