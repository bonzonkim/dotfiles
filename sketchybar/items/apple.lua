

local icons = require("icons")
local colors = require("colors")
local logger = require("helpers.logger")
local settings = require("settings")

local apple = {}

apple.logo = Sbar.add("item", "apple.logo", {
	padding_left = 10,
    padding_right = 10,
    y_offset = 1,
	icon = {
		string = icons.apple,
		font = {
			style = "Semibold",
			size = 20.0,
		},
        color = colors.white,
	},
	label = {
		drawing = false,
	},
	popup = {
		height = 0,
	},
})

SETUP_POPUP(apple.logo)

local function add_apple_item(name, icon_string, label_string, click_cmd)
    local item = Sbar.add("item", "apple." .. name, {
		position = "popup." .. apple.logo.name,
		icon = {
			string = icon_string,
            width = 24,
			padding_right = 4,
			align = "center",
		},
        label = {
            string = label_string,
            font = {
                family = settings.font.text_round,
                style = "Medium",
            },
            padding_right = 4,
            align = "right",
		},
		background = {
			color = 0x00000000,
            height = 30,
			padding_right = 4,
			drawing = true,
		},
	})

	item:subscribe("mouse.clicked", function(_)
		logger.debug("apple", "menu_item_clicked", { item = "apple." .. name })
		Sbar.exec(click_cmd)
		apple.logo:set({ popup = { drawing = false } })
    end)

    SETUP_ITEM_HOVER(
        item,
        {background = {color = colors.bg0}},
        {background = {color = 0x00000000}}
	)

	return item
end

apple.prefs = add_apple_item("prefs", icons.preferences, "Preferences", "open -a 'System Preferences'")
apple.activity = add_apple_item("activity", icons.activity, "Activity", "open -a 'Activity Monitor'")

apple.lock = add_apple_item(
	"lock",
	icons.lock,
	"Lock Screen",
	'osascript -e \'tell application "System Events" to keystroke "q" using {command down,control down}\''
)
apple.logout = add_apple_item(
	"logout",
	icons.logout,
	"Logout",
	'osascript -e \'tell application "System Events" to keystroke "q" using {command down,shift down}\''
)
apple.sleep = add_apple_item("sleep", icons.sleep, "Sleep", "osascript -e 'tell app \"System Events\" to sleep'")
apple.reboot =
	add_apple_item("reboot", icons.reboot, "Reboot", "osascript -e 'tell app \"loginwindow\" to «event aevtrrst»'")
apple.shutdown =
	add_apple_item("shutdown", icons.power, "Shutdown", "osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'")
