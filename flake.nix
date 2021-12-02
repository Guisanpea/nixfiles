{
  description = "System config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix doom emacs
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/develop";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-doom-emacs, ... }:
  let 
    system = "x86_64-linux";
    overlays = [ inputs.emacs-overlay.overlay ];
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      inherit overlays;
    };

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      nixie = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "nixie";
        homeDirectory = "/home/nixie";
        configuration = {
          imports = [
            nix-doom-emacs.hmModule
            ./users/nixie/home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; }
        ];
      };
    };
  };
}
