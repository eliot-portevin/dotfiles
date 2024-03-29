if status is-interactive
    # Commands to run in interactive sessions can go here
end

#
# Functions
#
function fish_greeting
	clear
	fortune | cowsay
	# colorscript -r
end

function checkMode
	set mode (defaults read -g AppleInterfaceStyle)

	if test "$mode" = Dark
		setTerminalProfile Gruvbox_Dark
	else
		setTerminalProfile Solarized_Light
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
checkMode

#
# Set aliases
alias vi "nvim"

setenv -gx EDITOR nvim
setenv -gx SUDO_EDITOR nvim

export PATH="$PATH:$HOME/.local/bin"
