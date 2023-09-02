#!/bin/bash
if [[ ! -d "$HOME/Repos/github.com/SimonWoodtli" ]]; then                       
  folder="$HOME/Repos/github.com/SimonWoodtli/"                                 
  mkdir -p "$folder"
  git -C "$folder" clone https://github.com/SimonWoodtli/dotfiles.git           
  git -C "$folder" clone https://github.com/SimonWoodtli/zet.git                
fi
