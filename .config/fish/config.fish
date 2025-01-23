if status is-interactive
    # Commands to run in interactive sessions can go here
end

#
# Functions
#

function fish_greeting
	clear
	printf "Silent whispers in the night,\nA universe of endless light.\nLife's mysteries unfold with time,\nObserving patterns so sublime.\nMoments fleeting, yet profound,\nEternity in every sound.\n\n- Eirik Lund" | cowsay
	# colorscript -r
end

function checkMode
    # Only run this if the terminal is "Apple_Terminal"
    if test "$TERM_PROGRAM" = "Apple_Terminal"
        set mode (defaults read -g AppleInterfaceStyle)
        if test "$mode" = Dark
            setTerminalProfile Gruvbox_Dark
        else
            setTerminalProfile Solarized_Light
        end
    end
end

function setTerminalProfile
	command osascript -e "tell application \"Terminal\"
						set default settings to settings set \"$argv\"

						repeat with w in windows
							repeat with t in tabs of w
								set current settings of t to settings set \"$argv\"
							end repeat
						end repeat
					end tell"
end

#
# Set light/dark mode
# checkMode

#
# Set aliases
alias vi "nvim"

setenv -gx EDITOR nvim
setenv -gx SUDO_EDITOR nvim

export PATH="$PATH:$HOME/.local/bin"

# Setting PATH for Python 3.12
# The original version is saved in /Users/eliotp/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# Dotfiles config
if test -d $HOME/dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
end

