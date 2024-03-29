{
  description = "System config";

  inputs = {
    unstable.url = "nixpkgs/nixos-unstable";
    stable.url = "nixpkgs/nixos-23.05";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "stable";

    astronvim.url = "github:astronvim/astronvim/v3.36.11";
    astronvim.flake = false;

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = inputs@{ astronvim, darwin, home-manager, stable, unstable, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      overlay-stable = system: final: prev: {
        stable = import stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = system: import unstable {
        inherit system;
        overlays = [ (overlay-stable system) ];
        config = { allowUnfree = true; };
      };
      specialArgs = {
        inherit astronvim;
      };
    in
    {

      formatter.x86_64-linux = stable.legacyPackages.x86_64-linux.nixpkgs-fmt;
      # Linux config
      nixosConfigurations.nixos = stable.lib.nixosSystem {
        system = linuxSystem;
        pkgs = pkgs linuxSystem;
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nixie = import ./nixie/linux-home.nix { inherit astronvim; };
          }
        ];
      };
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
              home-manager.users.ssanchez = import ./nixie/mac-home.nix;
            }
          ];
        };
      };
      # Arch config
      homeConfigurations."archie" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs linuxSystem;

        extraSpecialArgs = specialArgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./archie.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
