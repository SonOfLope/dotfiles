{ config, pkgs, ... }:

{
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
 
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSshSupport = true;
  };

  
  services.caffeine.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
 
  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    brave
    git-crypt
    gnupg
    neofetch
    pinentry_qt
    rclone
    okular
    obs-studio
    sshfs
    caffeine-ng
    docker-compose
    plasma5Packages.kmail 
    plasma5Packages.kmail-account-wizard
    anydesk
    plasma5Packages.kmailtransport
    keepassxc
    thefuck
    cmatrix
    gimp
    unzip
    dbeaver
    terraform
    google-cloud-sdk
    xclip
    dmidecode
    pciutils usbutils
    wirelesstools
    networkmanager
    discord
    dotnet-runtime
    vmware-horizon-client
    openconnect
    libreoffice
    wireshark
    gnumake
    maven
    gradle
    plantuml
    vlc
    xorg.xhost
    jetbrains.idea-community
    polybarFull
    noisetorch
    freerdp
    qalculate-gtk
  ];

  
  # dev environnement
  programs.go.enable = true;
  programs.java.enable = true;

  # k8s setup
  services.lorri.enable = true;
  programs.direnv.enable = true;


  programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
      italic-text = "always";
    };
  };

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
  
  home.sessionVariables = {
    TERMINAL="kitty";
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_size = "11.0";
      font_family      = "FiraCode Nerd Font";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      background = "#282a36";
      foreground = "#f8f8f2";
      selection_foreground ="#ffffff";
      selection_background = "#44475a";
      cursor = "#f8f8f2";
      cursor_text_color = "background";
      color0  = "#21222c";
      color1  = "#ff5555";
      color2  = "#50fa7b";
      color3  = "#f1fa8c";
      color4  = "#bd93f9";
      color5  = "#ff79c6";
      color6  = "#8be9fd";
      color7  = "#f8f8f2";
      color8  = "#6272a4";
      color9  = "#ff6e6e";
      color10 = "#50fa7b";
      color11 = "#ffffa5";
      color12 = "#d6acff";
      color13 = "#ff92df";
      color14 = "#a4ffff";
      color15 = "#ffffff";
      # Tab bar colors
      active_tab_foreground = "#282a36";
      active_tab_background = "#f8f8f2";
      inactive_tab_foreground = "#282a36";
      inactive_tab_background = "#6272a4";
      mark1_foreground = "#282a36";
      mark1_background = "#ff5555";
      cursor_beam_thickness = "1.5";
      cursor_underline_thickness = "2.0";
      cursor_blink_interval = "-1";
      scrollback_lines = "2000";
      mouse_hide_wait = "2.0";
      detect_urls = true;
      copy_on_select = false;
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "beam";
      pointer_shape_when_dragging = "beam";
      enable_audio_bell = false;
      remember_window_size =  false;
      initial_window_width = "940";
      initial_window_height = "520";
      window_border_width = "0.1";
      draw_minimal_borders = true;
      window_padding_width = "2";
      hide_window_decorations = true;
      background_opacity = "0.90";
      dim_opacity = "0.80";
    };
  };  
}
