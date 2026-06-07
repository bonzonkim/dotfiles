local colors = require("colors")
local settings = require("settings")

-- KakaoTalk unread badge. Hidden when the app is not running; shows the icon
-- when running and appends the unread count (red) when the dock badge > 0.
local KAKAO_ICON = "󰭹"

local kakao = Sbar.add("item", "widgets.kakao", {
  position = "right",
  icon = {
    string = KAKAO_ICON,
    font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 16.0 },
    color = colors.white,
  },
  label = {
    drawing = false,
    color = colors.red,
    font = { family = settings.font.numbers, style = settings.font.style_map["Bold"], size = 12.0 },
  },
  update_freq = 3,
  padding_right = 3,
  padding_left = 1,
  drawing = false,
})

-- Single shell call: "off" when not running, "on <count>" when running.
local KAKAO_CMD = [[
if pgrep -x KakaoTalk >/dev/null 2>&1; then
  b=$(lsappinfo info -only StatusLabel KakaoTalk 2>/dev/null | grep -oE '"label"="[0-9]+"' | grep -oE '[0-9]+')
  echo "on ${b:-0}"
else
  echo "off"
fi
]]

local function update_kakao()
  Sbar.exec(KAKAO_CMD, function(result)
    if result:find("off") then
      kakao:set({ drawing = false })
      return
    end
    local count = tonumber(result:match("on%s+(%d+)")) or 0
    if count > 0 then
      kakao:set({
        drawing = true,
        icon = { string = KAKAO_ICON, color = colors.white },
        label = { drawing = true, string = tostring(count), color = colors.red },
      })
    else
      kakao:set({
        drawing = true,
        icon = { string = KAKAO_ICON, color = colors.white },
        label = { drawing = false },
      })
    end
  end)
end

kakao:subscribe({ "routine", "system_woke", "front_app_switched" }, update_kakao)

-- Populate immediately on load instead of waiting for the first routine tick.
update_kakao()
