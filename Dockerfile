FROM php:fpm-bullseye
# FROM php:8.1.1-fpm

# Instalar dependências do PHP
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configurar o PHP e instalar extensões
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets

# Instalar e habilitar Redis
RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

# Definir o diretório de trabalho
WORKDIR /var/www

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar o arquivo de configuração do zsh e o script de inicialização
COPY .docker/start.sh /var/www/.docker/start.sh

# Mudar para o usuário root temporariamente para alterar permissões
USER root
RUN chmod +x /var/www/.docker/start.sh

# Mudar de volta para o usuário www-data
USER www-data

# Expor a porta 9000
EXPOSE 9000
