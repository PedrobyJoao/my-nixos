{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;

    syntaxHighlighting.enable = true;

    history = {
      ignoreAllDups = true;
      path = "${config.xdg.dataHome}/zsh/history";
      save = 10000;
      size = 10000;
      share = true;
    };

    historySubstringSearch = {
      enable = true;
    };

  };
}
