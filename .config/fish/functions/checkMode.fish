function checkMode
	set mode (defaults read -g AppleInterfaceStyle)
	# set darkMode (osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode')

	if test "$mode" = Dark
		setTerminalProfile Gruvbox_Dark
	else
		setTerminalProfile Solarized_Light
	end
end
