Config {
       font = "xft:Fantasque Sans Mono:size=10:bold:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Font Awesome:size=11"
                           , "xft:Font Awesome:size=13" ]
       , allDesktops = True
       , bgColor = "#282c34"
       , fgColor = "#bbc2cf"
       , position = Static {xpos=0, ypos=0, width=1440, height=24}
       , commands = [ Run Cpu [ "--template", "<box type=Bottom width=2 mb=2 color=#c678dd><fc=#c678dd><fn=1>\xf108</fn> cpu: (<total>%)</fc></box>"] 50

                    , Run Date "<box type=Bottom width=2 mb=2 color=#99d9ff><fc=#99d9ff><fn=1></fn> %H:%M</fc></box>" "date" 300

                    , Run CoreTemp ["-t", "<box type=Bottom width=2 mb=2 color=#ecbe7b><fc=#ecbe7b><fn=1></fn> temp: <core0>°</fc></box>"] 100

                    -- battery monitor
                    , Run BatteryP       [ "BAT0" ]
                                         [ "--template" , "<box type=Bottom width=2 mb=2 color=#da8548><fc=#da8548><acstatus></fc></box>"
                                         , "--" -- battery specific options
                                                   -- discharging status
                                                   , "-o"   , "<fn=1>\xf242</fn> <left>%"
                                                   -- AC "on" status
                                                   , "-O"   , "<fn=1>\xf1e6</fn> <left>%" -- 50fa7b
                                                   -- charged status
                                                   , "-i"   , "<fn=1>\xf240</fn> <left>%"
                                         ] 50
                    , Run DiskU [("/", "<box type=Bottom width=2 mb=2 color=#ff6c6b><fc=#ff6c6b><fn=1>\xf0c7</fn> ssd: (<free>) free</fc></box>"), ("sdb1", "<usedbar>")]
                                ["-L", "20", "-H", "50", "-m", "1", "-p", "3"] 20

                    , Run Com "/home/eliot/.config/xmobar/volume.sh" [] "volume" 10
                    , Run Com "/home/eliot/.config/xmobar/updates.sh" [] "updates" 500
                    , Run Com "echo" ["<fn=1>\xf0f3</fn>"] "bell" 3600
                    , Run Com "echo" ["<fn=2>\xf17c </fn>"] "penguin" 3600
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{%penguin% %coretemp%  %disku%  <box type=Bottom width=2 mb=2 color=#a9a1e1><fc=#a9a1e1>%bell% %updates% updates</fc></box>  <box type=Bottom width=2 mb=2 color=#98be65><fc=#98be65><fn=1></fn> %volume%</fc></box>  %cpu%  %battery%  %date%       "   -- #69DFFA
       }
