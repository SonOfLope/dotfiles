{ pkgs, ... }:

let

    extensions = (with pkgs.vscode-extensions; [
      bbenoist.nix
      donjayamanne.githistory
      dracula-theme.theme-dracula
      eamodio.gitlens
      file-icons.file-icons
      github.vscode-pull-request-github
      golang.go
      james-yu.latex-workshop
      jnoortheen.nix-ide
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.python
      ms-vsliveshare.vsliveshare
      redhat.vscode-yaml
      tomoki1207.pdf
      vscodevim.vim
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
      {
        name = "code-runner";
        publisher = "formulahendry";
        version = "0.6.33";
        sha256 = "166ia73vrcl5c9hm4q1a73qdn56m0jc7flfsk5p5q41na9f10lb0";
      }
      {
        name = "html-snippets";
        publisher = "abusaidm";
        version = "0.2.1";
        sha256 = "1ryqwyhgbwiqxqdh08bfplylkhvcfx17n6l9dyf0xf7fraa3b6ws";
      }
      {
        name = "live-server";
        publisher = "ms-vscode";
        version = "0.2.12";
        sha256 = "0i5hc1l91jnl96whdpx21bsfivw45gkzif2zj19rczy5xvr77cz2";
      }
    ];
in {
  programs.vscode = {
       enable = true;
       package = pkgs.vscodium;
       extensions = extensions;
  }; 
}  
