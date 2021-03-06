" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================
" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif
" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:islinux

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        " set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件,具体用法参考 :h vundle 帮助
" Vundle工具安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 "git for window",可查阅网上资料

set nocompatible                                      "禁用 Vi 兼容模式
filetype off                                          "禁用文件类型侦测

if g:islinux
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim
    call vundle#rc('$VIM/vimfiles/bundle/Vundle/Vundle.vim')
endif

" 使用Vundle来管理插件,这个必须要有.
Plugin 'VundleVim/Vundle.vim'
" 以下为要安装或更新的插件,不同仓库都有(具体书写规范请参考帮助)
" Bundle 'jiangmiao/auto-pairs'
" Bundle 'ccvext.vim'
" Bundle 'ctrlpvim/ctrlp.vim'
" Bundle 'mattn/emmet-vim'
" Bundle 'vim-javacompleteex'
" Bundle 'Shougo/neocomplcache.vim'
" Bundle 'OmniCppComplete'
" Bundle 'zenorocha/dracula-theme'
" Bundle 'msanders/snipmate.vim'
" Bundle 'tpope/vim-surround'
" Bundle 'TxtBrowser'
" Bundle 'Mark--Karkat'
" Bundle 'winmanager'
" Bundle 'wesleyche/SrcExpl'
"
Bundle 'ZoomWin'
Bundle 'a.vim'
Bundle 'c.vim'
Bundle 'taglist.vim'
Bundle 'std_c.zip'
Bundle 'majutsushi/tagbar'
" Bundle 'cSyntaxAfter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
Bundle 'repeat.vim'
Bundle 'Align'
Bundle 'Yggdroot/indentLine'
Bundle 'bufexplorer.zip'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/ListToggle'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'DoxygenToolkit.vim'

Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_to = 'default'
let g:session_verbose_messages = 0

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后,软件与程序源码、文件路径不能有中文,否则报错
set encoding=utf-8                                    "设置gvim内部编码,默认不更改
set fileencoding=utf-8                                "设置当前文件编码,可以更改,如：gbk(同cp936)
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式,默认 ffs=dos,unix
set fileformat=unix                                   "设置新(当前)文件的<EOL>格式,可以更改,如：dos(windows系统常用)
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度,可以更改,如：宽度为2
set shiftwidth=4                                      "换行时自动缩进宽度,可更改(宽度同tabstop)
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度
set hlsearch                                          "高亮搜索
set incsearch                                         "在输入要搜索的文字时,实时匹配
set foldlevel=0
set foldmethod=syntax                                 "manual, ident, expr syntax, diff, marker
set nofoldenable
" 常规模式下用空格键来开关光标行所在折叠(注：zR 展开所有折叠,zM 关闭所有折叠)
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 当文件在外部被修改,自动更新该文件
set autoread
" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>
set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符,不使用 'ignorecase' 选项,只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>
" 启用每行超过80列的字符提示(字体变蓝并加下划线),不启用就注释掉
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
set colorcolumn=81
set textwidth=80
" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set relativenumber
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2,默认为1
set cursorline                                        "突出显示当前行
set guifont=Monaco:h11 "YaHei_Consolas_Hybrid:h10     "设置字体:字号(字体名称空格用下划线代替)
set wrap                                              "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面
set linebreak       " wrap not break english word 
set showcmd         " show current command on status bar
set showmode        " show current mode on command line

" 设置 gVim 窗口初始位置及大小
if g:isGUI
    " au GUIEnter * simalt ~x                           "窗口启动时自动最大化
    " winpos 100 10                                     "指定窗口出现的位置,坐标原点在屏幕左上角
    " set lines=38 columns=120                          "指定窗口大小,lines为高度,columns为宽度
    colorscheme solarized 
    " colorscheme Tomorrow-Night-Eighties               "Gvim配色方案
    " 显示/隐藏菜单栏、工具栏、滚动条,可用 Ctrl + F11 切换
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
else 
    colorscheme solarized      "Tomorrow-Night-Eighties
endif

" -----------------------------------------------------------------------------
"  < 编译、连接、运行配置 (目前只配置了C、C++、Java语言)>
" -----------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
nmap <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
nmap <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
nmap <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Class_Extension = '.class'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:JavaFlags = 'javac\ %'

func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        let class_Name = expand("%:p:t:r").s:Class_Extension
        if !filereadable(class) || (filereadable(class) && (getftime(class) < getftime(Sou)))
            redraw!
            exe ":setlocal makeprg=".s:JavaFlags
            echohl WarningMsg | echo " compiling..."
            silent make
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""class_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    elseif expand("%:e") == "java"
        return
    endif
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        if getftime(class) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!java %<"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c 'java %<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; java %<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc


" -----------------------------------------------------------------------------
"  < 在浏览器中预览 Html 或 PHP 文件 >
" -----------------------------------------------------------------------------
" 修改前请先通读此模块,明白了再改以避免错误
" F5 加浏览器名称缩写调用浏览器预览,启用前先确定有安装相应浏览器,并在下面的配置好其安装目录
if g:iswindows
    "以下为只支持Windows系统的浏览器
    " 调用系统IE浏览器预览,如果已卸载可将其注释
    nmap <F5>ie :call ViewInBrowser("ie")<cr>
    imap <F5>ie <ESC>:call ViewInBrowser("ie")<cr>
    " 调用IETester(IE测试工具)预览,如果有安装可取消注释
    " nmap <F5>ie6 :call ViewInBrowser("ie6")<cr>
    " imap <F5>ie6 <ESC>:call ViewInBrowser("ie6")<cr>
    " nmap <F5>ie7 :call ViewInBrowser("ie7")<cr>
    " imap <F5>ie7 <ESC>:call ViewInBrowser("ie7")<cr>
    " nmap <F5>ie8 :call ViewInBrowser("ie8")<cr>
    " imap <F5>ie8 <ESC>:call ViewInBrowser("ie8")<cr>
    " nmap <F5>ie9 :call ViewInBrowser("ie9")<cr>
    " imap <F5>ie9 <ESC>:call ViewInBrowser("ie9")<cr>
    " nmap <F5>ie10 :call ViewInBrowser("ie10")<cr>
    " imap <F5>ie10 <ESC>:call ViewInBrowser("ie10")<cr>
    " nmap <F5>iea :call ViewInBrowser("iea")<cr>
    " imap <F5>iea <ESC>:call ViewInBrowser("iea")<cr>
elseif g:islinux
    "以下为只支持Linux系统的浏览器
    "暂未配置,待有时间再弄了
endif

"以下为支持Windows与Linux系统的浏览器

" 调用Firefox浏览器预览,如果有安装可取消注释
" nmap <F5>ff :call ViewInBrowser("ff")<cr>
" imap <F5>ff <ESC>:call ViewInBrowser("ff")<cr>

" 调用Maxthon(遨游)浏览器预览,如果有安装可取消注释
" nmap <F5>ay :call ViewInBrowser("ay")<cr>
" imap <F5>ay <ESC>:call ViewInBrowser("ay")<cr>

" 调用Opera浏览器预览,如果有安装可取消注释
" nmap <F5>op :call ViewInBrowser("op")<cr>
" imap <F5>op <ESC>:call ViewInBrowser("op")<cr>

" 调用Chrome浏览器预览,如果有安装可取消注释
" nmap <F5>cr :call ViewInBrowser("cr")<cr>
" imap <F5>cr <ESC>:call ViewInBrowser("cr")<cr>

" 浏览器调用函数
function! ViewInBrowser(name)
    if expand("%:e") == "php" || expand("%:e") == "html"
        exe ":update"
        if g:iswindows
            "获取要预览的文件路径,并将路径中的'\'替换为'/',同时将路径文字的编码转换为gbk(同cp936)
            let file = iconv(substitute(expand("%:p"), '\', '/', "g"), "utf-8", "gbk")

            "浏览器路径设置,路径中使用'/'斜杠,更改路径请更改双引号里的内容
            "下面只启用了系统IE浏览器,如需启用其它的可将其取消注释(得先安装,并配置好安装路径),也可按需增减
            let SystemIE = "C:/progra~1/intern~1/iexplore.exe"  "系统自带IE目录
            " let IETester = "F:/IETester/IETester.exe"           "IETester程序目录(可按实际更改)
            " let Chrome = "F:/Chrome/Chrome.exe"                 "Chrome程序目录(可按实际更改)
            " let Firefox = "F:/Firefox/Firefox.exe"              "Firefox程序目录(可按实际更改)
            " let Opera = "F:/Opera/opera.exe"                    "Opera程序目录(可按实际更改)
            " let Maxthon = "C:/Progra~2/Maxthon/Bin/Maxthon.exe" "Maxthon程序目录(可按实际更改)

            "本地虚拟服务器设置,我测试的是phpStudy2014,可根据自己的修改,更改路径请更改双引号里的内容
            let htdocs ="F:/phpStudy2014/WWW/"                  "虚拟服务器地址或目录(可按实际更改)
            let url = "localhost"                               "虚拟服务器网址(可按实际更改)
        elseif g:islinux
            "暂时还没有配置,有时间再弄了.
        endif

        "浏览器调用缩写,可根据实际增减,注意,上面浏览器路径中没有定义过的变量(等号右边为变量)不能出现在下面哟(可将其注释或删除)
        let l:browsers = {}                             "定义缩写字典变量,此行不能删除或注释
        " let l:browsers["cr"] = Chrome                   "Chrome浏览器缩写
        " let l:browsers["ff"] = Firefox                  "Firefox浏览器缩写
        " let l:browsers["op"] = Opera                    "Opera浏览器缩写
        " let l:browsers["ay"] = Maxthon                  "遨游浏览器缩写
        let l:browsers["ie"] = SystemIE                 "系统IE浏览器缩写
        " let l:browsers["ie6"] = IETester."-ie6"         "调用IETESTER工具以IE6预览缩写(变量加参数)
        " let l:browsers["ie7"] = IETester."-ie7"         "调用IETESTER工具以IE7预览缩写(变量加参数)
        " let l:browsers["ie8"] = IETester."-ie8"         "调用IETESTER工具以IE8预览缩写(变量加参数)
        " let l:browsers["ie9"] = IETester."-ie9"         "调用IETESTER工具以IE9预览缩写(变量加参数)
        " let l:browsers["ie10"] = IETester."-ie10"       "调用IETESTER工具以IE10预览缩写(变量加参数)
        " let l:browsers["iea"] = IETester."-al"          "调用IETESTER工具以支持的所有IE版本预览缩写(变量加参数)

        if stridx(file, htdocs) == -1   "文件不在本地虚拟服务器目录,则直接预览(但不能解析PHP文件)
           exec ":silent !start ". l:browsers[a:name] ." file://" . file
        else    "文件在本地虚拟服务器目录,则调用本地虚拟服务器解析预览(先启动本地虚拟服务器)
            let file = substitute(file, htdocs, "http://".url."/", "g")    "转换文件路径为虚拟服务器网址路径
            exec ":silent !start ". l:browsers[a:name] file
        endif
    else
        echohl WarningMsg | echo " please choose the correct source file"
    endif
endfunction

" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份,保存成功后删除该备份
set nobackup                                "设置无备份文件
" set noswapfile                            "设置无临时文件
" set vb t_vb=                              "关闭提示音


" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
"  < Align 插件配置 >
" -----------------------------------------------------------------------------
" 一个对齐的插件,用来——排版与对齐代码,功能强大,不过用到的机会不多

" -----------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
" -----------------------------------------------------------------------------
" 用于括号与引号自动补全,不过会与函数原型提示插件echofunc冲突
" 所以我就没有加入echofunc插件

" -----------------------------------------------------------------------------
"  < BufExplorer 插件配置 >
" -----------------------------------------------------------------------------
" 快速轻松的在缓存中切换(相当于另一种多个文件间的切换方式)
" \be 在当前窗口显示缓存列表并打开选定文件
" \bs 水平分割窗口显示缓存列表,并在缓存列表窗口中打开选定文件
" \bv 垂直分割窗口显示缓存列表,并在缓存列表窗口中打开选定文件

" -----------------------------------------------------------------------------
"  < ccvext.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于对指定文件自动生成tags与cscope文件并连接
" 如果是Windows系统, 则生成的文件在源文件所在盘符根目录的.symbs目录下(如: X:\.symbs\)
" 如果是Linux系统, 则生成的文件在~/.symbs/目录下
" 具体用法可参考www.vim.org中此插件的说明
" <Leader>sy 自动生成tags与cscope文件并连接
" <Leader>sc 连接已存在的tags与cscope文件

" -----------------------------------------------------------------------------
"  < cSyntaxAfter 插件配置 >
" -----------------------------------------------------------------------------
" 高亮括号与运算符等
if has("cSyntaxAfter") && (background != "light")
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()
endif

" -----------------------------------------------------------------------------
"  < ctrlp.vim 插件配置 >
" -----------------------------------------------------------------------------
" 一个全路径模糊文件,缓冲区,最近最多使用,... 检索插件；详细帮助见 :h ctrlp
" 常规模式下输入：Ctrl + p 调用插件

" -----------------------------------------------------------------------------
"  < emmet-vim(前身为Zen coding) 插件配置 >
" -----------------------------------------------------------------------------
" HTML/CSS代码快速编写神器,详细帮助见 :h emmet.txt

" -----------------------------------------------------------------------------
"  < indentLine 插件配置 >
" -----------------------------------------------------------------------------
" 用于显示对齐线,与 indent_guides 在显示方式上不同,根据自己喜好选择了
" 在终端上会有屏幕刷新的问题,这个问题能解决有更好了
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>

" 设置Gvim的对齐线样式
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif

" 设置终端对齐线颜色,如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_term = 239

" 设置 GUI 对齐线颜色,如果不喜欢可以将其注释掉采用默认颜色
" let g:indentLine_color_gui = '#A4E57E'

" -----------------------------------------------------------------------------
"  < vim-javacompleteex(也就是 javacomplete 增强版)插件配置 >
" -----------------------------------------------------------------------------
" java 补全插件

" -----------------------------------------------------------------------------
"  < Mark--Karkat(也就是 Mark) 插件配置 >
" -----------------------------------------------------------------------------
" 给不同的单词高亮,表明不同的变量时很有用,详细帮助见 :h mark.txt

" " -----------------------------------------------------------------------------
" "  < MiniBufExplorer 插件配置 >
" " -----------------------------------------------------------------------------
" " 快速浏览和操作Buffer
" " 主要用于同时打开多个文件并相与切换

" " let g:miniBufExplMapWindowNavArrows = 1     "用Ctrl加方向键切换到上下左右的窗口中去
" let g:miniBufExplMapWindowNavVim = 1        "用<C-k,j,h,l>切换到上下左右的窗口中去
" let g:miniBufExplMapCTabSwitchBufs = 1      "功能增强(不过好像只有在Windows中才有用)
" "                                            <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
" "                                            <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开

" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag补全等等,各种,非常好用,速度超快.
let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
" let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
" 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好

" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键,其中的说明是以C/C++为例的,其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行),再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行),再输入则称重复注释
" <Leader>cc 以每行一个// 注释选中行或区域,再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释,选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换(其它语言可能不一样了)
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后,右注释符之前留有空格
" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入'\fe' 调用插件
nmap <Leader>fe :NERDTreeToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config Winmanager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:NERDTree_title='NERD Tree' 
let g:winManagerWindowLayout="NERDTree|TagList"
function! NERDTree_Start()  
    exec 'NERDTree'  
endfunction
function! NERDTree_IsValid()  
    return 1  
endfunction
let NERDTreeMinimalUI=1
let g:AutoOpenWinManager=0
nmap wm :WMToggle<CR>
let g:persistentBehaviour = 0	    "当Vim只剩下winManager窗口时,自动退出Vim

" -----------------------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -----------------------------------------------------------------------------
" 用于C/C++代码补全,这种补全主要针对命名空间、类、结构、共同体等进行补全,详细
" 说明可以参考帮助或网络教程等
" 使用前先执行如下 ctags 命令(本配置中可以直接使用 ccvext 插件来执行以下命令)
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++
" 我使用上面的参数生成标签后,对函数使用跳转时会出现多个选择
" 所以我就将--c++-kinds=+p参数给去掉了,如果大侠有什么其它解决方法希望不要保留呀
"  ----------- ----------- ----------- ----------- ----------- ----------- -----
" ctags-R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px
"       --fields=+aiKSz --extra=+q --exclude=lex.yy.cc --exclude=copy_lex.yy.cc
"命令太长了,折成两行了,可以考虑把命令的各个参数写到文件里去了(具体做法就不谈了).
" 1.-R
" 表示扫描当前目录及所有子目录(递归向下)中的源文件.并不是所有文件ctags都会扫描,
" 如果用户没有特别指明,则ctags根据文件的扩展名来决定是否要扫描该文件——如果ctags
" 可以根据文件的扩展名可以判断出该文件所使用的语言,则ctags会扫描该文件.
" 2.--languages=c++
" 只扫描文件内容判定为c++的文件——即ctags观察文件扩展名,如果扩展名对应c++,则扫描该
" 文件.反之如果某个文件叫aaa.py(python文件),则该文件不会被扫描.
" 3.--langmap=c++:+.inl
" 告知ctags,以inl为扩展名的文件是c++语言写的,在加之上述2中的选项,即要求ctags以
" c++语法扫描以inl为扩展名的文件.
" 4.-h +.inl " 
" 告知ctags,把以inl为扩展名的文件看作是头文件的一种(inl文件中放的是inline函数的定
" 义,本来就是为了被include的).这样ctags在扫描inl文件时,就算里面有static的全局变量,
" ctags在记录时也不会标明说该变量是局限于本文件的(见第一节描述).
" 5.--c++-kinds=+px
" 要求ctags记录c++文件中的函数声明和各种外部和前向声明
" 6.--fields=+aiKSz
"   a   类成员的访问控制信息
"   f   作用域局部于文件 [使能]
"   i   (关于)继承的信息
"   k   使用一个字符表示的标签类型 [使能]
"   K   标签类型的完整名称
"   l   包含该标签的源文件的编程语言类型
"   m   (关于)实现的信息
"   n   标签出现的行号
"   s   标签的范围 [使能]
"   S   函数的指纹 (例如,原型或参数列表)
"   z   在 kind 字段中包含 "kind:" 关键字
"   t   把变量或 typedef 的类型和名字做为 "typeref:" 字段 [使能] (*3)" 
" 7.--extra=+q
" 估计vi是这样使用tags文件的：我们使用vi来定位某个tag时,vi根据我们输入的tag的名字
" 在tags文件中一行行查找,判断每一行tag entry的tag名字(即每行的开头)是否和用户给
" 出的相同,如果相同就认为找到一条记录,最后vi显示所有找到的记录,或者根据这些记录直
" 接跳转到对应文件的特定位置.
" 考虑到ctags记录的内容和方式,出现同名的tag entry是很常见的现象,例如函数声明和函
" 数定义的tag名字是一样的,重载函数的tag名字是一样的等等.vi只是使用tag名字来搜索,
" 还没智能到可以根据函数的signature来选择相应的tag entry.vi只能简单的显示tag entry
" 的内容给user,让user自行选择.
" ctags在记录成员函数时默认是把函数的名字(仅仅是函数的名字,不带任何类名和namespace
" 作为前缀)作为tag的名字的,这样就导致很多不同类但同名的函数所对应的tag entry的名字
" 都是一样的,这样user在vi中使用函数名来定位时就会出现暴多选择,挑选起来十分麻烦.user
" 可能会想在vi中用函数的全路径名来进行定位,但这样做会失败,因为tags文件中没有对应
" 名字的tag entry.要满足用户的这种心思,就要求ctags在记录时针对类的成员多记录一条
" tag entry,该tag entry和已有的tag entry的内容都相同,除了tag的名字不同,该tag entry
" 的名字是类的成员的全路径名(包括了命名空间和类名).这就解释了ctags的--extra=+q
" 这样一条命令行选项.
" 8.--exclude=lex.yy.cc --exclude=copy_lex.yy.cc
" 告知ctags不要扫描名字是这样的文件.还可以控制ctags不要扫描指定目录.
" 9. -f tagfile：指定生成的标签文件名,默认是tags. tagfile指定为 - 的话,输出到标准
" 输出.
"------ ----------- ---------------------------- ----------- -------------------
filetype plugin indent on
"-- omnicppcomplete setting --
" 按下F3自动补全代码,注意该映射语句后不能有其他字符,包括tab；否则按下F3会自动补全
" 一些乱码
" imap <F3> <C-X><C-O>
" 按下F2根据头文件内关键字补全
" imap <F2> <C-X><C-I>
set completeopt=menu,menuone " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
"let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1 

" -----------------------------------------------------------------------------
"  < powerline 插件配置 >
" -----------------------------------------------------------------------------
" 状态栏插件,更好的状态栏效果

" -----------------------------------------------------------------------------
"  < repeat 插件配置 >
" -----------------------------------------------------------------------------
" 主要用"."命令来重复上次插件使用的命令

" -----------------------------------------------------------------------------
"  < snipMate 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全,这种补全是一种对代码中的词与代码块的缩写补全,详细用法可以参
" 考使用说明或网络教程等.不过有时候也会与 supertab 插件在补全时产生冲突,如果大
" 侠有什么其它解决方法希望不要保留呀

" -----------------------------------------------------------------------------
"  < SrcExpl 插件配置 >
" -----------------------------------------------------------------------------
" 增强源代码浏览,其功能就像Windows中的"Source Insight"
" nmap <F3> :SrcExplToggle<CR>                "打开/闭浏览窗口

" -----------------------------------------------------------------------------
"  < std_c 插件配置 >
" -----------------------------------------------------------------------------
" 用于增强C语法高亮
" 启用 // 注视风格
let c_cpp_comments = 0

" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号(包括html标签),缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题,详细帮助见 :h surround.txt

" -----------------------------------------------------------------------------
"  < Syntastic 插件配置 >
" -----------------------------------------------------------------------------
" 用于保存文件时查检语法

" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象

" 常规模式下输入 tb 调用插件,如果有打开 TagList 窗口则先将其关闭
nmap tb :TlistClose<CR>:TagbarToggle<CR>

let g:tagbar_width=30                       "设置窗口宽度
let g:tagbar_left=1                         "在左侧窗口中显示

" -----------------------------------------------------------------------------
"  < TagList 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码, 其功能就像vc中的workpace
" 那里面列出了当前文件中的所有宏,全局变量, 函数名等

" 常规模式下输入 tl 调用插件,如果有打开 Tagbar 窗口则先将其关闭
nmap tl :TagbarClose<CR>:Tlist<CR>

let Tlist_Show_One_File=1                   "只显示当前文件的tags
" let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=30                       "设置窗口宽度
let Tlist_WinHeight=80
" let Tlist_Use_Right_Window=1                "在右侧窗口中显示

" -----------------------------------------------------------------------------
"  < txtbrowser 插件配置 >
" -----------------------------------------------------------------------------
" 用于文本文件生成标签与与语法高亮(调用TagList插件生成标签,如果可以)
au BufRead,BufNewFile *.txt setlocal ft=txt

" -----------------------------------------------------------------------------
"  < ZoomWin 插件配置 >
" -----------------------------------------------------------------------------
" 用于分割窗口的最大化与还原
" 常规模式下按快捷键 <c-w>o 在最大化与还原间切换

" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 安装命令: brew install cscope
" 下面是cscope的常用选项：
" 现在进入代码的根目录然后：cscope -Rbq.这个命令会生成三个文件：
" cscope.out, cscope.in.out, cscope.po.out.其中cscope.out是基本的符号索引,
" 后两个文件是使用"-q"选项生成的,可以加快cscope的索引速度.
" cscope缺省只解析C文件(.c和.h)、lex文件(.l)和yacc文件(.y),虽然它也可以支持C++
" 以及Java,但它在扫描目录时会跳过C++及Java后缀的文件.如果你希望cscope解析C++或
" Java文件,需要把这些文件的名字和路径保存在一个名为cscope.files的文件.
" 当cscope发现在当前目录中存在cscope.files时,就会为cscope.files中列出的所有文件
" 生成索引数据库.
" 一般用如下命令生成包含cpp文件的cscope.files:
" find ./ -type f -name "*.h" -o -type f -name "*.c" -o -type f -name "*.cpp" > cscope.files
" 在cscope.files生成以后,就可以cscope -bq来得到索引(.out)文件了.
" 四、用Ctrl+]的时候还是跳转不到.m文件中定义的函数.
" 用ctags -R 命令生成ctags文件的时候默认的不找.m文件玩的.知道了原因后,解决方法
" 也很简单,上面不是生成了索引库文件cscope.files文件么,另外,ctags 还有一个 -L
" 选项. ctags -L ./cscope.files
" if has("cscope")
"     "设定可以使用 quickfix 窗口来查看 cscope 结果
"     set cscopequickfix=s-,c-,d-,i-,t-,e-
"     "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
"     set cscopetag
"     "如果你想反向搜索顺序设置为1
"     set csto=0
"     cs add ~/Documents/openssl/openssl-1.0.2h/cscope.out
"     cs add ~/Documents/mupdf/cscope.out
"     "if filereadable("~/Documents/openssl/openssl-1.0.2h/cscope.out")
"     "    cs add ~/Documents/openssl/openssl-1.0.2h/cscope.out        "否则添加数据库环境中所指出的
"     "elseif $CSCOPE_DB != ""
"     "    cs add $CSCOPE_DB
"     "endif
"     set cscopeverbose
"     "快捷键设置
"     nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
"     nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
"     nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
"     nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
"     nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
"     nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
"     nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"     nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
" endif

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
" map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
" imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
" map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" set tags+=./tags,~/Documents/mupdf/tags,~/Documents/mupdf/tags_stl,~/Documents/openssl/openssl-1.0.2h/tags;

" -----------------------------------------------------------------------------
"  < gvimfullscreen 工具配置 > 请确保已安装了工具
" -----------------------------------------------------------------------------
" 用于 Windows Gvim 全屏窗口,可用 F11 切换
" 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
if (g:iswindows && g:isGUI)
    nmap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" -----------------------------------------------------------------------------
"  < vimtweak 工具配置 > 请确保以已装了工具
" -----------------------------------------------------------------------------
" 这里只用于窗口透明与置顶
" 常规模式下 Ctrl + Up(上方向键) 增加不透明度,Ctrl + Down(下方向键) 减少不透明度,<Leader>t 窗口置顶与否切换
if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

    "快捷键设置
    nmap <c-up> :call Alpha_add()<CR>
    nmap <c-down> :call Alpha_sub()<CR>
    nmap <leader>t :call Top_window()<CR>
endif

" =============================================================================
"                          << 以下为常用自动命令配置 >>
" =============================================================================

" 自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

" =============================================================================
"                     << windows 下解决 Quickfix 乱码问题 >>
" =============================================================================
" windows 默认编码为 cp936,而 Gvim(Vim) 内部编码为 utf-8,所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码,以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果,如果输出信息是中英混合的,那可能
" 不成功,会造成其中一种语言乱码,输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码,如果不行就还是给它注释掉

" if g:iswindows
"     function QfMakeConv()
"         let qflist = getqflist()
"         for i in qflist
"            let i.text = iconv(i.text, "cp936", "utf-8")
"         endfor
"         call setqflist(qflist)
"      endfunction
"      au QuickfixCmdPost make call QfMakeConv()
" endif

" =============================================================================
"                          << 其它 >>
" =============================================================================
" 注：上面配置中的"<Leader>"在本软件中设置为"\"键(引号里的反斜杠),如<Leader>t
" 指在常规模式下按"\"键加"t"键,这里不是同时按,而是先按"\"键后按"t"键,间隔在一
" 秒内,而<Leader>cs是先按"\"键再按"c"又再按"s"键；如要修改"<leader>"键,可以把
" 下面的设置取消注释,并修改双引号中的键为你想要的,如修改为逗号键.
" let mapleader = ","
syntax enable
set background=dark
" color solarized
" =============================================================================
" YouCompleteMe configuarations
" =============================================================================
"设置关健字触发补全
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'  
let g:ycm_auto_trigger=1
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_tags_files=1   " 开启YCM基于ctags
" set completeopt-=preview                
let g:ycm_min_num_of_chars_for_completion=3
let g:ycm_always_populate_location_list = 1
let g:ycm_cache_omnifunc=0               
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_use_ultisnips_completer = 0                 "不查询ultisnips提供的代码模板补全，如果需要，设置成1即可  
let g:ycm_allow_changing_updatetime = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_key_invoke_completion='<C-c>'
let g:ycm_error_symbol='>>'
let g:ycm_warning_symbol='>*'
let g:clang_snippets_engine='clang_complete'
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_autoclose_preview_window_after_completion=0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 
let g:syntastic_python_checkers = [ 'flake8' ]
let g:syntastic_python_flake8_args = '--select=F,C9'
" 触发补全的按键, 设置以后自动在c中触发
" let g:ycm_semantic_triggers =  {'c' : ['->', '.', 're![a-zA-Z]{2}\w+'],   
"   \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"   \             're!\[.*\]\s'],
"   \   'ocaml' : ['.', '#'],
"   \   'cpp,objcpp' : ['->', '.', '::'],
"   \   'perl' : ['->'],
"   \   'php' : ['->', '::'],
"   \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
"   \   'ruby' : ['.', '::'],
"   \   'lua' : ['.', ':'],
"   \   'erlang' : [':'],
"   \ }
nmap <leader>gd :YcmCompleter GoToDeclaration<Cr>
nmap <leader>gi :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>gr :YcmCompleter GoToReferences<CR>
nmap <leader>ei :YcmDiags<CR>
nmap <leader>rc :YcmForceCompileAndDiagnostics<Cr>
nmap <leader>yc :YcmCompleter ClearCompilationFlagCache<Cr>
nmap <leader>rn :RefactorRename exec '.input("Rename to: ")'<CR>
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>']
" echo | clang -v -E -x c++ -
" #include "..." search starts here:
" #include <...> search starts here:
" =============================================================================
" DoxygenToolkit.vim : Simplify Doxygen documentation in C, C++, Python. 
" DoxLic、DoxAuthor、Dox
" =============================================================================
let g:DoxygenToolkit_blockHeader="--------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------"
let g:DoxygenToolkit_briefTag_pre="@Synopsis: " 
let g:DoxygenToolkit_paramTag_pre="@Param:    " 
let g:DoxygenToolkit_briefTag_pre="@Synopsis: "
let g:DoxygenToolkit_returnTag=   "@Returns:  "
let g:DoxygenToolkit_authorName="zl, 88911562@qq.com" 
let g:DoxygenToolkit_licenseTag=  "@author: zl, 88911562@qq.com Copyright(c) NTKO"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
set lines=100 columns=240                          "指定窗口大小,lines为高度,columns为宽度
nmap <leader>it :r !date +\[\%Y-\%m-\%d\ \%H:\%M:\%S\]<CR>
" imap <c-a><c-t> exec ':r !date +\[\%Y-\%m-\%d\ \%H:\%M:\%S\]<CR>'

