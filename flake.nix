{
  description = "krwenholz's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nurpkgs.url = github:nix-community/NUR;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
         kyle = (with { username = "kyle"; }; import ./outputs/home-conf.nix { inherit inputs system username pkgs; });
         code = (with { username = "code"; }; import ./outputs/home-conf.nix { inherit inputs system username pkgs; });
      };
    };
}