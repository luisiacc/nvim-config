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
    filetype indent on
    filetype plugin off
    set smartindent
    set autoindent

    source ~/.config/nvim/sets.vim
    source ~/.config/nvim/plugins.vim
    source ~/.config/nvim/lua.vim
    source ~/.config/nvim/commands.vim
    source ~/.config/nvim/globals.vim
    source ~/.config/nvim/coc.vim
    source ~/.config/nvim/mappings.vim
    source ~/.config/nvim/telescope.vim
    source ~/.config/nvim/windows.vim
    source ~/.config/nvim/schemes.vim

    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()

endif

