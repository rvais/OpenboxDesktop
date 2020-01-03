" Vim color file
" Maintainer:	Roman Vais <rvais@redhat.com>
" Last Change:	2016 October

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "blueknight"

if (&term == 'xterm-256color')
  " syntax highliht for 256 colored terminal

  " common syntax highlighting
  hi Normal		cterm=NONE	ctermfg=White		ctermbg=NONE
  hi Cursor		cterm=inverse
  hi LineNr		cterm=NONE	ctermfg=DarkGrey
  hi Type		cterm=italic
  hi Statement		cterm=bold  	ctermfg=Blue
  hi Comment		cterm=NONE	ctermfg=Blue
  hi PreProc		cterm=NONE	ctermfg=DarkGreen
  hi Special		cterm=NONE	ctermfg=Blue
  hi SpecialChar	cterm=bold  	ctermfg=Magenta
  hi Error		cterm=inverse	ctermbg=Red
  hi Folded		cterm=NONE	ctermfg=Black		ctermbg=DarkGray
  hi Function		cterm=NONE	ctermfg=Blue
  hi Identifier		cterm=bold	ctermfg=DarkBlue
  hi Number		cterm=NONE	ctermfg=LightBlue
  hi Operator		cterm=NONE	ctermfg=Magenta
  hi String		cterm=italic	ctermfg=LightGreen
  hi Todo		cterm=NONE	ctermfg=Blue		ctermbg=White
  hi Constant		cterm=NONE	ctermfg=LightBlue

  " MakeFile modifications
  hi! mailQuoted1	ctermfg=Grey

  " C lang modifications
  hi cComment		cterm=NONE	ctermfg=Grey
  hi cNumber		cterm=NONE	ctermfg=LightBlue
  hi Float		cterm=NONE	ctermfg=LightBlue
  hi cString		cterm=NONE	ctermfg=LightBlue
  hi cError		cterm=NONE	ctermfg=White		ctermbg=Red
  hi cType		cterm=italic	ctermfg=Blue
  hi cFormat		cterm=NONE	ctermfg=LightBlue  
  hi! cSpecialChar	cterm=bold  	ctermfg=LightBlue

else 
  " syntax highliht for 16 colored terminal

  " common syntax highlighting
  hi Normal		cterm=NONE	ctermfg=White		ctermbg=NONE
  hi Cursor		cterm=inverse
  hi LineNr		cterm=NONE	ctermfg=DarkGrey
  hi Type		cterm=italic
  hi Delimiter		cterm=standout
  hi SpecialChar	cterm=NONE  
  hi Statement		cterm=bold  

  "  hi Type		cterm=italic	ctermfg=	ctermbg=
  "  hi Delimiter		cterm=standout	ctermfg=	ctermbg=
  "  hi SpecialChar	cterm=NONE	ctermfg=	ctermbg=
  "  hi Statement		cterm=bold	ctermfg=	ctermbg=

 " hi Comment		cterm=NONE	ctermfg=Blue
 " hi PreProc		cterm=NONE	ctermfg=DarkGreen
 " hi Special		cterm=NONE	ctermfg=Blue
 " hi Error		cterm=inverse	ctermbg=Red
 " hi Folded		cterm=NONE	ctermfg=Black	ctermbg=DarkGray
 " hi Function		cterm=NONE	ctermfg=Blue
 " hi Identifier		cterm=bold	ctermfg=DarkBlue
 " hi Number		cterm=NONE	ctermfg=LightBlue
 " hi Operator		cterm=NONE	ctermfg=Magenta
 " hi String		cterm=italic	ctermfg=LightGreen
 " hi Todo		cterm=NONE	ctermfg=Blue	ctermbg=White
 " hi Constant		cterm=NONE	ctermfg=LightBlue

endif

" vim: sw=2
" hi vimError		ctermfg=	ctermbg=
" hi 	ctermfg=	ctermbg=
" hi WarningMsg		ctermfg=	ctermbg=
