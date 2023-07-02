syntax on

set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=4

set nocompatible
filetype off

" 设置运行时路径并启用 Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 在此处添加其他插件配置

" YouCompleteMe 插件配置
Plugin 'Valloric/YouCompleteMe'
" NERDTree 插件
Plugin 'preservim/nerdtree'
" 自动格式化插件
Plugin 'rhysd/vim-clang-format'
" vim note的依赖
Plugin 'xolox/vim-misc'
" vim note 插件
Plugin 'xolox/vim-notes'

" 在此处添加其他插件配置

call vundle#end()
filetype plugin indent on

" 在新建文件时自动插入文件头部注释
autocmd BufNewFile * call InsertFileHeader()

let g:my_name= $USER_NAME

function! InsertFileHeader()
    " 设置文件头部注释模板
	let filename = expand('%')
	if filename =~ '\.h$'
		let file_header = [
			\ "/*",
			\ " File Name: " . expand('%'), 
			\ " Author: " . g:my_name,
			\ " Email: " . g:my_name . "@croot.com",
			\ " Created: " . strftime("%Y-%m-%d"),
			\ " Last Modified: " . strftime("%Y-%m-%d"),
			\ "*/",
			\ "#pragma once",
			\ "namespace croot {",
			\ "namespace lltg {",
			\ "}  // namespace lltg",
			\ "}  // namespace croot",
		\ ]
        " 在当前行插入注释模板
        call append(0, file_header)
	elseif filename =~ '\.cc$'
		let file_header = [
			\ "/*",
			\ " File Name: " . expand('%'), 
			\ " Author: " . g:my_name,
			\ " Email: " . g:my_name . "@croot.com",
			\ " Created: " . strftime("%Y-%m-%d"),
			\ " Last Modified: " . strftime("%Y-%m-%d"),
			\ "*/",
			\ "using namespace croot::lltg;",
		\ ]
        " 在当前行插入注释模板
        call append(0, file_header)
	endif

    " 将光标移动到第一个非空行
    normal! gg/^//
endfunction


set autoindent
set smartindent

let g:mapleader = " "


" YCM 跳转到定义位置
nnoremap <leader>d :YcmCompleter GoToDefinition<CR>

" YCM 跳转到声明位置
nnoremap <leader>l :YcmCompleter GoToDeclaration<CR>

" YCM 跳转到引用位置
nnoremap <leader>r :YcmCompleter GoToReferences<CR>

" YCM 运行语义补全
"nnoremap <leader>c :YcmCompleter RunSemanticCompletion<CR>

" YCM Fix 
nnoremap <leader>f :YcmCompleter FixIt<CR>

" 加载ycm conf 不再询问
let g:ycm_confirm_extra_conf=0

" 自定义命令A 切换cc和h文件
command A call ToggleHeaderSource()

function! ToggleHeaderSource()
    let filename = expand('%')
    if filename =~# '\.h$'
        let cc_file = substitute(filename, '\.h$', '.cc', '')
        if filereadable(cc_file)
            exec 'edit ' . cc_file
        else
            echo "No corresponding .cc file found."
        endif
    elseif filename =~# '\.cc$'
        let h_file = substitute(filename, '\.cc$', '.h', '')
        if filereadable(h_file)
            exec 'edit ' . h_file
        else
            echo "No corresponding .h file found."
        endif
    else
        echo "Not a .h or .cc file."
    endif
endfunction

" 搜索高量
set hlsearch
" 展示行号 
set relativenumber 
set number

" 左下角展示文件名字
set laststatus=2
set statusline=%F

" NERDTree 在ccp文件中自动启动 
let filename = expand('%')
if filename =~ '\.cc$'
    autocmd VimEnter * NERDTree
endif
if filename =~ '\.h$'
    autocmd VimEnter * NERDTree
endif

" NERDTree 选中文件后光标保持在左侧
let g:NERDTreeKeepCursorPosition = 0
" 边栏宽度设置为20%
let g:NERDTreeWinSize=20

" 关闭窗口后 NERDTREE 自动退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" log相关设置
"set verbosefile=/tmp/vim.log
"set verbose=1


" 代码格式配置
"let g:clang_format#style_options = {
"    \ 'IndentWidth': 4,
"    \ 'UseTab': 0,
"    \ 'BasedOnStyle': 'Google'
"    \ }

let g:clang_format#style = 'Google'
let g:clang_format#sort_includes = 1
let g:clang_format#assume_filename = 1

" 自定义快捷键
nnoremap <F8> :ClangFormat<CR>

" 保存时自动格式化
"autocmd BufWritePre *.cc,*.h :ClangFormat





