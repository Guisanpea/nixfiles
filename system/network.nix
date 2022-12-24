params: {
  networking.hostName = "nixos"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp42s0.useDHCP = true;

    # Dont wait for network to launch
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # DNS
  # services.resolved.enable = true;
  # networking.networkmanager = {
  #   enable = true;
  #   dns = "systemd-resolved";
  # };
  networking.nameservers = [ "1.1.1.1" ];
  # systemd.network.networks.enp3s0.dns = [ "1.1.1.1" ];
  networking.extraHosts =
    ''
      127.0.0.1 mysql-database
      127.0.0.1 rabbitmq
      127.0.0.1 redis
      127.0.0.1 kubernetes.docker.internal
      127.0.0.1 localhost
    '';

  services = {
    blueman.enable = false;
  };

  hardware.bluetooth.enable = true;
}
