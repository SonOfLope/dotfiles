{ pkgs, ... }:

let

    extensions = (with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      vscodevim.vim
      golang.go
      ms-kubernetes-tools.vscode-kubernetes-tools
      github.vscode-pull-request-github
      file-icons.file-icons
      ms-python.python
      ms-vsliveshare.vsliveshare
      james-yu.latex-workshop
      jnoortheen.nix-ide
      redhat.vscode-yaml
      tomoki1207.pdf
      donjayamanne.githistory
      eamodio.gitlens
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
  }];
in {
  programs.vscode = {
       enable = true;
       package = pkgs.vscodium;
       extensions = extensions;
  }; 
}  
