" Indent anonymous classes correctly
setlocal cinoptions+=j1

" Indent JavaScript object declarations correctly
setlocal cinoptions+=J1

" Use 2 * 'shifwidth' to indent continuation lines
setlocal cinoptions+=+2s

" Use 2 * 'shifwidth' to indent inside unclosed parentheses
setlocal cinoptions+=(2s

" Use 2 * 'shifwidth' to indent inside nested unclosed parentheses
setlocal cinoptions+=u2s

" Do not ignore the 'u' and '(' indenting options when the unclosed parenthesis is the first non-white character in its line
setlocal cinoptions+=U1

" Line up a line starting with a closing parenthesis with the first character of the line with the matching opening parenthesis
setlocal cinoptions+=m1

" Indent case bodies relatively to their labels
setlocal cinoptions+=l1

" Undo commands
call indent#append_undo_cmd('setlocal cinoptions<')
