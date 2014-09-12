#!/usr/bin/fish

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins autojump tmux

function fish_greeting
    if test (which alsi 2> /dev/null)
	alsi -a
    else
	echo "You can customize this greeting..."
    end
end

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

function prepend-to-path -d "Prepend the given dir to PATH"
    if test -d $argv[1]
	if not contains $argv[1] $PATH
	    set -gx PATH "$argv[1]" $PATH
	end
    end
end

prepend-to-path "$HOME/bootstrap/scripts"
prepend-to-path "$HOME/.gem/ruby/2.1.0/bin"

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Node version manager
# https://github.com/Alex7Kom/nvm-fish
source ~/.nvm-fish/nvm.fish

# virtualenv for fish
# https://github.com/adambrenecki/virtualfish
set -g -x PROJECT_HOME ~/Dev/python/workspace/
set -g VIRTUALFISH_COMPAT_ALIASES # virtualenvwrapper-style cmds
. $HOME/.config/fish/plugins/virtualfish/virtual.fish
. $HOME/.config/fish/plugins/virtualfish/auto_activation.fish
. $HOME/.config/fish/plugins/virtualfish/global_requirements.fish
. $HOME/.config/fish/plugins/virtualfish/projects.fish

# Env variables
set -g -x EDITOR e
set -g -x RUST_SRC_PATH $HOME/Dev/rust/tools/rust/src

function c; cd $argv; end
function cl; clear; end
function e; emacs -nw $argv; end
function l; ls -lah $argv; end
function md; mkdir -p $argv; end
function n; nautilus --no-desktop& $argv; end
function rd; rm -rf $argv; end

function eb; e ~/bootstrap/bootstrap; end
function ee; e ~/.emacs.d/init.el; end
function ef; e ~/bootstrap/dotfiles/config/fish/config.fish; end
function ei; e ~/bootstrap/dotfiles/i3/config; end
function et; e ~/bootstrap/dotfiles/tmux.conf; end
function ex; e ~/bootstrap/dotfiles/Xdefaults; end

function setup-nvm -d "Init version of node"
    if test (nvm use $argv[1]) = "N/A version is not installed yet"
	nvm install $argv[1] > /dev/null
    end
end	

function setup-pyenv -d "Init version of python"
    if not set -q VIRTUAL_ENV
	workon default
    end
end

function setup-tmux -d "Attach || create tmux session"
    if test (echo $TMUX) = ""
	tmux new-session -s $argv[1]
    end
    tmux attach -t $argv[1]
end

setup-nvm 0.10
setup-pyenv
setup-tmux sesh

