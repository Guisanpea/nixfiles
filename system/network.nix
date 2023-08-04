{ ... }: {
  networking = {

    hostName = "nixos"; # Define your hostname.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp42s0.ipv4.addresses = [{
      address = "192.168.1.101";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # Dont wait for network to launch
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  services = { blueman.enable = true; };

  hardware.bluetooth.enable = true;
}
