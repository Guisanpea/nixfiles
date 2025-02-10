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
    stable.url = "nixpkgs/nixos-23.05";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "stable";

    astronvim.url = "github:astronvim/astronvim/v3.36.11";
    astronvim.flake = false;

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = inputs@{ astronvim, darwin, home-manager, nixpkgs-stable, nixpkgs-unstable, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      
      # Overlay for stable packages
      overlays = [
        (final: prev: {
          stable = import nixpkgs-stable {
            system = prev.system;
            config.allowUnfree = true;
          };
        })
      ];

      # Unified package set constructor
      mkPkgs = system: import nixpkgs-unstable {
        inherit system overlays;
        config.allowUnfree = true;
      };
      specialArgs = {
        inherit astronvim;
      };
    in
    {
      formatter.x86_64-linux = stable.legacyPackages.x86_64-linux.nixpkgs-fmt;
      # Mac config
      darwinConfigurations = {
        ssanchez = darwin.lib.darwinSystem {
          system = macSystem;
          pkgs = pkgs macSystem;
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
        pkgs = pkgs linuxSystem;
        extraSpecialArgs = specialArgs;
        modules = [ 
          ./linux/home.nix 
        ];
      };

      homeConfigurations."ssanchez" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs macSystem;
        extraSpecialArgs = specialArgs;
        modules = [
          ./darwin/home.nix
        ];
      };
    };
}
