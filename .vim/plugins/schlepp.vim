scriptencoding utf-8

let g:Schlepp#trimWS=0
let g:Schlepp#reindent=1
"let g:Schlepp#dupTrimWS=1
let g:Schlepp#dupLinesDir='down'
let g:Schlepp#dupBlockDir='right'
"let g:Schlepp#allowSquishingLines=1
"let g:Schlepp#allowSquishingBlocks=1

xmap <silent> <s-a-up> <plug>SchleppUp
xmap <silent> <s-a-down> <plug>SchleppDown
xmap <silent> <s-a-left> <plug>SchleppLeft
xmap <silent> <s-a-right> <plug>SchleppRight
xmap <silent> <s-a-d> <plug>SchleppDup
