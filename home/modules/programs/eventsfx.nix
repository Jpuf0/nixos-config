{inputs, ...}: {
  home.packages = with inputs.eventsfx.packages; [default];
}
