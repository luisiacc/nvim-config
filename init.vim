if exists('g:vscode')
    source ~/config/nvim/vscode.vim
    function! s:showCommands()
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    endfunction

    xnoremap <silent> <C-P> <Cmd>call <SID>showCommands()<CR>
else
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath

    syntax off
    filetype indent off
    filetype plugin off
    " set smartindent
    " set autoindent

    source ~/.config/nvim/plugins.vim
    source ~/.config/nvim/sets.vim
    source ~/.config/nvim/lua.vim
    source ~/.config/nvim/commands.vim
    source ~/.config/nvim/globals.vim
    source ~/.config/nvim/coc.vim
    source ~/.config/nvim/coc-explorer.vim
    " source ~/.config/nvim/lsp-config.vim
    " luafile ~/.config/nvim/compe.lua
    " luafile ~/.config/nvim/galaxyline.lua
    " source ~/.config/nvim/mpbtl.vim
    source ~/.config/nvim/lua-format.vim
    source ~/.config/nvim/mappings.vim
    source ~/.config/nvim/telescope.vim
    source ~/.config/nvim/windows.vim
    source ~/.config/nvim/schemes.vim

    " set foldmethod=expr
    " set foldexpr=nvim_treesitter#foldexpr()

    set guifont=Hack\ NF:h15:w500
    set linespace=8
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

    let g:neovide_transparency=0.95
    let g:neovide_cursor_animation_length=0.08
endif

