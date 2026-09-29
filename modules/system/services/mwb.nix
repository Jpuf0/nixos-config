{inputs, ...}: {
  imports = [inputs.self.nixosModules.mwb];

  programs.mwb = {
    enable = true;
    users = ["jpuf"];
    extraArgs = [];
  };
}
