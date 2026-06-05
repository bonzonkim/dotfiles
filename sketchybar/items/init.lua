local settings = require("settings")

require("items.apple")
-- require("items.menus")
if settings.wm == "yabai" then
    require("items.spaces_yabai")
else
    require("items.spaces_rift")
end
require("items.calendar")
require("items.battery")
require("items.wifi")
require("items.cpu")
require("items.media")
-- require("items.volume")
