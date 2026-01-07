let
  private = import ../private.nix;
in
{
  programs.git = {
    enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        email = private.gitEmail;
        name = private.gitUsername;
      };
    };

    lfs.enable = true;
  };
}
