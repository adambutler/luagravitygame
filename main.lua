-- Set iOS to log to console
io.output():setvbuf('no')

-- Corona API Files
graphics = require("graphics")
sqlite3 = require("sqlite3")
storyboard = require("storyboard");
widget = require("widget")

-- Vendor Files
easingx = require("easingx")

-- Simulator Methods
display.setStatusBar( display.HiddenStatusBar )

-- Startup
require("global")

storyboard.gotoScene("game", {params = {}})
