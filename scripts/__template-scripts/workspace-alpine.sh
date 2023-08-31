#!/bin/bash
############################ non-interactive ###########################
## check if in container or abort 
[[ $(hostname) == workspace.fedora ]] || exit 1
sudo apk --force-refresh update && sudo apk --no-cache upgrade
## make sure bash is default shell for current user
usermod --shell /bin/bash $USER

##Get dotfiles if not already on system:
if [[ ! -d "$HOME/Repos/github.com/SimonWoodtli" ]]; then
  folder="$HOME/Repos/github.com/SimonWoodtli/"
  git -C "$folder" clone https://github.com/SimonWoodtli/dotfiles.git
  git -C "$folder" clone https://github.com/SimonWoodtli/zet.git
fi

## Get recipe with packages to be installed
curl -LJ https://raw.githubusercontent.com/SimonWoodtli/workspace-alpine/main/recipe.yml -o /tmp/recipe.yml

## Install sdkman and java8:
##FIXME installs correct but cant find 'java' cmd maybe cause of path/chezmoi
#issue too
export SDKMAN_DIR="$HOME/.config/sdkman" && curl -s "https://get.sdkman.io?rcupdate=false" | bash
source $HOME/.config/sdkman/bin/sdkman-init.sh
sdkPackages=($(yq '.sdk[]' < /tmp/recipe.yml))
for pkg in "${sdkPackages[@]}"; do
  sdk install java "$pkg"
done

## Install pipx and pips:
##FIXME command "java" cant be found so html5vali does not run
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipxPackages=($(yq '.pipx[]' < /tmp/recipe.yml))
for pkg in "${pipxPackages[@]}"; do
  pipx install "$pkg"
done

## Don't use install-node script it is compiled with glibc and Alpine uses musl
## Install npm packages: 
npmPackages=($(yq '.npm[]' < /tmp/recipe.yml))
npm install -g npm@latest
for pkg in "${npmPackages[@]}"; do
  npm install -g "$pkg"
done

## Install go packages:
##FIXME exercism does not install
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

$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-sshrc
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-rust
#source $HOME/.bashrc
