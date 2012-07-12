" Vim syntax file
" Language: Log::Log4perl configuration syntax
" Maintainer: Stanislaw Klekot <vim@jarowit.net>
" Last Change: 2012-02-02
" Version: 0.1

"-----------------------------------------------------------------------------
" setup {{{

if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

syn case match
"setlocal iskeyword=a-z,A-Z,48-57,_

" }}}
"-----------------------------------------------------------------------------
" {{{

" typical option
syn match logComment "^\s*#.*"

" initial keyword (always necessary)
syn match logOptionPrefix "^\s*\(log4perl\|log4j\)\."he=e-1 nextgroup=@logOptionType

" small inner elements
syn match   logOptionValueFormat contained "%."
syn match   logOptionValueModule contained "\<[[:alnum:]]\+\(::[[:alnum:]]\+\)\+\>"
syn match   logOptionValue   contained ".\+" contains=logOptionValueFormat,logOptionValueModule,logLevel
syn match   logCategoryName  contained "\w\+\(\.\w\+\)*"
syn match   logCategoryValue contained "[A-Z]\+\s*,\s*\w\+" contains=logLevel,logAppenderName
syn match   logAppenderName  contained "\w\+"
syn keyword logLevel         contained FATAL ERROR WARN INFO DEBUG TRACE

" option defines appender for category
syn keyword logOptionTypeCategory   contained logger category rootLogger nextgroup=@logCategory skipwhite
" option defines appender (output file, format and so on)
syn keyword logOptionTypeAppender   contained appender    nextgroup=@logAppender
" option defines ??? (TODO: look in documentation)
syn keyword logOptionTypeAdditivity contained additivity  nextgroup=@logOption
" option defines message filter
syn keyword logOptionTypeFilter     contained filter      nextgroup=@logOption
syn cluster logOptionType add=logOptionTypeCategory
syn cluster logOptionType add=logOptionTypeAppender
syn cluster logOptionType add=logOptionTypeAdditivity
syn cluster logOptionType add=logOptionTypeFilter

" general option
syn match logOptionStart        contained "\.[a-zA-Z0-9_.]\+" nextgroup=logOptionValueStart   skipwhite
syn match logOptionValueStart   contained "=" nextgroup=logOptionValue   skipwhite
syn cluster logOption   contains=logOptionStart,logOptionValueStart

" category definition (specifies appender and log level)
syn match logCategoryStart      contained "\.[a-zA-Z0-9_.]\+" nextgroup=logCategoryValueStart skipwhite contains=logCategoryName
syn match logCategoryValueStart contained "=" nextgroup=logCategoryValue skipwhite
syn cluster logCategory contains=logCategoryStart,logCategoryValueStart

" appender definition
syn match logAppenderStart      contained "\.[a-zA-Z0-9_]\+" nextgroup=logAppenderOption skipwhite contains=logAppenderName
syn match logAppenderOption     contained "[a-zA-Z0-9_.]*"   nextgroup=logAppenderValueStart skipwhite
syn match logAppenderValueStart contained "=" nextgroup=logOptionValue skipwhite
syn cluster logAppender contains=logAppenderStart,logAppenderValueStart

" }}}
"-----------------------------------------------------------------------------
" colour binding {{{

hi def link logComment       Comment
hi def link logOptionPrefix  Comment

hi def link logOptionTypeCategory    Special
hi def link logOptionTypeAppender    Statement
hi def link logOptionTypeAdditivity  Statement
hi def link logOptionTypeFilter      Statement

hi def link logCategoryName  Identifier
hi def link logAppenderName   Identifier

hi def link logOptionValue        String
hi def link logOptionValueFormat  Special
hi def link logOptionValueModule  Identifier

hi def link logCategoryValue  Normal
hi def link logLevel          Special

" }}}
"-----------------------------------------------------------------------------

let b:current_syntax = "log4perl"

"-----------------------------------------------------------------------------
" vim:foldmethod=marker:nowrap
