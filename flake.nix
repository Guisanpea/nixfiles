{
  description = "System config";

  inputs = {
    nixpkgs2205.url = "github:nixos/nixpkgs/22.05";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
    };

    # Nix emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-matlab, nixpkgs2205, ... }:
  let 
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    overlay-2205 = final: prev: {
      p2205 = nixpkgs2205.legacyPackages.${prev.system};
    };
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.emacs-overlay.overlay
#        inputs.neovim-nightly-overlay.overlay
        inputs.nix-matlab.overlay
        overlay-2205
      ];
      config = { allowUnfree = true; };
    };
  in {
    hmConfig = {
      nixie = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "nixie";
        homeDirectory = "/home/nixie";
        configuration = {
          imports = [
            ./nixie/home.nix
          ];
        };
      };
    };
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system pkgs;
      modules = [
        ./system/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixie = {
            imports = [ ./nixie/home.nix ];
          };
        }
      ];
    };
  };
}
