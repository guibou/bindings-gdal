let
  pkgs = import ./nixpkgs.nix;

  haskellPackages = pkgs.haskellPackages.override {
    overrides = self: super: with pkgs.haskell.lib; {
      resourcet = super.resourcet_1_1_11;
      conduit = super.conduit_1_2_13_1;
    };
  };

  # gdal 2.4 generates failures
  gdal_2_3_1 = pkgs.callPackage (pkgs.fetchurl {
    url = https://raw.githubusercontent.com/NixOS/nixpkgs/e6a3e4706a7ad368528988052c2eb4ea7dd058e4/pkgs/development/libraries/gdal/default.nix;
    sha256 = "17rd0q9ysbwxsj1bbxhx3apdk0ys9kjhjiw8r5dyzkb18qj7fdmp";
  }) {
      poppler = pkgs.poppler_0_61;
  };

  withGdal = gdal: haskellPackages.callCabal2nixWithOptions "bindings-gdal" (pkgs.lib.sources.cleanSource ./.)  "-f -autoconfig" { inherit gdal; };

  jobs = rec {
    bindings-gdal_2_3_1 = withGdal gdal_2_3_1;
    bindings-gdal_2_4_0 = withGdal pkgs.gdal;
    bindings-gdal_1_11 = withGdal pkgs.gdal_1_11;
  };
in
  jobs
