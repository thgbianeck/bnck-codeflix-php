FROM php:8.1.1-fpm

# Instalar dependências
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar o tema Spaceship e fontes Powerline
RUN git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH/themes/spaceship-prompt \
    && ln -s $ZSH/themes/spaceship-prompt/spaceship.zsh-theme $ZSH/themes/spaceship.zsh-theme \
    && git clone https://github.com/powerline/fonts.git --depth=1 \
    && cd fonts \
    && ./install.sh \
    && cd .. \
    && rm -rf fonts

# Configurar o PHP e instalar extensões
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets

# Instalar e habilitar Redis
RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

# Alterar permissões do usuário
RUN usermod -u 1000 www-data \
    && usermod -s /bin/zsh www-data

# Definir o diretório de trabalho
WORKDIR /var/www

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar o arquivo de configuração do zsh
COPY .docker/.zshrc /workspace/.zshrc

# Mudar de volta para o usuário www-data
USER www-data

# Expor a porta 9000
EXPOSE 9000

# Comando para manter o contêiner em execução
CMD ["php-fpm", "-F"]
