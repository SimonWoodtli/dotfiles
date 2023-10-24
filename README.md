![dotfiles](assets/dotfiles.png)

# Hey there! :octocat:

[![WIP](https://img.shields.io/badge/status-wip-red)](https://img.shields.io/badge/status-wip-red)
[![wakatime](https://wakatime.com/badge/user/173067c8-7ded-4cfb-8605-b3032659c00c/project/06d88565-a3f0-4342-a7ef-5983a58842f2.svg)](https://wakatime.com/badge/user/173067c8-7ded-4cfb-8605-b3032659c00c/project/06d88565-a3f0-4342-a7ef-5983a58842f2)

These are my dotfiles that I use daily. I hope you find something useful here. :wink:

## Installation

1. install chezmoi
2. clone my dotfiles:

```
mkdir -p ~/Repos/github.com/SimonWoodtli
git clone -C ~/Repos/github.com/SimonWoodtli https://github.com/SimonWoodtli/dotfiles.git
```

3. initialize repo with chezmoi:

```
chezmoi -S ~/Repos/github.com/SimonWoodtli/dotfiles init --apply
```

Most things work on any distro, however if you want a better
experience look into my [workspace container][workspace].

### Folder Structure

* home/ contains all configuration files that are compliant with chezmoi
* completion/ contains configuration files for auto completion for chezmoi
* install/ contains install scripts for a few programs that can't be found on apt/dnf/apk
* scripts/ contains all my scripts, \_\_scripts are for indirect
  execution only, \_\_template-scripts is for chezmoi/container initialization
* home/dot_config/shell contains all files sourced to your bashrc

### My Environment

* terminal: default OS terminal, windows terminal
* terminal font: 'Ubuntu Mono Nerd Font' from [NerdFonts]
* terminal colors: gruvbox
* shell: bash
* editor: vim
* multiplexer: tmux
* file manager: mostly unix commands with \$CDPATH and a few custom fzf commands

### My CLI Tools

* [zet] to manage my notes
* [ripgrep] for full-text search, modern replacement for `grep`.
* [fd] to find files on a file system, modern replacement for `find`.
* up-to-date version of GNU utilities (e.g. `sed`, `tar`, `grep`, `find`, etc.)
* [fzf] to fuzzy find files. It's versatile enough and not limited to files
  only scenario. You can pipe pretty much anything through it and get  a nice
  fuzzy selector interface and apply arbitrary action to the selected item or
  items. Examples are text search matches, brew formulas, npm packages, git
  commits, git branches, etc.
* [bat] same to `cat` but with syntax highlighting.
* [curl] and [wget] to download files
* [jq] lightweight and flexible command-line JSON processor, without
  interactive interface.
* [yq] same as jq but for YAML
* [htop] for interactive process management, or fancy [bashtop]
* [rsync] to copy files and directories when stock `cp` is just not enough.
* [nmap] to scan nodes on a network, probe open ports and check remote running
  apps.
* [bed] binary/hex editor written in Go. Alternatively, use `xxd`, `hexdump` or
  `od` to view files in a binary/hex mode.
* [docker] and [podman] to create and manage container images
* [skopeo] manipulate, inspect, sign and transfer container images
* [cosign] to sign container images
* [browser-sync] create local http server which automatically updates sites
  when you save files and works on all your devices in your LAN
* [tldr] to list a given command with commonly used flags
* [cheat] to get your coding question answered within terminal
* [ventoy] to have multiple bootable ISOs on a USB-Stick
* [dust] to check file sizes in your file system, modern replacement for `du`
* [neomutt] email client
* [newsboat] RSS reader
* [yt-dlp] to download videos, youtube-dl replacement
* [streamlink] to stream services
* [w3m] terminal web browser
* [xclip] to copy to clipboard
* [shellcheck] check your shell scripts
* [pandoc] file converter
* [weechat] IRC client
* [just] command runner to run project specific commands
* [asdf] multi runtime manager to collaborate and enforce same version
* [entr] run any command when given files change/update
* [parallel] executing jobs in parallel
* [age] modern GPG replacement to encrypt files
* [gocryptfs] to encrypt data
* [sops] to partially encrypt files and manage secrets
* [delta] git syntax-highlighting pager
* [gh] official GitHub CLI

### My GUI Tools

* [Virtual Machine Manager] to create and run virtual machines, type 2
  hypervisor
* [VMware Workstation] to create and run virtual machines, type 2 hypervisor
* [draw.io] to create flowcharts and diagrams
* [Ferdium] to channel all communication apps in one
* [mpv] to open videos
* [feh] to open pictures
* [Anki] to study with a flash card management
* [LocalWP] to create wordpress websites
* [MuPDF] to open pdfs
* [Zeal] to read documentation offline
* [RustDesk] to connect with remote computers for remote access and control
* [Flatseal] to manage flatpak permissions
* [Extension Manager] to manage gnome extensions
* [Cryptomator] to encrypt cloud storage
* [KeePassXC] to store and manage passwords

### Tools I want to checkout

* [direnv] to load directory-local `.envrc` and read environment variables.
  It's used to load 12factor apps environment variables, create per-project
  isolated development environments, or load secrets for deployment.
* [httpie] command-line HTTP client for the API era with JSON support, syntax
  highlighting. More advanced alternative to `curl` or `wget`.
* [antonmedv/fx] command line JSON processing and interactive viewer tool.
* [httrack] to copy whole website for offline viewing.
* [bandwhich] CLI utility for displaying current network utilization by
  process, connection and remote IP/hostname.
* [up] tool for writing Linux pipes with instant live preview.

## Feedback

Any suggestions/improvements are [welcome]

## Author

[![gravatar](https://secure.gravatar.com/avatar/ba834a706f9df56eee8ee59a2f7be941?s=200)](https://www.linkedin.com/in/simonwoodtli)

## Stats

![Alt](https://repobeats.axiom.co/api/embed/8e281b4fde7d8d552576290facb760bd4ebc02bb.svg "Repobeats analytics image")

Tags:

    #linux #dotfiles #bash #terminal

[workspace]: <https://github.com/SimonWoodtli/workspace-alpine>
[NerdFonts]: <https://www.nerdfonts.com/>
[welcome]: <https://github.com/SimonWoodtli/dotfiles/issues>
[dotfiles repository]: <https://github.com/rwxrob/dot>
<!-- cli apps: -->
[zet]: <https://github.com/SimonWoodtli/cmd-zet>
[ripgrep]: <https://github.com/BurntSushi/ripgrep>
[fd]: <https://github.com/sharkdp/fd>
[fzf]: <https://github.com/junegunn/fzf>
[bat]: <https://github.com/sharkdp/bat>
[curl]: <https://curl.se/>
[wget]: <https://www.gnu.org/software/wget/>
[jq]: <https://stedolan.github.io/jq/>
[yq]: <https://github.com/mikefarah/yq>
[htop]: <https://htop.dev/>
[bashtop]: <https://github.com/aristocratos/bashtop>
[rsync]: <https://rsync.samba.org/>
[nmap]: <https://nmap.org/>
[bed]: <https://github.com/itchyny/bed>
[docker]: <https://www.docker.com/>
[skopeo]: <https://github.com/containers/skopeo>
[cosign]: <https://github.com/sigstore/cosign>
[podman]: <https://podman.io/>
[browser-sync]: <https://browsersync.io/>
[tldr]: <https://github.com/raylee/tldr-sh-client>
[cheat]: <https://github.com/SimonWoodtli/dotfiles/blob/main/scripts/cheat>
[ventoy]: <https://github.com/ventoy/Ventoy>
[dust]: <https://github.com/bootandy/dust>
[neomutt]: <https://neomutt.org/>
[newsboat]: <https://newsboat.org/>
[yt-dlp]: <https://github.com/yt-dlp/yt-dlp>
[streamlink]: <https://github.com/streamlink/streamlink>
[w3m]: <https://w3m.sourceforge.net/>
[xclip]: <https://github.com/astrand/xclip>
[shellcheck]: <https://www.shellcheck.net/>
[pandoc]: <https://pandoc.org/>
[weechat]: <https://weechat.org/>
[just]: <https://github.com/casey/just>
[asdf]: <https://asdf-vm.com/>
[entr]: <https://github.com/eradman/entr>
[parallel]: <https://www.gnu.org/software/parallel/>
[age]: <https://github.com/FiloSottile/age>
[gocryptfs]: <https://github.com/rfjakob/gocryptfs>
[sops]: <https://github.com/getsops/sops>
[delta]: <https://github.com/dandavison/delta>
[gh]: <https://github.com/cli/cli>
<!-- gui apps: -->
[Virtual Machine Manager]: <https://virt-manager.org/>
[VMware Workstation]: <https://www.vmware.com/products/workstation-pro.html>
[draw.io]: <https://github.com/jgraph/drawio>
[Ferdium]: <https://ferdium.org/>
[mpv]: <https://mpv.io/>
[feh]: <https://feh.finalrewind.org/>
[Anki]: <https://apps.ankiweb.net/>
[LocalWP]: <https://localwp.com/>
[MuPDF]: <https://mupdf.com/>
[Zeal]: <https://zealdocs.org/>
[RustDesk]: <https://rustdesk.com/>
[Flatseal]: <https://github.com/tchx84/Flatseal>
[Extension Manager]: <https://github.com/mjakeman/extension-manager>
[Cryptomator]: <https://cryptomator.org/>
[KeePassXC]: <https://keepassxc.org/>
<!-- cli apps try out: -->
[rupa/z]: <https://github.com/rupa/z>
[direnv]: <https://direnv.net/>
[httpie]: <https://httpie.io/>
[mptre/yank]: <https://github.com/mptre/yank>
[antonmedv/fx]: <https://github.com/antonmedv/fx>
[ncdu]: <https://dev.yorhel.nl/ncdu>
[httrack]: <https://www.httrack.com/>
[bandwhich]: <https://github.com/imsnif/bandwhich>
[up]: <https://github.com/akavel/up>
[mediainfo]: <https://mediaarea.net/en/MediaInfo>
