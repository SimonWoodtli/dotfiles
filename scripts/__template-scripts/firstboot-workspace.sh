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

# bash completion for nix requires some manual intervention or this code
# to copy it to the right path. Why they cannot do this when nix gets
# installed is a bit ... annoying but whatever. It's better than fetching
# chezmoi first and initalize my dotfiles prior to installing all
# packages.
echo "if _have nix && shopt -q progcomp &>/dev/null; then                             
  . "/nix/store/bcjj9j8xqbwqx4fcsxydya671pgl5nzq-bash-completion-2.11/etc/profile.d/bash_completion.sh"
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
export SDKMAN_DIR="$HOME/.config/sdkman" && curl -s "https://get.sdkman.io?rcupdate=false" | bash
source $HOME/.bashrc

sdkCount=$(yq '.sd[]' < /tmp/recipe.yml | wc -l)
sdkPackages=($(yq '.sdk[]' < /tmp/recipe.yml))
for pkg in "${sdkPackages[@]}"; do
  sdk install "$pkg"
done

nixCount=$(yq '.nix[]' < /tmp/recipe.yml | wc -l)
nixPackages=($(yq '.nix[]' < /tmp/recipe.yml))
for pkg in "${nixPackages[@]}"; do
  nix profile install nixpkgs\#$pkg
  #nix profile upgrade 0
done

python3 -m pip install --user pipx
pipxCount=$(yq '.pipx[]' < /tmp/recipe.yml | wc -l)
pipxPackages=($(yq '.pipx[]' < /tmp/recipe.yml))
for pkg in "${nixPackages[@]}"; do
  pipx install "$pkg"
done

goCount=$(yq '.go[]' < /tmp/recipe.yml | wc -l)
goPackages=($(yq '.go[]' < /tmp/recipe.yml))
for pkg in "${goPackages[@]}"; do
  go install "$pkg"
done
############################## interactive #############################
echo "The rest of the installation process requires user input to configure, please be present. To proceed please press <y>."
read a0
while [[ $a0 != "y" ]]; do
  echo "${yw}Warning:$re Prompt requires a 'y'. "; read a0
done
aptCount=$(yq '.apt-interactive[]' < /tmp/recipe.yml | wc -l)
aptPackages=($(yq '.apt-interactive[]' < /tmp/recipe.yml))
for pkg in "${aptPackages[@]}"; do
  sudo apt-get install "$pkg"
done

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-node
npmCount=$(yq '.npm[]' < /tmp/recipe.yml | wc -l)
npmPackages=($(yq '.npm[]' < /tmp/recipe.yml))
for pkg in "${npmPackages[@]}"; do
  npm install -g "$pkg"
done

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-rust
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-sshrc

chezmoi -S $HOME/Repos/github.com/SimonWoodtli/dotfiles init --apply
