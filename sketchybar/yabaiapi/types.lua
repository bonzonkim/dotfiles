---@meta

---@class YabaiFrame
---@field x number
---@field y number
---@field w number
---@field h number

---@class YabaiSpace
---@field id                   integer
---@field uuid                 string
---@field index                integer  1-based yabai space index (global)
---@field label                string
---@field type                 "bsp"|"stack"|"float"
---@field display              integer
---@field windows              integer[]  ordered window ids on this space
---@field first-window         integer
---@field last-window          integer
---@field has-focus            boolean
---@field is-visible           boolean
---@field is-native-fullscreen boolean

---@class YabaiWindow
---@field id                   integer
---@field pid                  integer
---@field app                  string   -- display name, e.g. "Brave Browser"
---@field title                string
---@field scratchpad           string
---@field frame                YabaiFrame
---@field role                 string   -- AX role, e.g. "AXWindow"
---@field subrole              string   -- AX subrole, e.g. "AXStandardWindow"
---@field root-window          boolean
---@field display              integer
---@field space                integer  -- 0 if not on any space
---@field level                integer
---@field sub-level            integer
---@field layer                string
---@field sub-layer            string
---@field opacity              number
---@field split-type           "vertical"|"horizontal"|"none"
---@field split-child          "first_child"|"second_child"|"none"
---@field stack-index          integer
---@field can-move             boolean
---@field can-resize           boolean
---@field has-focus            boolean
---@field has-shadow           boolean
---@field has-parent-zoom      boolean
---@field has-fullscreen-zoom  boolean
---@field has-ax-reference     boolean
---@field is-native-fullscreen boolean
---@field is-visible           boolean
---@field is-minimized         boolean
---@field is-hidden            boolean
---@field is-floating          boolean
---@field is-sticky            boolean
---@field is-grabbed           boolean

---@class YabaiDisplay
---@field id     integer
---@field uuid   string
---@field index  integer
---@field label  string
---@field frame  YabaiFrame
---@field spaces integer[]

---Flat window descriptor produced by `Y.query.real_windows_async`.
---@class YabaiRealWindow
---@field space integer
---@field app   string
---@field id    integer

---Per-space layout entry produced by `Y.query.layout_async`.
---@class YabaiLayoutEntry
---@field has_focus boolean
---@field apps      string[]   ordered app display names

---Layout map: space index → entry.
---@alias YabaiLayout table<integer, YabaiLayoutEntry>

---@class YabaiEvents
---@field all YabaiEvent[]

---@class YabaiQuery
---@field spaces         fun(cb: fun(spaces: YabaiSpace[]|nil, err?: string))
---@field windows        fun(cb: fun(windows: YabaiWindow[]|nil, err?: string))
---@field displays       fun(cb: fun(displays: YabaiDisplay[]|nil, err?: string))
---@field is_real_window fun(w: YabaiWindow): boolean
---@field real_windows   fun(cb: fun(wins: YabaiRealWindow[]|nil, err?: string))
---@field layout         fun(cb: fun(layout: YabaiLayout|nil, err?: string))

---@class YabaiCommand
---@field focus_space   fun(idx: integer)
---@field create_space  fun()
---@field destroy_space fun(idx?: integer)
---@field focus_window  fun(id: integer)

---@class YabaiAPI
---@field _sbar           SbarModule|nil
---@field _sbar_get       fun(): SbarModule
---@field attach          fun(sbar: SbarModule)
---@field cli             fun(args: string, cb: fun(result: any, err?: string))
---@field query           YabaiQuery
---@field command         YabaiCommand
---@field events          YabaiEvents
---@field register_events fun()
