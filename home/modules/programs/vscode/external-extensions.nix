# Warning, this file is autogenerated by nix4vscode. Don't modify this manually.
{
  pkgs,
  lib,
}: let
  inherit (pkgs.stdenv) isDarwin isLinux isi686 isx86_64 isAarch32 isAarch64;
  vscode-utils = pkgs.vscode-utils;
  merge = lib.attrsets.recursiveUpdate;
in
  merge
  (merge
    (merge
      (merge
        {
          "supermaven"."supermaven" = vscode-utils.extensionFromVscodeMarketplace {
            name = "supermaven";
            publisher = "supermaven";
            version = "0.1.50";
            sha256 = "0mfm7nimx4rkkilqqflgcdj3cr3m39bnhb085a665599kv1vclwg";
          };
        }
        (lib.attrsets.optionalAttrs (isLinux && (isi686 || isx86_64)) {
          "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
            name = "continue";
            publisher = "continue";
            version = "0.9.133";
            sha256 = "1p0yxx53d4zs85j6qibgi8qwcdiw00i9c51bz36ag21m0q2961kn";
            arch = "linux-x64";
          };
        }))
      (lib.attrsets.optionalAttrs (isLinux && (isAarch32 || isAarch64)) {
        "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
          name = "continue";
          publisher = "continue";
          version = "0.9.133";
          sha256 = "0d1h2fzxk68q7dv4b49w0daspm9q86j42x1xj5r2hfq9hmhfvghs";
          arch = "linux-arm64";
        };
      }))
    (lib.attrsets.optionalAttrs (isDarwin && (isi686 || isx86_64)) {
      "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
        name = "continue";
        publisher = "continue";
        version = "0.9.133";
        sha256 = "1ws84pfz9hjglr31zrp7qzdwm4mxslab6zjsldif8g3aq6n4np82";
        arch = "darwin-x64";
      };
    }))
  (lib.attrsets.optionalAttrs (isDarwin && (isAarch32 || isAarch64)) {
    "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
      name = "continue";
      publisher = "continue";
      version = "0.9.133";
      sha256 = "14am3aym17vjkk04v4q8wbnsr1nai9az92dl107hyq532zky5zmy";
      arch = "darwin-arm64";
    };
  })
