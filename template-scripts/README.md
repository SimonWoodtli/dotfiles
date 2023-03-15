# Template Scripts

These scripts are only for usage in a template file. They can be manually triggered from within a template file.

* dotfiles/template-scripts contain scripts that get triggered when coded with `{{ output "bash" "-c" "scriptname" | trim }}`
* home/.chezmoiscripts contains all the scripts that get triggered by `chezmoi init`
* dotfiles/scripts contains my regular scripts to run from the shell and are in \$PATH
