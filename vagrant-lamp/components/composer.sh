#!/bin/bash
#Composer
php -r "eval('?>'.file_get_contents('https://getcomposer.org/installer'));"
mv -f composer.phar /usr/local/bin/composer.phar
alias composer='/usr/local/bin/composer.phar'
