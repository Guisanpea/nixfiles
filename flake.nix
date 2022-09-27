{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs2205.url = "github:nixos/nixpkgs/22.05";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{ nixpkgs, darwin, home-manager,  nixpkgs2205, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      overlay-2205 = final: prev: {
        p2205 = nixpkgs2205.legacyPackages.${prev.system};
      };
      pkgs = import nixpkgs {
        overlays = [
          inputs.emacs-overlay.overlay
          overlay-2205
        ];
        config = { allowUnfree = true; };
      };
      linuxPkgs = pkgs // { system = linuxSystem; };
      macPkgs = pkgs // { system = macSystem; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        pkgs = linuxPkgs;
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
      darwinConfigurations = {
        ssanchez = darwin.lib.darwinSystem {
          system = macSystem;
          pkgs = macPkgs;
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
