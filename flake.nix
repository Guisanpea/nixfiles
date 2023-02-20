{
  description = "System config";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/22.11";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{ nixpkgs, darwin, home-manager,  unstable, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      nixpkgs-overlays = final: prev: {
        unstable = unstable.legacyPackages.${prev.system};
      };
      pkgs = import nixpkgs {
        overlays = [
          inputs.emacs-overlay.overlay
          nixpkgs-overlays
        ];
        config = { allowUnfree = true; };
      };
      linuxPkgs = pkgs // { system = linuxSystem; };
      macPkgs = pkgs // { system = macSystem; };
    in {
      # Linux config
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        pkgs = linuxPkgs;
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager {
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
          pkgs = macPkgs;
          modules = [
            ./mac-system.nix
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ssanchez = import ./nixie/mac-home.nix;
            }
          ];
        };
      };
    };
}
