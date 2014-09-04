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

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

source ~/.nvm-fish/nvm.fish

function prepend-to-path -d "Prepend the given dir to PATH"
    if test -d $argv[1]
	if not contains $argv[1] $PATH
	    set -gx PATH "$argv[1]" $PATH
	end
    end
end

prepend-to-path "$HOME/bootstrap/scripts"

set -g -x EDITOR e

function c; cd $argv; end
function cl; clear; end
function e; emacs -nw $argv; end
function l; ls -lah $argv; end
function md; mkdir -p $argv; end
function n; nautilus --no-desktop& $argv; end
function rd; rm -rf $argv; end

function eb; e ~/bootstrap/bootstrap; end
function ef; e ~/bootstrap/dotfiles/config/fish/config.fish; end
function et; e ~/bootstrap/dotfiles/tmux.conf; end
function ei; e ~/bootstrap/dotfiles/i3/config; end
function ee; e ~/.emacs.d/init.el; end

function setup-nvm -d "Init version of node"
    if test (nvm use $argv[1]) = "N/A version is not installed yet"
	nvm install $argv[1] > /dev/null
    end
end	

function setup-tmux -d "Attach || create tmux session"
    if test (echo $TMUX) = ""
	tmux new-session -s $argv[1]
    end
    tmux attach -t $argv[1]
end

setup-nvm 0.10
setup-tmux sesh




