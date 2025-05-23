let
  private = import ../private.nix;
in
{
  programs.git = {
    enable = true;
    userName = private.gitUsername;
    userEmail = private.gitEmail;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };

    lfs.enable = true;

    delta = {
      enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
  };
}
