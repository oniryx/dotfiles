# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

export PATH="/usr/local/sbin:$PATH"

# Load mysql-client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# Load work tools
export PATH="$PATH:$HOME/Documents/Work/tools"
