#!/bin/bash

# Mensagem de inicialização
echo "O script start.sh foi iniciado com sucesso!"

# Verificar e remover diretórios existentes
if [ -d "/var/www/.oh-my-zsh" ]; then
    rm -rf /var/www/.oh-my-zsh
fi

# Instalar dependências
apt-get update && apt-get install -y \
    git \
    curl \
    zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar Oh My Zsh sem perguntas interativas
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && echo "Oh My Zsh installed"

# Instalar o tema Spaceship e fontes Powerline
git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH/themes/spaceship-prompt \
    && ln -s $ZSH/themes/spaceship-prompt/spaceship.zsh-theme $ZSH/themes/spaceship.zsh-theme \
    && git clone https://github.com/powerline/fonts.git --depth=1 \
    && cd fonts \
    && ./install.sh \
    && cd .. \
    && rm -rf fonts

# Alterar permissões do usuário
usermod -u 1000 www-data \
    && usermod -s /bin/zsh www-data

# Verificar se o PHP-FPM está instalado
if ! command -v php-fpm &> /dev/null
then
    echo "PHP-FPM não foi encontrado"
    exit
fi

# Iniciar o PHP-FPM em segundo plano
php-fpm -D

# Manter o contêiner em execução
tail -f /dev/null
