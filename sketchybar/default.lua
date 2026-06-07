local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
Sbar.default({
    updates = "when_shown",
    icon = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Bold"],
            size = 14.0
        },
        color = colors.white,
        padding_left = settings.paddings,
        padding_right = settings.paddings,
        background = { image = { corner_radius = 9 } },
    },
    label = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Semibold"],
            size = 13.0
        },
        color = colors.white,
        padding_left = settings.paddings,
        padding_right = settings.paddings,
    },
    background = {
        height = 28,
        corner_radius = 9,
        -- border_width = 1,
        -- border_color = colors.bg2,
        image = {
            corner_radius = 9,
        }
    },
    popup = {
        background = {
            color = colors.bar.bg,
        border_color = colors.bar.border,
        border_width = 1,
        corner_radius = 16,
        },
        blur_radius = 48,
    },
    padding_left = 5,
    padding_right = 5,
    scroll_texts = true,
})
