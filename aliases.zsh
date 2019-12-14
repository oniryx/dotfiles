# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias c="clear"
alias diff='diff -u'
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"
alias lara="sites && cd laravel/"

# Laravel
alias a='DB_HOST=127.0.0.1 php artisan'
alias ams="php artisan migrate:fresh --seed"

# PHP
alias php73="/usr/local/Cellar/php@7.3/7.3.12/bin/php"
alias cfresh="rm -rf vendor/ composer.lock && composer i"
alias cs-fixer='~/.composer/vendor/bin/php-cs-fixer'
alias cs-fix='cs-fixer --config=/Users/oniryx/.php_cs fix '
alias cs-staged='for staged in `git dc --name-only`; do cs-fix -q $staged; done;'

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# MySQL
db_refresh() {
    mysqladmin --force --silent drop $1
    mysqladmin create $1
    echo "Database \"$1\" created"
}

db_load() {
    bunzip2 -c ~/Documents/DatabaseDumps/elsieapp_db_dump/$1.sql.bz2| mysql $1
    echo "\"$1.sql.bz2\" loaded"
}

db_reload() {
    db_refresh $1
    db_load $1
}


# Docker
alias docker-composer="docker-compose"
alias devil-up="docker-compose up -d php httpd mysql mailhog"

# Git
alias nah="git reset --hard && git clean -df"
