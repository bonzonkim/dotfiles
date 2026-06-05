local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
Sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = Sbar.add("item", {
  icon = {
    color = colors.white,
    padding_left = 8,
    y_offset = 0.5,
    font = {
      style = settings.font.style_map["Bold"],
      size = 11.0,
    },
  },
  label = {
    color = colors.white,
    padding_right = 8,
    width = 49,
        align = "right",
        y_offset = 1,
    font = { family = settings.font.numbers, size = 12, },
  },
  position = "right",
  update_freq = 30,
  padding_left = 1,
  padding_right = 1,
  background = {
      color         = colors.bg05,
      border_color  = colors.bg1,
    border_width = 1
  },
  click_script = "open -a 'Calendar'"
})

-- Double border for calendar using a single item bracket
Sbar.add("bracket", { cal.name }, {
  background = {
    color = colors.transparent,
    height = 30,
    border_color = colors.bg2,
  }
})

-- Padding item required because of bracket
Sbar.add("item", { position = "right", width = settings.group_paddings })

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  cal:set({ icon = os.date("%a. %d %b."), label = os.date("%H:%M") })
end)
