{
  description = "System config";

  inputs = {
    stable.url = "nixpkgs/nixos-23.05";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "stable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = inputs@{ darwin, home-manager, stable, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      overlay-stable = system: final: prev: { 
        stable = import stable {
           inherit system;
           config.allowUnfree = true;
        };
      };
      pkgs = system: import stable {
        inherit system;
        overlays = [ (overlay-stable system) ];
        config = { allowUnfree = true; };
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
            home-manager.users.nixie = import ./nixie/linux-home.nix;
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
    };
}
