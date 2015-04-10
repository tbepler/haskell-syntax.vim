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

let s:special = "\V(\|)\|,\|;\|[\|]\|`\|{\|}"

syntax match hsSpecial "\V("
syntax match hsSpecial "\V)"
syntax match hsSpecial "\V,"
syntax match hsSpecial "\V;"
syntax match hsSpecial "\v\["
syntax match hsSpecial "\v\]"
syntax match hsSpecial "\V`"
syntax match hsSpecial "\V{"
syntax match hsSpecial "\V}"
highlight def link hsSpecial Delimiter

syntax match hsSymbol "\V!"
syntax match hsSymbol "\V#"
syntax match hsSymbol "\V$"
syntax match hsSymbol "\V%"
syntax match hsSymbol "\V&"
syntax match hsSymbol "\V*"
syntax match hsSymbol "\V+"
syntax match hsSymbol "\V."
syntax match hsSymbol "\V/"
syntax match hsSymbol "\V<"
syntax match hsSymbol "\V="
syntax match hsSymbol "\V>"
syntax match hsSymbol "\V?"
syntax match hsSymbol "\V@"
syntax match hsSymbol "\V\\"
syntax match hsSymbol "\V^"
syntax match hsSymbol "\V|"
syntax match hsSymbol "\V-"
syntax match hsSymbol "\V~"
highlight def link hsSymbol Operator

"varsym     -> ( symbol {symbol | :})<reservedop | dashes>
"consym     -> (: {symbol | :})<reservedop>
"reservedop -> .. | : | :: | = | \ | | | <- | -> | @ | ~ | =>

syntax match hsReservedOp "\V.."
syntax match hsReservedOp "\V:"
syntax match hsReservedOp "\V::"
syntax match hsReservedOp "\V="
syntax match hsReservedOp "\V\\"
syntax match hsReservedOp "\V|"
syntax match hsReservedOp "\V<-"
syntax match hsReservedOp "\V->"
syntax match hsReservedOp "\V@"
syntax match hsReservedOp "\V~"
syntax match hsReservedOp "\V=>"
highlight def link hsReservedOp Operator

syntax match hsSpecialChar "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)" contained
syntax match hsSpecialChar "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)" contained
highlight def link hsSpecialChar SpecialChar

syntax match hsSpecialCharError "\\&\|'''\+" contained
highlight def link hsSpecialCharError Error

"TODO char regex could use some work - maybe use region instead of match?
syntax match hsChar "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syntax match hsChar "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
highlight def link hsChar Character

syntax region hsString start=/\V"/ skip=/\V\\\\\|\\"/ end=/\V"/ contains=hsSpecialChar,@Spell
highlight def link hsString String

syntax keyword hsTodo TODO FIXME XXX contained
highlight def link hsTodo Todo

syntax match hsLineComment "\v--.*$" contains=hsTodo,@Spell
highlight def link hsLineComment Comment

syntax region hsBlockComment start=/\V{-/ end=/\V-}/ contains=hsTodo,@Spell
highlight def link hsBlockComment Comment

syntax keyword hsConditional if then else

let b:current_syntax = "haskell"
