{
  description = "Sanchez's Nix Systems Configuration";
  # Note which Nix version is required
  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  inputs = {
    unstable.url = "nixpkgs/nixos-unstable";
    stable.url = "nixpkgs/nixos-25.05";
    php74pkgs.url = "nixpkgs/nixos-22.05";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "stable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "stable";
    };
    doomemacs.url = "github:doomemacs/doomemacs";
  };

  outputs =
    {
      darwin,
      home-manager,
      stable,
      unstable,
      php74pkgs,
      ...
    }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";

      # Overlay for stable packages
      overlays = [
        (final: prev: {
          stable = import stable {
            inherit (prev) system;
            config.allowUnfree = true;
          };
          php74pkgs = import php74pkgs {
            inherit (prev) system;
            config.allowUnfree = true;
          };
        })
      ];

      # Unified package set constructor
      mkPkgs =
        system:
        import unstable {
          inherit system overlays;
          config.allowUnfree = true;
        };
    in
    {
      formatter.x86_64-linux = unstable.legacyPackages.x86_64-linux.nixpkgs-fmt;
      # Mac config
      darwinConfigurations = {
        ssanchez = darwin.lib.darwinSystem {
          system = macSystem;
          pkgs = mkPkgs macSystem;
          modules = [
            ./mac-system.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ssanchez = import ./darwin/home.nix;
            }
          ];
        };
      };
      # Arch config
      homeConfigurations."archie" = home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs linuxSystem;
        modules = [
          ./linux/home.nix
        ];
      };

    };
}
