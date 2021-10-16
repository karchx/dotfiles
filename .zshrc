# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

alias h='htop'
alias nv='nvim'

export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/home/stivarch/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    colorize   
    copyfile
    git
    gitfast
    golang
    rust
    kubectl
    safe-paste
    tmux
    virtualenv
    zsh-autosuggestions
)

neofetch
source $ZSH/oh-my-zsh.sh

source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/antigen/antigen.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export DENO_INSTALL="/home/stivarch/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

nvm() {
  lazynvm 
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

function mkt() {
 mkdir nmap content scripts tmp exploits 
}

function tmd() {
  tmux new -s dev
}

function extraPorts() {
  
  echo -e "\n${yellowColour}[*] Extracting information...${endColour}\n"
  ip_address=$(cat allPorts | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u)
  open_ports=$(cat allPorts | grep -oP '\d{1,5}/open' | awk '{print $1}' FS="/" | xargs | tr '  ' ',')
  
  echo -e "\t${blueColour}[*] IP Address: ${endColour}${grayColour}$ip_address${endColour}"
  echo -e "\t${blueColour}[*] Open ports: ${endColour}${grayColour}$open_ports${endColour}\n" 

  echo $open_ports| tr -d '\n' | xclip -sel clip

  echo -e "${yellowColour}[*] Ports has been copied to clipboard${endColour}\n"
}
