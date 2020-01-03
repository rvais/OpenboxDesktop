" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2006 Apr 15

" This color scheme uses a light grey background.

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mycolor"

hi Normal ctermfg=Black ctermbg=White guifg=Black guibg=White

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg term=standout ctermbg=DarkRed ctermfg=White guibg=Red guifg=White
hi IncSearch term=reverse cterm=reverse guifg=Black guibg=Grey
hi ModeMsg term=bold cterm=bold gui=bold
hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
hi StatusLineNC term=reverse cterm=reverse gui=reverse
hi VertSplit term=reverse cterm=reverse gui=reverse
hi Visual term=reverse ctermbg=grey guibg=grey80
hi VisualNOS term=underline,bold cterm=underline,bold gui=underline,bold
hi DiffText term=reverse cterm=bold ctermbg=Red gui=bold guibg=LightRed
hi Cursor guibg=Black guifg=Grey95
hi lCursor guibg=Cyan guifg=NONE
hi Directory term=bold ctermfg=DarkBlue guifg=Blue
hi LineNr term=underline ctermfg=Green guifg=DarkGreen
hi MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=Blue
hi NonText term=bold ctermfg=Blue gui=bold guifg=Blue guibg=Grey
hi Question term=standout ctermfg=DarkGreen gui=bold guifg=DarkGreen
hi Search term=reverse ctermbg=Yellow ctermfg=NONE guibg=DarkBlue guifg=White
hi SpecialKey term=bold ctermfg=DarkBlue gui=bold guifg=Blue
hi Title term=bold ctermfg=DarkMagenta gui=bold guifg=DarkBlue
hi WarningMsg term=standout ctermfg=DarkRed guifg=Red
hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Folded term=standout ctermbg=Grey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi FoldColumn term=standout ctermbg=Grey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
hi DiffAdd term=bold ctermbg=LightBlue guibg=LightBlue
hi DiffChange term=bold ctermbg=LightMagenta gui=underline guibg=LightMagenta
hi DiffDelete term=bold ctermfg=Blue ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi CursorLine term=underline cterm=underline guibg=grey80
hi CursorColumn term=reverse ctermbg=grey guibg=grey80

" Colors for syntax highlighting

hi Comment    cterm=NONE      ctermfg=LightBlue   gui=NONE guifg=Grey60
hi Constant   term=underline  ctermfg=DarkRed     guifg=Blue guibg=White
hi Special    term=bold       ctermfg=DarkMagenta guifg=Blue guibg=White
hi Statement  term=bold       cterm=bold          ctermfg=Brown gui=bold, guifg=DarkBlue
hi Ignore     ctermfg=LightGrey guifg=grey90
hi Type       gui=bold        guifg=Blue
hi Identifier gui=bold        guifg=DarkBlue
hi preproc		guifg=DarkGreen

" vim: sw=2
