---@class RiftClientHandle
---@field send_request  fun(self: RiftClientHandle, json: string, await?: boolean): table|nil, string|nil
---@field subscribe     fun(self: RiftClientHandle, events: string[], cb: fun(env: RiftEvent)): boolean|nil, string|nil
---@field unsubscribe   fun(self: RiftClientHandle, event: string): boolean|nil, string|nil
---@field reconnect     fun(self: RiftClientHandle): RiftClientHandle|nil, string|nil
---@field disconnect    fun(self: RiftClientHandle)

---@class RiftEvent
---@field EVENT string
---@field INFO  string
---@field DATA  table

---@class RiftWindow
---@field app_name   string|nil
---@field title      string|nil
---@field is_focused boolean

---@class RiftWorkspace
---@field index       integer       0-based index
---@field id          integer|nil
---@field name        string|nil
---@field is_active   boolean
---@field layout_mode string|nil
---@field windows     RiftWindow[]|nil

---@class RiftDisplay
---@field id         integer
---@field uuid       string
---@field name       string|nil
---@field is_primary boolean
---@field frame      {x:number,y:number,w:number,h:number}|nil

---@class RiftApplication
---@field name      string
---@field bundle_id string|nil
---@field is_active boolean

---@class RiftLayoutState
---@field mode      string
---@field root      table|nil
---@field workspace integer|nil

---@class RiftMetrics
---@field fps        number|nil
---@field frame_time number|nil

---@class RiftConfig
---@field settings    table|nil
---@field keybindings table|nil
