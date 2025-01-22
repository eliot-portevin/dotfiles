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
