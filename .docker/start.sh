#!/bin/bash

# Mensagem de inicialização
echo "O script start.sh foi iniciado com sucesso!"

# Verificar e remover diretórios existentes
if [ -d "/var/www/.oh-my-zsh" ]; then
    rm -rf /var/www/.oh-my-zsh
fi

# Alterar permissões do usuário
usermod -u 1000 www-data \
    && usermod -s /bin/bash www-data

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
