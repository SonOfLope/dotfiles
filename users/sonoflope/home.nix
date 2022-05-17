{ config, lib, pkgs, stdenv, ... }:

let 

  defaultPkgs = with pkgs; [  
    anydesk
    asciinema
    brave
    cachix
    caffeine-ng
    cmatrix
    dbeaver
    dconf2nix
    discord
    dmenu
    dmidecode
    docker-compose
    dotnet-runtime
    drawio
    fd
    freerdp
    gimp
    gnumake
    gnupg
    google-cloud-sdk
    gradle
    jetbrains.idea-community
    keepassxc
    killall
    libreoffice
    maven
    ncdu
    neofetch
    ngrok-2
    noisetorch
    okular
    openconnect
    pciutils usbutils
    pinentry_qt
    plantuml
    playerctl
    qalculate-gtk
    rclone
    sshfs
    terraform
    thefuck
    unzip
    vlc
    vmware-horizon-client
    wirelesstools
    wireshark
    xclip
    xorg.xhost
  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt     # git files encryption
    hub           # github command-line client
    tig           # diff and commit view
  ];

  gnomePkgs = with pkgs.gnome3; [
    eog            # image viewer
    evince         # pdf reader
    gnome-calendar # calendar
    nautilus       # file manager
  ];

  polybarPkgs = with pkgs; [
    font-awesome          # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  xmonadPkgs = with pkgs; [
    networkmanager_dmenu   # networkmanager on dmenu
    networkmanagerapplet   # networkmanager applet
    nitrogen               # wallpaper manager
    xcape                  # keymaps modifier
    xorg.xkbcomp           # keymaps modifier
    xorg.xmodmap           # keymaps modifier
    xorg.xrandr            # display manager (X Resize and Rotate protocol)
  ];

in 
{
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [ (import ./overlays/beauty-line)];

  imports = (import ./programs) ++ (import ./services) ++ [(import ./themes)];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sonoflope";
  home.homeDirectory = "/home/sonoflope";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  systemd.user.startServices = "sd-switch";

  news.display = "silent";

  services = {

    caffeine.enable = true;

    # k8s setup
    lorri.enable = true;

    flameshot.enable = true;
  };

  home = {
    packages = defaultPkgs ++ polybarPkgs ++ xmonadPkgs ++ gitPkgs ++ gnomePkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "vim";
      TERMINAL="kitty";
    };
  };
  
  # dev environnement
  programs = {
    go.enable = true;
    java.enable = true;
    
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "GitHub";
        italic-text = "always";
      };
    };
    
    gpg.enable = true;

    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };

    jq.enable = true;

    obs-studio = {
      enable = true;
      plugins = [];
    };

    ssh.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [];
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      commentary
      fastfold
      fugitive
      fzf-vim
      goyo
      limelight-vim
      repeat
      # seoul256
      surround
      tabular
      undotree
      vim-airline
      vim-airline-themes
      vim-bufferline
      vim-elixir
      vim-obsession
      vim-ragtag
      # vim-peekaboo
      # Consider using fugitive's `:Gdiff :0` instead
      # see https://stackoverflow.com/questions/15369499/how-can-i-view-git-diff-for-any-commit-using-vim-fugitive
      # vim-signify
      vim-unimpaired
      vim-vinegar
      wombat256
      gruvbox-community
      # yankring TODO: doesn't work and there is an update from 2019 that is not is vimPlugins yet
      # YouCompleteMe REMINDER: never use it again; eats more RAM than chrome
    ];
    # TODO read it from a .vimrc instead
    extraConfig = ''
      " colorscheme wombat256mod
      set background=dark
      let g:gruvbox_contrast_dark = 'hard'
      colorscheme gruvbox
      set encoding=utf-8
      set noequalalways
      set foldlevelstart=99
      set foldtext=substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=',''\'','g')
      set modeline
      set autoindent expandtab smarttab
      set shiftround
      set nocompatible
      set cursorline
      " set list
      set number
      set relativenumber
      set incsearch hlsearch
      " set showcmd
      set laststatus=2
      set backspace=indent,eol,start
      set wildmenu
      set autoread
      set history=5000
      set noswapfile
      set fillchars="vert:|,fold: "
      set showmatch
      set matchtime=2
      set hidden
      set listchars=tab:⇥\ ,trail:␣,extends:⇉,precedes:⇇,nbsp:·,eol:¬
      set ignorecase
      set smartcase
      autocmd FileType erl setlocal ts=4 sw=4 sts=4 et
      " https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
      if !isdirectory($HOME."/.vim")
          call mkdir($HOME."/.vim", "", 0770)
      endif
      if !isdirectory($HOME."/.vim/undo-dir")
          call mkdir($HOME."/.vim/undo-dir", "", 0700)
      endif
      set undodir=~/.vim/undo-dir
      set undofile
      " TODO airline-ify
      " set statusline=   " clear the statusline for when vimrc is reloaded
      " set statusline+=[%-6{fugitive#head()}]
      " set statusline+=%f\                          " file name
      " set statusline+=[%2{strlen(&ft)?&ft:'none'},  " filetype
      " set statusline+=%2{strlen(&fenc)?&fenc:&enc}, " encoding
      " set statusline+=%2{&fileformat}]              " file format
      " set statusline+=[%L\,r%l,c%c]            " [total lines,row,column]
      " set statusline+=[b%n,                      " buffer number
      " " window number, alternate file in which window (-1 = not visible)
      " set statusline+=w%{winnr()}]
      " set statusline+=%h%m%r%w                     " flags
      " === Scripts   {{{1
      " ===========
      " _$ - Strip trailing whitespace {{{2
      nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>
      function! Preserve(command)
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        execute a:command
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
      endfunction
      " MakeDirsAndSaveFile (:M) {{{2
      " Created to be able to save a file opened with :edit where the path
      " contains directories that do not exist yet. This script will create
      " them and if they exist, `mkdir` will run without throwing an error.
      command! M :call MakeDirsAndSaveFile()
      " https://stackoverflow.com/questions/12625091/how-to-understand-this-vim-script
      " or
      " :h eval.txt
      " :h :fu
      function! MakeDirsAndSaveFile()
        " https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently
        :silent !mkdir -p %:h
        :redraw!
        " ----------------------------------------------------------------------------------
        :write
      endfunction
      " === Key mappings    {{{1
      " ================
      " Auto-close mappings {{{2
      " https://stackoverflow.com/a/34992101/1498178
      inoremap <leader>" ""<left>
      inoremap ` ``<left>
      inoremap <leader>' ''\''<left>
      inoremap <leader>( ()<left>
      inoremap <leader>[ []<left>
      inoremap <leader>{ {}<left>
      inoremap <leader>{<CR> {<CR>}<ESC>O
      autocmd FileType nix inoremap {<CR> {<CR>};<ESC>O
      " 44 instead of <C-^> {{{2
      nnoremap 44 <C-^>
      " 99 instead of <C-w>w {{{2
      nnoremap 99 <C-w>w
      " \yy - copy entire buffer to system clipboard {{{2
      nnoremap <leader>yy :%yank +<CR>
      " \ys - copy entire buffer to * {{{2
      nnoremap <leader>ys :%yank *<CR>
      " vil - inner line {{{2
      nnoremap vil ^vg_
      " <Leader>l - change working dir for current window only {{{2
      nnoremap <Leader>l :lcd %:p:h<CR>:pwd<CR>
      " <Space> instead of 'za' (unfold the actual fold) {{{2
      nnoremap <Space> za
      " <Leader>J Like gJ, but always remove spaces {{{2
      fun! JoinSpaceless()
          execute 'normal gJ'
          " Character under cursor is whitespace?
          if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
              " When remove it!
              execute 'normal dw'
          endif
      endfun
      nnoremap <Leader>J :call JoinSpaceless()<CR>
      " in NORMAL mode CTRL-j splits line at cursor {{{2
      nnoremap <NL> i<CR><ESC>
      " <C-p> and <C-n> instead of <Up>,<Down> on command line {{{2
      cnoremap <C-p> <Up>
      cnoremap <C-n> <Down>
      " {visual}* search {{{2
      xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
      xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
      function! s:VSetSearch()
        let temp = @s
        norm! gv"sy
        let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
        let @s = temp
      endfunction
      "gp - http://vim.wikia.com/wiki/Selecting_your_pasted_text
      nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
      " === Plugin configuration   {{{1
      " ========================
      " peekaboo {{{2
      let g:peekaboo_window = 'belowright 30new'
      " airline {{{2
      let g:airline_theme='distinguished'
      " vim-airline was overwriting vim-bufferline settings
      " but this prevents it. See bufferline settings below.
      let g:airline#extensions#bufferline#overwrite_variables = 0
      " fzf-vim {{{2
      nnoremap <leader><C-n> :History:<CR>
      nnoremap <leader><C-m> :History/<CR>
      nnoremap <leader><C-o> :Files<CR>
      nnoremap <leader><C-l> :Lines<CR>
      nnoremap <leader><C-r> :BLines<CR>
      nnoremap <leader><C-k> :Buffers<CR>
      nnoremap <leader><C-j> :Ag<CR>
      nnoremap <leader><C-w> :Windows<CR>
      nnoremap <leader><C-g> :Commits<CR>
      nnoremap <leader><C-p> :BCommits<CR>
      nnoremap <leader><C-h> :History<CR>
      nnoremap <leader><C-u> :Marks<CR>
      nnoremap <leader><C-i> :BD<CR>
      imap <c-x><c-l> <plug>(fzf-complete-line)
      " https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
      " (modification: added bang (!) at the end of `bwipeout`
      function! s:list_buffers()
        redir => list
        silent ls
        redir END
        return split(list, "\n")
      endfunction
      function! s:delete_buffers(lines)
        execute 'bwipeout!' join(map(a:lines, {_, line -> split(line)[0]}))
      endfunction
      command! BD call fzf#run(fzf#wrap({
        \ 'source': s:list_buffers(),
        \ 'sink*': { lines -> s:delete_buffers(lines) },
        \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
      \ }))
      " bufferline {{{2
      let g:bufferline_active_buffer_left = '['
      let g:bufferline_active_buffer_right = ']'
      let g:bufferline_fname_mod = ':.'
      let g:bufferline_pathshorten = 1
      let g:bufferline_rotate = 1
      " UndoTree {{{2
      let g:undotree_ShortIndicators = 1
      let g:undotree_CustomUndotreeCmd = 'vertical 32 new'
      let g:undotree_CustomDiffpanelCmd= 'belowright 12 new'
      " Goyo {{{2
      let g:goyo_width = 104
      function! s:goyo_enter()
        Limelight0.4
        UndotreeToggle
#d470cd        " ...
      endfunction
      function! s:goyo_leave()
        Limelight!
        UndotreeToggle
        " ...
      endfunction
      autocmd! User GoyoEnter nested call <SID>goyo_enter()
      autocmd! User GoyoLeave nested call <SID>goyo_leave()
      " FastFold {{{2
      let g:markdown_folding = 1
      " netrw {{{2
      let g:netrw_winsize   = 30
      let g:netrw_liststyle = 3
    '';
  };

  programs.vscode = {
       enable = true;
       package = pkgs.vscodium;
       extensions = with pkgs.vscode-extensions; [
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
       ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "web-search" ];
      theme = "jonathan";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.1";
          sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
        };
      }
    ];
  };
}
