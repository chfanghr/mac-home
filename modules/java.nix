{
  config,
  pkgs,
  ...
}: {
  programs.java = {
    enable = true;
    package = pkgs.graalvm-ce;
  };
}
