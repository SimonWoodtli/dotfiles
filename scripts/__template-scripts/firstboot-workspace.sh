#!/usr/bin/bash
############################ non-interactive ###########################
#check if in container or abort 
[[ $(hostname) == workspace.fedora ]] || exit 1
sudo apt-get update && sudo apt-get upgrade
curl -LJ https://raw.githubusercontent.com/SimonWoodtli/workspace-toolbox/main/recipe.yml -o /tmp/recipe.yml

#install nix pkg manager:
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
sudo chown -R $(whoami):$(whoami) /nix
sudo usermod -a -G input "$(whoami)" #use dotool without root
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# bash completion for nix requires some manual intervention or this code
# to copy it to the right path. Why they cannot do this when nix gets
# installed is a bit ... annoying but whatever. It's better than fetching
# chezmoi first and initalize my dotfiles prior to installing all
# packages.
nix profile install "nixpkgs#bash-completion"
bashCompletionPath="$(nix profile list | grep "bash-completion" | head -n 1 | awk '{print $4}')"
echo "if shopt -q progcomp &>/dev/null; then                             
  . "$bashCompletionPath/etc/profile.d/bash_completion.sh"
  nullglobStatus=$(shopt -p nullglob)                                           
  shopt -s nullglob                                                             
  for p in $NIX_PROFILES; do                                                    
    for m in "$p/etc/bash_completion.d/"*; do                                   
      . "$m"                                                                    
    done                                                                        
  done                                                                          
  eval "$nullglobStatus"                                                        
  unset nullglobStatus p m                                                      
fi" >> $HOME/.bashrc
#FIXME the bash-completion path also needs to be in dotfiles, however
#every system will need its own version, chezmoi template should be able
#to deal with that.
export SDKMAN_DIR="$HOME/.config/sdkman" && curl -s "https://get.sdkman.io?rcupdate=false" | bash
source $HOME/.config/sdkman/bin/sdkman-init.sh
source $HOME/.bashrc

sdkCount=$(yq '.sdk[]' < /tmp/recipe.yml | wc -l)
sdkPackages=($(yq '.sdk[]' < /tmp/recipe.yml))
for pkg in "${sdkPackages[@]}"; do
  sdk install java "$pkg"
done

export NIXPKGS_ALLOW_UNFREE=1
nixCount=$(yq '.nix[]' < /tmp/recipe.yml | wc -l)
nixPackages=($(yq '.nix[]' < /tmp/recipe.yml))
for pkg in "${nixPackages[@]}"; do
  nix profile install --impure nixpkgs\#$pkg
  #nix profile upgrade 0
done

python3 -m pip install --user pipx
pipxCount=$(yq '.pipx[]' < /tmp/recipe.yml | wc -l)
pipxPackages=($(yq '.pipx[]' < /tmp/recipe.yml))
for pkg in "${pipxPackages[@]}"; do
  pipx install "$pkg"
done

goCount=$(yq '.go[]' < /tmp/recipe.yml | wc -l)
goPackages=($(yq '.go[]' < /tmp/recipe.yml))
for pkg in "${goPackages[@]}"; do
  #FIXME issue with go package name not parsed
  go install $pkg
done

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-node
source $HOME/.bashrc
exec bash -l
npmCount=$(yq '.npm[]' < /tmp/recipe.yml | wc -l)
npmPackages=($(yq '.npm[]' < /tmp/recipe.yml))
for pkg in "${npmPackages[@]}"; do
  npm install -g "$pkg"
done

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-rust
exec bash -l
############################## interactive #############################
echo "The rest of the installation process requires user input to configure, please be present. To proceed please press <y>."
read a0
while [[ $a0 != "y" ]]; do
  echo "${yw}Warning:$re Prompt requires a 'y'. "; read a0
done
aptCount=$(yq '.apt[]' < /tmp/recipe.yml | wc -l)
aptPackages=($(yq '.apt[]' < /tmp/recipe.yml))
for pkg in "${aptPackages[@]}"; do
  sudo apt-get install "$pkg"
done

#TODO maybe private repo is required in order to avoid the "encryption"
#error, gotta test
chezmoi -S $HOME/Repos/github.com/SimonWoodtli/dotfiles init --apply

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-sshrc
