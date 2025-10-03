{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    shellAliases = {
      ls = "ls -Ahl";
    };

    interactiveShellInit = ''
      # zoxide
      eval "$(zoxide init zsh)"

      cd(){ if [ $# -eq 0 ]; then z; else z "$@" || builtin cd "$@"; fi }
    '';
  };

  users.users.luuk.shell = pkgs.zsh;

  users.users.luuk.packages = with pkgs; [ zoxide ];
}

