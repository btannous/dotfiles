" git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
packadd minpac

call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('vim-jp/syntax-vim-ex')
call minpac#add('morhetz/gruvbox')
call minpac#add('tpope/vim-sensible')

" Gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_tabline = '1'

" Real colors
set termguicolors
autocmd vimenter * colorscheme gruvbox
