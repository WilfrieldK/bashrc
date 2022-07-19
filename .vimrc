" Highlight les recherches
set hlsearch
" Pas de sensibilite a la casse
set ic
" Si la recherche contient une MaJ => sensible (recherche intelligente)
set smartcase
" Afficher les numeros de ligne
set nu
" mapleader
let g:mapleader=","
" Encodage par defaut
set encoding=utf-8
" Cherche pas si tu mets pas ca c'est le bordel les remap
set nocompatible
" Activation de la coloration syntaxique
syntax on
" Problemes lies au fait que backspace ne fonctionne pas
set backspace=indent,eol,start
" Pas de retour a la ligne au milieu d'un mot en mode wrapped
set linebreak
" scroll 3 lignes autour du curseur
set scrolloff=3

" Tranforme les tab en espaces
set expandtab
set tabstop=4
set shiftwidth=4

" bufline
set showtabline=1

" Utilisation de la souris
" i = insert
" a = all
" v = verbose
set mouse=i

" Nb de couleurs du terminal
set t_Co=256
" Type de replis
set foldmethod=syntax
" Taille de la barre de statut du bas
set laststatus=2
" Pouvoir changer de buffer sans le sauvegarder
set hidden

" Theme
colorscheme torte

" Gestion de la souris avec screen
set ttymouse=xterm2

" Activer/Desactiver paste
set pastetoggle=<F2>

" Taille maximale d'une ligne avant le passage automatique sur la ligne du dessous
" C'est un peu chiant quand meme quand ca t'envoie a la ligne et que tu relis pas ton code
" set tw=120

" Remap des fleches multidirectionnelles
inoremap <silent> <down> <c-o>gj
inoremap <silent> <up> <c-o>gk
nnoremap <silent> <down> gj
nnoremap <silent> <up> gk

" Deplacement a travers les buffers ouverts
nnoremap <silent> <C-Left> :bprev<CR>
nnoremap <silent> <C-Right> :bnext<CR>

" Deplacement dans les splits ouverts
noremap <silent> <S-Up> :wincmd k<CR>
noremap <silent> <S-Down> :wincmd j<CR>
noremap <silent> <S-Left> :wincmd h<CR>
noremap <silent> <S-Right> :wincmd l<CR>

" Ouvrir un nouveau vsplit avec Ctrl+s
noremap <silent> <C-s> :vsp<CR>

" Supprimer un buffer sans peter le split
nnoremap <silent> <C-c> :bp\|bd #<CR>
"
" Remap close all fold
nnoremap <silent> zC zM
" Remap open all fold
nnoremap <silent> zO zR

" Autocomplete des chemins systeme avec Tab-Tab
" inoremap <Tab><Tab> <C-X><C-F>

" Toogle hlsearch (mouais ca desactive le hlsearch mais faut reactiver apres ...)
" nnoremap <silent> <F3> :set invhlsearch<CR>

" :Wroot save file has root
command! Wroot :w !sudo tee %

" Desactivation du hlsearch en entree et sortie d'insertion
autocmd InsertEnter * :let @/=""
autocmd InsertLeave * :let @/=""

" Compilation rapide des fichiers c et cpp
if "cpp" == expand('%:e') || "c" == expand('%:e')
    noremap <F7> :! gcc % -o %<<CR>
    noremap <F8> :! ./%<<CR>
endif

" Auto commande
if has("autocmd")
  " Templates
  augroup templates
    autocmd BufNewFile *.py 0r $CONFIG_PATH/std/.vim/templates/skeleton.py
    autocmd BufNewFile *.sh 0r $CONFIG_PATH/std/.vim/templates/skeleton.sh
  augroup END
  " Reconfiguration en fonction des extensions
  augroup autodetect
    autocmd BufNewFile,BufRead .py
        \ set filetype=python
        \ set foldmethod=indent
        \ set foldlevel=99
    autocmd BufNewFile,BufRead .sh
        \ set filetype=sh
  augroup END
endif

"
" Preparation du package manager
"

" Emplacement de ma config
" Chargement de Vundle (package manager)
let s:config_path = $CONFIG_PATH
let &runtimepath.=','.s:config_path.'/std/.vim/bundle/Vundle.vim'

" Requirements
filetype off

" Chargement des plugins via Vundle
call vundle#begin(s:config_path.'/vim_plugins')

" La liste des plugins est geree a part pour qu'on puisse ajouter localement un ou plusieurs plugins
source $CONFIG_PATH/vim_plugins/plugins.list

" Chargement d'une configuration locale de vim si elle existe
if filereadable($CONFIG_PATH."/local/.vimrc")
    source $CONFIG_PATH/local/.vimrc
endif

call vundle#end()
filetype plugin indent on

"
" Configuration des plugins
"

" Airline
" Afficher la barre du haut meme quand il n'y a qu'un onglet
let g:airline#extensions#tabline#enabled = 1
" Theme
let g:airline_theme='wombat'
" Modification des separateurs
let g:airline_left_sep='▶'
let g:airline_right_sep='◀'
" Fugitive (git)
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
" WhiteSpace
" let b:airline_whitespace_checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let b:airline_whitespace_checks = [ 'indent', 'trailing', 'mixed-indent-file' ]
" Scrollbar
let g:airline#extensions#scrollbar#enabled = 1

" Dirvish
map <silent> <C-e> :Dirvish<CR>
let g:dirvish_relative_paths = 1

" Tagbar
nnoremap <F4> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
