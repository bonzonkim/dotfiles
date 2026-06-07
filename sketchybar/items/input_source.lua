local colors = require("colors")
local settings = require("settings")

-- Fires when macOS switches the active input source (한/영 toggle).
Sbar.add("event", "input_source_change", "AppleSelectedInputSourcesChangedNotification")

-- "한" when a Korean input method is selected, otherwise "EN".
local INPUT_CMD = [[
defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>/dev/null \
  | grep -q "com.apple.inputmethod.Korean" && echo "한" || echo "EN"
]]

local input_source = Sbar.add("item", "widgets.input_source", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "EN",
    color = colors.white,
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    padding_left = 5,
    padding_right = 5,
  },
  update_freq = 2,
  padding_left = 5,
  padding_right = 5,
})

local function update_input()
  Sbar.exec(INPUT_CMD, function(result)
    local label = result:gsub("%s+", "")
    if label ~= "한" and label ~= "EN" then return end
    input_source:set({
      label = {
        string = label,
        color = colors.white,
      },
    })
  end)
end

input_source:subscribe({ "input_source_change", "routine", "system_woke" }, update_input)

-- Populate immediately on load instead of waiting for the first tick.
update_input()
