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
alias composer='COMPOSER_MEMORY_LIMIT=-1 /usr/local/bin/composer'
alias cs-fixer='~/.composer/vendor/bin/php-cs-fixer'
alias cs-fix='cs-fixer --config=/Users/oniryx/.php_cs fix '
alias cs-staged='for staged in `git status | grep "modified\|new" | grep -v "On branch" | cut -d : -f 2- | sort  | uniq`; do cs-fix -q "$staged"; echo "$staged"; done;'
cs-fix-since() {
    for file in `git diff --numstat $1 | awk '{print $3}'`; do cs-fix -q "$file"; echo "$file"; done;
}

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"


# Docker
alias docker-composer="docker-compose"
alias dcud='docker-compose up -d'
alias dcud.mac='docker-compose -f docker-compose.yml -f docker-compose.mac.yml up -d'
alias dcd='docker-compose down'
alias dcs='docker-compose stop'
function docker-bash() { docker exec -it "$1" bash; }
alias devil-up="docker-compose up -d php httpd mysql"
alias speed='docker-compose exec drupal bash -c "phpdismod memcached apcu_bc apcu xdebug ffi && /etc/init.d/apache2 reload"'

# Git
alias nah="git reset --hard && git clean -df"
# Versantus
# use the below alias to clone versantus repo
# once set use :
# git config --local core.sshCommand 'ssh -i ~/.ssh/versantus'
# git config --local user.email 'marc.carlucci@versantus.co.uk'
alias vit="GIT_SSH_COMMAND='ssh -i ~/.ssh/versantus -o IdentitiesOnly=yes' git"


export DATABASE_DUMP_DIR=/Users/oniryx/Documents/DatabaseDumps/elsieapp_db_dump

function shush() { "$@" >& /dev/null }
