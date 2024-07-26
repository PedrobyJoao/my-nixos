let
    private = import ../private.nix;
in
{
    programs.git = {
        enable = true;
        userName = private.gitUsername;
        userEmail = private.gitEmail;
    };
}
