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
curl -LJ https://raw.githubusercontent.com/SimonWoodtli/dotfiles/main/home/dot_config/shell/02-utility-functions.sh /tmp/02-utility-functions.sh
curl -LJ https://raw.githubusercontent.com/SimonWoodtli/dotfiles/main/home/dot_config/shell/03-export.sh /tmp/03-export.sh
curl -LJ https://raw.githubusercontent.com/SimonWoodtli/dotfiles/main/home/dot_config/shell/11-completion.sh -o /tmp/11-completion.sh
source /tmp/02-utility-functions.sh
source /tmp/03-export.sh
source /tmp/11-completion.sh
#FIXME the bash-completion path also needs to be in dotfiles, however
#every system will need its own version, chezmoi template should be able
#to deal with that.
export SDKMAN_DIR="$HOME/.config/sdkman" && curl -s "https://get.sdkman.io?rcupdate=false" | bash
source $HOME/.config/sdkman/bin/sdkman-init.sh

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
python3 -m pipx ensurepath
pipxCount=$(yq '.pipx[]' < /tmp/recipe.yml | wc -l)
pipxPackages=($(yq '.pipx[]' < /tmp/recipe.yml))
for pkg in "${pipxPackages[@]}"; do
  #FIXME issue with pipx package name not parsed
  pipx install "$pkg"
done

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-node
############################## interactive #############################
echo "The rest of the installation process requires user input to configure, please be present. To proceed please press <y>."
read a0
while [[ $a0 != "y" ]]; do
  echo "${yw}Warning:$re Prompt requires a 'y'. "; read a0
done

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-rust
source $HOME/.bashrc
aptCount=$(yq '.apt[]' < /tmp/recipe.yml | wc -l)
aptPackages=($(yq '.apt[]' < /tmp/recipe.yml))
for pkg in "${aptPackages[@]}"; do
  sudo apt-get install "$pkg"
done
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-sshrc

chezmoi -S $HOME/Repos/github.com/SimonWoodtli/dotfiles init --apply
source $HOME/.bashrc

npmCount=$(yq '.npm[]' < /tmp/recipe.yml | wc -l)
npmPackages=($(yq '.npm[]' < /tmp/recipe.yml))
npm install -g npm@latest
for pkg in "${npmPackages[@]}"; do
  npm install -g "$pkg"
done

goCount=$(yq '.go[]' < /tmp/recipe.yml | wc -l)
goPackages=($(yq '.go[]' < /tmp/recipe.yml))
for pkg in "${goPackages[@]}"; do
  #FIXME issue with go package name not parsed
  go install $pkg
done
