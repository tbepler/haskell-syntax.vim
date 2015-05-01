if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

"special    ->   ( | ) | , | ; | [ | ] | `| { | } 
"symbol     ->   ascSymbol | uniSymbol<special | _ | : | " | '>
"ascSymbol  ->   ! | # | $ | % | & | * | + | . | / | < | = | > | ? | @
"                \ | ^ | | | - | ~
"uniSymbol  ->   any Unicode symbol or punctuation

"syntax match hsSpecial "\V("
"syntax match hsSpecial "\V)"
"syntax match hsSpecial "\V,"
"syntax match hsSpecial "\V;"
"syntax match hsSpecial "\v\["
"syntax match hsSpecial "\v\]"
"syntax match hsSpecial "\V`"
"syntax match hsSpecial "\V{"
"syntax match hsSpecial "\V}"
"highlight def link hsSpecial Delimiter
"
"syntax match hsSymbol "\V!"
"syntax match hsSymbol "\V#"
"syntax match hsSymbol "\V$"
"syntax match hsSymbol "\V%"
"syntax match hsSymbol "\V&"
"syntax match hsSymbol "\V*"
"syntax match hsSymbol "\V+"
"syntax match hsSymbol "\V."
"syntax match hsSymbol "\V/"
"syntax match hsSymbol "\V<"
"syntax match hsSymbol "\V="
"syntax match hsSymbol "\V>"
"syntax match hsSymbol "\V?"
"syntax match hsSymbol "\V@"
"syntax match hsSymbol "\V\\"
"syntax match hsSymbol "\V^"
"syntax match hsSymbol "\V|"
"syntax match hsSymbol "\V-"
"syntax match hsSymbol "\V~"
"highlight def link hsSymbol Operator
"
""varsym     -> ( symbol {symbol | :})<reservedop | dashes>
""consym     -> (: {symbol | :})<reservedop>
""reservedop -> .. | : | :: | = | \ | | | <- | -> | @ | ~ | =>
"
"syntax match hsReservedOp "\V.."
"syntax match hsReservedOp "\V:"
"syntax match hsReservedOp "\V::"
"syntax match hsReservedOp "\V="
"syntax match hsReservedOp "\V\\"
"syntax match hsReservedOp "\V|"
"syntax match hsReservedOp "\V<-"
"syntax match hsReservedOp "\V->"
"syntax match hsReservedOp "\V@"
"syntax match hsReservedOp "\V~"
"syntax match hsReservedOp "\V=>"
"highlight def link hsReservedOp Operator
"
"syntax keyword hsBool False True
"highlight def link hsBool Boolean
"
"syntax match hsNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
"highlight def link hsNumber Number
"syntax match hsFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
"highlight def link hsFloat Float
"
"syntax match hsSpecialChar "\v\\\d+" contained
"syntax match hsSpecialChar "\v\\o[0-7]+" contained
"syntax match hsSpecialChar "\v\\x[0-9a-fA-F]+" contained
"syntax match hsSpecialChar "\v\\[abfnrtv\"&'\\]" contained
"syntax match hsSpecialChar "\V\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)" contained
"highlight def link hsSpecialChar Type
"
"syntax match hsSpecialCharError "\\&\|'''\+" contained
"highlight def link hsSpecialCharError Error
"
""TODO char regex could use some work - maybe use region instead of match?
"syntax match hsChar "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
"syntax match hsChar "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
"highlight def link hsChar Character
"
"syntax region hsString start=/\V"/ skip=/\V\\\\\|\\"/ end=/\V"/ contains=hsSpecialChar,@Spell
"highlight def link hsString String
"
"syntax keyword hsTodo TODO FIXME XXX contained
"highlight def link hsTodo Todo
"
"syntax match hsLineComment "\v--.*$" contains=hsTodo,@Spell
"highlight def link hsLineComment Comment
"
"syntax region hsBlockComment start=/\V{-/ end=/\V-}/ contains=hsTodo,@Spell
"highlight def link hsBlockComment Comment
"
"syntax keyword hsConditional if then else

syntax match haskellRecordField "[_a-z][a-zA-Z0-9_']*\s*::" contains=haskellIdentifier,haskellOperators contained
syntax match haskellTopLevelDecl "^\s*\(where\s\+\|let\s\+\|default\s\+\)\?[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\(\s*::\|\n\s\+::\)" contains=haskellIdentifier,haskellOperators,haskellDelimiter,haskellWhere,haskellLet,haskellDefault

syntax keyword haskellBlockKeywords data type family module where class instance deriving contained
highlight def link haskellBlockKeywords Structure

if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syntax region haskellModuleBlock start="\<module\>" end="\<where\>"
    \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma,haskellPreProc,haskellPatternKeyword keepend
else
  syntax region haskellModuleBlock start="\<module\>" end="\<where\>"
    \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma,haskellPreProc keepend
endif
syntax region haskellBlock start="\<\(class\|instance\)\>" end="\(\<where\>\|^\s*$\)"
  \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma keepend
syntax region haskellDataBlock start="\<\(data\|type\)\>\(\s\+\<family\>\)\?" end="\([=]\|\<where\>\|^\s*$\)" keepend
  \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma keepend

syntax keyword haskellStandaloneDerivingKeywords deriving instance contained
syntax keyword haskellStructure newtype deriving
highlight def link haskellStandaloneDerivingKeywords Structure
highlight def link haskellStructure Structure

syntax keyword haskellDefault default
highlight def link haskellDefault Statement

syntax region haskellStandaloneDeriving start="\<deriving\>\s\+\<instance\>" end="$"
  \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellStandaloneDerivingKeywords

syntax keyword haskellImport import contained
syntax keyword haskellExport export contained
syntax keyword haskellForeign foreign contained
syntax keyword haskellImportKeywords qualified safe as hiding contained
syntax keyword haskellForeignKeywords ccall safe unsafe interruptible capi prim contained
highlight def link haskellImport Include
highlight def link haskellExport Include
highlight def link haskellForeign Include
highlight def link haskellImportKeywords Structure
highlight def link haskellForeignKeywords Structure

syntax region haskellForeignImport start="\<foreign\>" contains=haskellOperators,haskellForeignKeywords,haskellIdentifier,haskellImport,haskellExport,haskellForeign,haskellString end="::" keepend
syntax region haskellImport start="\<import\>" contains=haskellDelimiter,haskellType,haskellDot,haskellImportKeywords,haskellString,haskellImport end="\((\|$\)" keepend

syntax keyword haskellStatement do case of in
syntax keyword haskellWhere where
syntax keyword haskellLet let
highlight def link haskellStatement Statement
highlight def link haskellWhere Statement
highlight def link haskellLet Statement

if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  syntax keyword haskellStatic static
endif
syntax keyword haskellConditional if then else
highlight def link haskellConditional Conditional

syntax match haskellNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>\|\<0[bB][10]\+\>"
highlight def link haskellNumber Number
syntax match haskellFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
highlight def link haskellFloat Float

syntax match haskellDelimiter  "(\|)\|\[\|\]\|,\|;\|`\|{\|}"
highlight def link haskellDelimiter Delimiter

syntax keyword haskellInfix infix infixl infixr
highlight def link haskellInfix PreProc

syntax keyword haskellBottom undefined error
highlight def link haskellBottom Exception

syntax keyword haskellDebug trace
highlight def link haskellDebug Debug

syntax match haskellOperators "[-!#$%&\*\+/<=>\?@\\^|~:]\+\|\<_\>"
highlight def link haskellOperators Operator

syntax match haskellQuote "\<'\+" contained
syntax match haskellQuotedType "[A-Z][a-zA-Z0-9_']*\>" contained
syntax region haskellQuoted start="\<'\+" end="\s\|$" contains=haskellType,haskellQuote,haskellQuotedType,haskellDelimiter,haskellOperators,haskellIdentifier

syntax match haskellDot "\."
highlight def link haskellDot Operator

syntax match haskellBacktick "`[A-Za-z_][A-Za-z0-9_\.']*`" contains=haskellDelimiter
highlight def link haskellBacktick Operator

syntax region haskellString start=/\V"/ skip=/\V\\\\\|\\"/ end=/\V"/ contains=hsSpecialChar,@Spell
highlight def link haskellString String

"TODO char regex could use some work - maybe use region instead of match?
syntax match hsChar "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syntax match hsChar "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
highlight def link hsChar Character

syntax match hsSpecialChar "\v\\\d+" contained
syntax match hsSpecialChar "\v\\o[0-7]+" contained
syntax match hsSpecialChar "\v\\x[0-9a-fA-F]+" contained
syntax match hsSpecialChar "\v\\[abfnrtv\"&'\\]" contained
syntax match hsSpecialChar "\V\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)" contained
highlight def link hsSpecialChar SpecialChar

syntax match hsSpecialCharError "\\&\|'''\+" contained
highlight def link hsSpecialCharError Error

"syntax region haskellString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
"syntax match haskellChar "\<'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'\>"

syntax match haskellLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
highlight def link haskellLineComment Comment

syntax region haskellBlockComment start="{-" end="-}" contains=haskellBlockComment,@Spell
highlight def link haskellBlockComment Comment

syntax region haskellPragma start="{-#" end="#-}"
highlight def link haskellPragma PreProc

"TODO
syntax match haskellIdentifier "[_a-z][a-zA-z0-9_']*" contained

syntax match haskellType "\<[A-Z][a-zA-Z0-9_']*\>"
highlight def link haskellType Type

syntax region haskellRecordBlock start="[A-Z][a-zA-Z0-9']*\s\+{[^-]" end="[^-]}" keepend
  \ contains=haskellType,haskellDelimiter,haskellOperators,haskellDot,haskellRecordField,haskellString,haskellChar,haskellFloat,haskellNumber,haskellBacktick,haskellLineComment, haskellBlockComment,haskellPragma,haskellBottom,haskellDebug,haskellConditional,haskellStatement,haskellWhere,haskellLet
syntax match haskellQuasiQuoteDelimiters "\[[_a-z][a-zA-z0-9_']*|\||\]" contained
syntax region haskellQuasiQuote start="\[[_a-z][a-zA-z0-9_']*|" end="|\]" contains=haskellQuasiQuoteDelimiters keepend
syntax match haskellTHQuasiQuotes "\[||\|||\]\|\[|\||\]\|\[\(d\|t\|p\)|"

"TODO include constants (and operators?) in pre processor commands
syntax match haskellPreProc "\v^\s*#.*$"
highlight def link haskellPreProc PreProc

if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  syntax keyword haskellTypeRoles type role phantom representational nominal contained
  syntax region haskellTypeRoleBlock start="type\s\+role" end="[\n]"
    \ contains=haskellType,haskellTypeRoles keepend
endif
if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  syntax keyword haskellForall forall contained
  syntax match haskellQuantification "\<\(forall\)\>\s\+[^.=]*\."
    \ contains=haskellForall,haskellOperators,haskellDot,haskellDelimiter
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  syntax keyword haskellRecursiveDo mdo rec
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  syntax keyword haskellArrowSyntax proc
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syntax region haskellPatternSynonyms start="^\s*pattern\s\+[A-Z][A-za-z0-9_]*\s*" end="=\|<-\|$" keepend contains=haskellPatternKeyword,haskellType,haskellOperators
  syntax keyword haskellPatternKeyword pattern contained
endif

"highlight def link haskellBottom Macro
"highlight def link haskellQuasiQuoteDelimiters Boolean
"highlight def link haskellTHQuasiQuotes Boolean
"highlight def link haskellBlockKeywords Structure
"highlight def link haskellStandaloneDerivingKeywords Structure
"highlight def link haskellIdentifier Identifier
"highlight def link haskellImportKeywords Structure
"highlight def link haskellForeignKeywords Structure
"highlight def link haskellStructure Structure
"highlight def link haskellStatement Statement
"highlight def link haskellWhere Statement
"highlight def link haskellLet Statement
"highlight def link haskellDefault Statement
"highlight def link haskellConditional Conditional
"highlight def link haskellNumber Number
"highlight def link haskellFloat Float
"highlight def link haskellDelimiter Delimiter
"highlight def link haskellInfix PreProc
"highlight def link haskellOperators Operator
"highlight def link haskellQuote Operator
"highlight def link haskellQuotedType Include
"highlight def link haskellDot Operator
"highlight def link haskellType Include
"highlight def link haskellLineComment Comment
"highlight def link haskellBlockComment Comment
"highlight def link haskellPragma SpecialComment
"highlight def link haskellString String
"highlight def link haskellChar String
"highlight def link haskellBacktick Operator
"highlight def link haskellPreProc Macro

if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  highlight def link haskellForall Operator
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  highlight def link haskellRecursiveDo Operator
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  highlight def link haskellArrowSyntax Operator
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  highlight def link haskellPatternKeyword Structure
endif
if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  highlight def link haskellTypeRoles Structure
endif
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  highlight def link haskellStatic Statement
endif


let b:current_syntax = "haskell"
