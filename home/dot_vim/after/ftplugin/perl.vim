noremap <silent><buffer> K <Esc>:silent! call system("tmux display-popup -w 80% -h 60% -E perldoc -f " . expand('<cword>'))<CR>
