# riftapi
> ## high-level Mach client wrapper for [rift-wm](https://github.com/acsandmann/rift)
> based on [acsandmann/rift.lua](https://github.com/acsandmann/rift.lua) 

add to `sketchybarrc` or wherever you use it:

```lua
os.execute("[ ! -d $HOME/.local/share/rift.lua/ ] && (git clone https://github.com/acsandmann/rift.lua.git /tmp/rift.lua && cd /tmp/rift.lua/ && make install && rm -rf /tmp/rift.lua/)")

package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.local/share/rift.lua/?.so"
```

then you can just `git clone git@github.com:pyrorhythm/riftapi` into config directory and voila

usage example 
```lua

---@type RiftAPI
local rift     = require("riftapi")

-- ...

item:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
        rift.workspace.create()
    else
        rift.workspace.switch(ws_idx)
    end
end)

-- ...

local function refresh_workspaces()
    local workspaces, err = rift.query.workspaces()
    if not workspaces then
        print("[rift] fetch workspaces failed: " .. tostring(err))
        return
    end

    local key = ws_key(workspaces)
    if key ~= last_ws_key then
        last_ws_key = key
        rebuild_workspaces(workspaces)
    else
        sync_workspace_state(workspaces)
    end
end

-- ...

```
