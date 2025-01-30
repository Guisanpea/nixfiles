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
      url = "github:nix-community/home-manager/master";
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
        modules = [ 
          ./linux/home.nix
        ];
      };
    };
}
