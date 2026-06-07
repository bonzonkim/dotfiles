local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Memory usage (%) computed from vm_stat: (active + wired + compressor) / total.
-- Matches Activity Monitor's "Memory Used". Polled via update_freq below.
local MEM_CMD = [[
ps=$(pagesize); vm=$(vm_stat);
active=$(echo "$vm" | awk '/Pages active/{gsub(/\./,"",$3);print $3}');
wired=$(echo "$vm" | awk '/Pages wired down/{gsub(/\./,"",$4);print $4}');
comp=$(echo "$vm" | awk '/occupied by compressor/{gsub(/\./,"",$5);print $5}');
total=$(( $(sysctl -n hw.memsize) / ps ));
used=$(( active + wired + comp ));
echo $(( used * 100 / total ))
]]

local ram = Sbar.add("graph", "widgets.ram", 42, {
  position = "right",
  graph = { color = colors.green },
  background = {
    height = 22,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = {
    string = "MEM",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 10.0,
    },
  },
  label = {
    string = "??%",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Medium"],
      size = 10.0,
    },
    align = "right",
    padding_right = 0,
    width = 0,
    y_offset = 4
  },
  update_freq = 5,
  padding_right = settings.paddings + 6
})

ram:subscribe({ "routine", "system_woke" }, function()
  Sbar.exec(MEM_CMD, function(result)
    local load = tonumber(result)
    if not load then return end
    ram:push({ load / 100. })

    local color = colors.green
    if load > 30 then
      if load < 60 then
        color = colors.yellow
      elseif load < 80 then
        color = colors.orange
      else
        color = colors.red
      end
    end

    ram:set({
      graph = { color = color },
      label = { string = load .. "%", align = "right" },
    })
  end)
end)

Sbar.add("bracket", "widgets.ram.bracket", { ram.name }, {
  background = { color = colors.bg05,
    border_color = colors.bg1, border_width = 1 }
})

Sbar.add("item", "widgets.ram.padding", {
  position = "right",
  width = settings.group_paddings
})
