{
  description = "System config";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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

  outputs = inputs@{ nixpkgs, darwin, home-manager, unstable, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      nixpkgs-overlays = final: prev: {
        unstable = unstable.legacyPackages.${prev.system};
      };
      pkgs = system: import nixpkgs {
        inherit system;
        overlays = [ inputs.emacs-overlay.overlay nixpkgs-overlays ];
        config = { allowUnfree = true; };
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      # Linux config
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        pkgs = pkgs "x86_64-linux";
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
          pkgs = pkgs "aarch64-darwin";
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
