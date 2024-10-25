#!/bin/sh

# Modify ww-data uid and gid form permission issues
UID=$(stat -c "%u" ".env.example")
GID=$(stat -c "%g" ".env.example")

usermod -u "$UID" www-data
groupmod -g "$GID" www-data
usermod --shell /bin/sh www-data

if [ ! -d vendor ]; then
    composer install
fi

if [ ! -f .env ]; then
    cp .env.example .env
    php artisan key:generate
    php artisan migrate
fi

chown -R "$UID:$GID" .
su www-data -c "nohup php artisan queue:work > /dev/null 2>&1 &"
php-fpm
