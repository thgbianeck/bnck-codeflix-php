# Configurações básicas do Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Define o tema como Spaceship
ZSH_THEME="spaceship"

# Plugins do Oh My Zsh
plugins=(
    git
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# Carrega o Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Configurações adicionais (se necessário)
alias ll='ls -la'

# Configuração do tema Spaceship
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# Ajustar permissões e propriedade dos arquivos
chmod -R go-w $HOME/.oh-my-zsh
chown -R www-data:www-data $HOME/.oh-my-zsh
