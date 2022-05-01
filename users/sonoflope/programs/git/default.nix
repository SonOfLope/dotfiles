{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "vim";
      pager  = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool          = "vim_mergetool";
    };

    pull.rebase = false;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
      "https://gitlab.com/".insteadOf = "gl:";
      "ssh://git@gitlab.com".pushInsteadOf = "gl:";
    };
  };

  rg = "${pkgs.ripgrep}/bin/rg";
in
{
  programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;

      userName = "SonOfLope";
      userEmail = "jonathanlopez@hotmail.ca";
      
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "GitHub";
        };
      };

      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        lo = "log --pretty=format:\"%C(yellow)%h%Creset %s%n%C(magenta)%C(bold)%an%Creset %ar\" --graph";
        van = "log --pretty=format:'%C(yellow)%h%Creset %ad %C(magenta)%C(bold)%cn%Creset %s %C(auto)%d%C(reset)' --graph --date=format:%Y/%m/%d_%H%M";
        vn = "log --pretty=format:'%C(yellow)%h%Creset %ad %s %C(auto)%d%C(reset)' --graph --date=format:%Y/%m/%d_%H%M";
        v = "log --graph --oneline --decorate";
        vo = "log --graph --decorate";
      };
    };

  
}
