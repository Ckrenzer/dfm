" When working with many pattern groups, put the most general patterns higher in
" the script, adding the more granular/specific patterns below them.
" In other words, put the stuff you're okay overwriting at the top!
"
" ,:sbcl
" :set filetype=lispout

syntax case match

" Constants
syntax keyword lispoutT   t T
syntax keyword lispoutNIL nil NIL

" POSITIVE NUMBERS
" Integer
syntax match lispoutPositiveNumber  "\v-@<!\d+"
" Decimal
syntax match lispoutPositiveNumber "\v(-)@<!\d+\.\d*"
" Decimal without leading digit
syntax match lispoutPositiveNumber "\v(-\d*)@<!\.\d+"
" Ratios
syntax match lispoutPositiveNumber "\v(-)@<!\d+\/\d+"
" Exponential notation
syntax match lispoutPositiveNumber   "\v(-)@<!\d+\.?\d*[eE][+-]?\d+"   " 1.2e+10
syntax match lispoutPositiveNumber       "\v(-)@<!\.\d*[eE][+-]?\d+"   "  .2e10

" NEGATIVE NUMBERS
" Integer
syntax match lispoutNegativeNumber "\v-\d+"
" Decimal
syntax match lispoutNegativeNumber "\v-\d+\.\d*"
" Decimal without leading digit
syntax match lispoutNegativeNumber "\v-\.\d+"
" Ratios
syntax match lispoutNegativeNumber "\v-\d+\/\d+"
" Exponential notation
syntax match lispoutNegativeNumber "\v[eE]@<!-\d+\.?\d*[eE][+-]?\d+"  " -1.2e10
syntax match lispoutNegativeNumber     "\v[eE]@<!-\.\d*[eE][+-]?\d+"  " -.2e10

" Strings
syntax region lispoutString start=/"/ skip=/\\\\|\\"/ end=/$/

" Errors
syntax region lispoutError   start=/\v^debugger invoked on a/ end=/\v^Type HELP for debugger help.+$/
syntax region lispoutError   start=/\v#\<[A-Z\-]+/ end=/\v\>.*$/ " most errors start with #< immediately followed by capital letters
syntax region lispoutRestart start=/\v^restarts \(invokable by number/ end=/^0\]/

highlight def link lispoutT Boolean
highlight def link lispoutNIL Boolean
highlight def link lispoutPositiveNumber Number
highlight def link lispoutNegativeNumber Number
highlight def link lispoutString String
highlight def link lispoutError Error
highlight def link lispoutRestart Error

highlight lispoutT              ctermfg=78            " Green
highlight lispoutNIL            ctermfg=203           " Maroon
highlight lispoutPositiveNumber ctermfg=208           " Orange background
highlight lispoutNegativeNumber ctermfg=160           " Dark orange background
highlight lispoutString         ctermfg=85            " Green
highlight lispoutError          ctermfg=220 ctermbg=9 " Red background with yellow font
highlight lispoutRestart        ctermfg=111           " Baby blue font

