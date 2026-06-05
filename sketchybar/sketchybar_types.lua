---@meta
-- Type annotations for the SketchyBar Lua module (SbarLua).
-- Provides autocomplete and type-checking for lua-language-server.
--
-- Mirrors the CLI property tree documented at:
--   https://felixkratz.github.io/SketchyBar/config/
--
-- Dot-delimited CLI keys (e.g. `icon.font.size`) map to nested Lua tables
--   `{ icon = { font = { size = 14.0 } } }`
--
-- Install: lives alongside sketchybar.so in ~/.local/share/sketchybar_lua/

-- ══════════════════════════════════════════════════════════════════════════════
--  Color helper
-- ══════════════════════════════════════════════════════════════════════════════

---8-digit ARGB hex integer (0xAARRGGBB).
---@alias SbarColor SbarColorTable|integer

-- ══════════════════════════════════════════════════════════════════════════════
--  Font
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarColorTable
---@field red integer?
---@field green integer?
---@field blue integer?
---@field alpha integer?


---@class SbarFontProps
---@field family string?                 e.g. "SF Pro", "Hack Nerd Font"
---@field style  string?                 e.g. "Bold", "Regular", "Semibold", "Heavy"
---@field size   number?                  Font size in points (float)

-- ══════════════════════════════════════════════════════════════════════════════
--  Shadow
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarShadowProps
---@field drawing  boolean|nil           on | off
---@field color    SbarColor|nil          Default 0xff000000
---@field angle    integer|nil            Default 30
---@field distance integer|nil            Default 5

-- ══════════════════════════════════════════════════════════════════════════════
--  Image
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarImageProps
---@field drawing      boolean|nil        on | off
---@field scale        number|nil         Scale factor (default 1.0)
---@field border_color SbarColor|nil      Default 0x00000000
---@field border_width integer|nil        Default 0
---@field corner_radius integer|nil       Default 0
---@field padding_left  integer|nil
---@field padding_right integer|nil
---@field y_offset      integer|nil
---@field string       string|nil         Image path, 'app.<bundle-id>', 'app.<name>', 'media.artwork'
---@field shadow       SbarShadowProps|nil

-- ══════════════════════════════════════════════════════════════════════════════
--  Background
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarBackgroundProps
---@field drawing       boolean|nil        on | off
---@field color          SbarColor|nil      Default 0x00000000
---@field border_color   SbarColor|nil      Default 0x00000000
---@field border_width   integer|nil        Default 0
---@field height         integer|nil        Override background height
---@field corner_radius  integer|nil        Default 0
---@field padding_left   integer|nil
---@field padding_right  integer|nil
---@field y_offset       integer|nil
---@field x_offset       integer|nil
---@field clip           number|nil         Clip mask (0.0–1.0), default 0.0
---@field image          string|SbarImageProps|nil  Image path, 'app.<bundle-id>', 'media.artwork', or sub-table
---@field shadow         SbarShadowProps|nil

-- ══════════════════════════════════════════════════════════════════════════════
--  Text  (shared by icon / label / slider.knob)
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarTextProps
---@field drawing         boolean|nil         on | off
---@field highlight       boolean|nil         on | off
---@field color           SbarColor|nil       Default 0xffffffff
---@field highlight_color SbarColor|nil       Default 0xff000000
---@field padding_left    integer|nil
---@field padding_right   integer|nil
---@field y_offset        integer|nil
---@field font            SbarFontProps|nil   Short form: `{ family, style, size }`
---@field string          string|nil          Displayed text
---@field scroll_duration integer|nil         Scroll speed, default 100
---@field max_chars       integer|nil         Max visible characters (triggers scroll), default 0 = no limit
---@field width           integer|"dynamic"|nil         Fixed width in points (or "dynamic")
---@field align           string|nil          "left" | "center" | "right"
---@field background      SbarBackgroundProps|nil
---@field shadow          SbarShadowProps|nil

-- ══════════════════════════════════════════════════════════════════════════════
--  Popup
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarPopupProps
---@field drawing    boolean|nil           on | off
---@field horizontal boolean|nil           on | off  (horizontal layout, default off)
---@field topmost    boolean|nil           on | off  (default on)
---@field height     integer|nil           Vertical spacing between popup items (default bar height)
---@field blur_radius integer|nil          Default 0
---@field y_offset   integer|nil
---@field align      string|nil            "left" | "right" | "center"
---@field background SbarBackgroundProps|nil

-- ══════════════════════════════════════════════════════════════════════════════
--  Graph  (component-specific additions)
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarGraphProps
---@field graph SbarGraphSub

---@class SbarGraphSub
---@field color      SbarColor|nil  Default 0xffcccccc
---@field fill_color SbarColor|nil  Default 0xffcccccc
---@field line_width number|nil     Default 0.5

-- ══════════════════════════════════════════════════════════════════════════════
--  Slider  (component-specific additions)
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarSliderProps
---@field slider SbarSliderSub

---@class SbarSliderSub
---@field width            integer|nil              Default 100
---@field percentage       integer|nil              Progress 0–100, default 0
---@field highlight_color  SbarColor|nil            Default 0xff0000ff
---@field knob             string|SbarTextProps|nil Knob string or text sub-table
---@field background       SbarBackgroundProps|nil

-- ══════════════════════════════════════════════════════════════════════════════
--  Alias  (component-specific additions)
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarAliasProps
---@field alias SbarAliasSub

---@class SbarAliasSub
---@field color       SbarColor|nil  Override alias color
---@field scale       number|nil     Scale factor (float)
---@field update_freq integer|nil    Update frequency in seconds (default 1)

-- ══════════════════════════════════════════════════════════════════════════════
--  Item  (the full table accepted by add / set / default)
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarItemProps
-- Geometry
---@field drawing             boolean|nil     on | off
---@field position            string|nil      "left" | "right" | "center" | "popup.<parent>"
---@field space               string|nil      Comma-separated space ids, e.g. "1,2,3"
---@field display             string|nil      "active" | "main" | "all" | "1,2,3"
---@field ignore_association  boolean|nil     on | off  (default off)
---@field y_offset            integer|nil
---@field padding_left        integer|nil
---@field padding_right       integer|nil
---@field width               integer|nil     Fixed width in points or "dynamic"
---@field scroll_texts        boolean|nil     Auto-scroll truncated text (default off)
---@field blur_radius         integer|nil
---@field associated_space    integer|nil     (space component) Mission Control space id
---@field associated_display  integer|nil     (space component) Force display id
-- Text-ish
---@field icon                string|SbarTextProps|nil  Icon string or text sub-table
---@field label               string|SbarTextProps|nil  Label string or text sub-table
-- Scripting
---@field script              string|nil      Script path or inline script
---@field click_script        string|nil      Script to run on click
---@field update_freq         integer|nil     Seconds between routine updates (0 = off)
---@field updates             boolean|"when_shown"|nil     on | off | "when_shown"
---@field mach_helper         string|nil      Helper registration string
-- Sub-objects
---@field background          SbarBackgroundProps|nil
---@field popup               SbarPopupProps|nil
-- Component-specific
---@field graph               SbarGraphSub|nil
---@field slider              SbarSliderSub|nil
---@field alias               SbarAliasSub|nil

-- ══════════════════════════════════════════════════════════════════════════════
--  Bar  (the table accepted by Sbar.bar())
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarBarProps
---@field color                SbarColor|nil   Default 0x44000000
---@field border_color         SbarColor|nil   Default 0xffff0000
---@field position             string|nil      "top" | "bottom"
---@field height               integer|nil     Default 25
---@field notch_display_height integer|nil     Override height on notched displays
---@field margin               integer|nil     Default 0
---@field y_offset             integer|nil     Default 0
---@field corner_radius        integer|nil     Default 0
---@field border_width         integer|nil     Default 0
---@field blur_radius          integer|nil     Default 0
---@field padding_left         integer|nil     Default 0
---@field padding_right        integer|nil     Default 0
---@field notch_width          integer|nil     Default 200
---@field notch_offset         integer|nil     Additional y_offset on notched screens
---@field display              string|nil      "main" | "all" | "1,2,3"
---@field hidden               boolean|nil     on | off | "current"
---@field topmost              boolean|nil     on | off | "window"
---@field sticky               boolean|nil     on | off  (default on)
---@field font_smoothing       boolean|nil     on | off  (default off)
---@field shadow               boolean|nil     on | off  (default off)

-- ══════════════════════════════════════════════════════════════════════════════
--  Env  (event callback payload)
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarEnv : table<string, string|table>
---@field NAME      string   Item name that triggered the event
---@field SENDER    string   Event name, e.g. "front_app_switched", "routine"
---@field INFO      string   Event payload; media_change sends JSON-parsed table
---@field BUTTON    string   Mouse button: "left" | "right" | "other"
---@field MODIFIER  string   Modifier key: "shift" | "ctrl" | "alt" | "cmd"
---@field SID       string   Space ID (space events)
---@field DID       string   Display ID (space events)
---@field SELECTED  string   "true" | "false" (space events)
---@field PERCENTAGE string  Volume/brightness percentage (slider events)
---@field SCROLL_DELTA string Scroll wheel delta

-- ══════════════════════════════════════════════════════════════════════════════
--  Item handle  (returned by Sbar.add())
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarItem
---@field name      string                                          Unique item identifier
---@field set       fun(self: SbarItem, props: SbarItemProps)       Apply properties to this item
---@field subscribe fun(self: SbarItem, events: string|string[], cb: fun(env: SbarEnv))  Register event callback(s)
---@field query     fun(self: SbarItem): table                      Query current item properties (returns JSON-parsed table)
---@field push      fun(self: SbarItem, values: number[])           Push float values [0..1] to a graph

-- ══════════════════════════════════════════════════════════════════════════════
--  Module  (the table returned by require("sketchybar"))
-- ══════════════════════════════════════════════════════════════════════════════

---@class SbarModule
local Sbar = {}

---Begin configuration transaction. All add/set/bar/default calls between
---begin_config and end_config are batched into a single IPC message.
function Sbar.begin_config() end

---Commit and apply the configuration transaction.
function Sbar.end_config() end

---Start the Mach IPC event loop. Blocks forever; must be the last call.
function Sbar.event_loop() end

---Enable / disable config hotloading.
---@param enabled boolean
function Sbar.hotload(enabled) end

---Target a different sketchybar instance by name (for multi-bar setups).
---@param name string  e.g. "bottom_bar"
function Sbar.set_bar_name(name) end

---Apply properties to the bar itself.
---@param props SbarBarProps
function Sbar.bar(props) end

---Set default properties inherited by all subsequently created items.
---@param props SbarItemProps
function Sbar.default(props) end

---Set properties on a named item or item handle.
---@param target string|SbarItem
---@param props SbarItemProps
function Sbar.set(target, props) end

---Add a new element. Variants match the CLI `--add <type>`:
---
---| Type      | Signature                                                    |
---|-----------|--------------------------------------------------------------|
---| `item`    | `add("item", [name], props?)`                                |
---| `space`   | `add("space", [name], props?)`                               |
---| `alias`   | `add("alias", [name], props?)`                               |
---| `bracket` | `add("bracket", [name], members: string[], props?)`          |
---| `slider`  | `add("slider", [name], width: integer, props?)`              |
---| `graph`   | `add("graph", [name], width: integer, props?)`               |
---| `event`   | `add("event", name: string, notification?: string)`          |
---
---When `name` is omitted a unique name is auto-generated.
---
---@overload fun(type: '"item"', props?: SbarItemProps): SbarItem
---@overload fun(type: '"item"', name: string, props?: SbarItemProps): SbarItem
---@overload fun(type: '"space"', props?: SbarItemProps): SbarItem
---@overload fun(type: '"space"', name: string, props?: SbarItemProps): SbarItem
---@overload fun(type: '"alias"', props?: SbarItemProps): SbarItem
---@overload fun(type: '"alias"', name: string, props?: SbarItemProps): SbarItem
---@overload fun(type: '"bracket"', members: string[], props?: SbarItemProps): SbarItem
---@overload fun(type: '"bracket"', name: string, members: string[], props?: SbarItemProps): SbarItem
---@overload fun(type: '"slider"', width: integer, props?: SbarItemProps): SbarItem
---@overload fun(type: '"slider"', name: string, width: integer, props?: SbarItemProps): SbarItem
---@overload fun(type: '"graph"', width: integer, props?: SbarItemProps): SbarItem
---@overload fun(type: '"graph"', name: string, width: integer, props?: SbarItemProps): SbarItem
---@overload fun(type: '"event"', name: string, notification?: string): SbarItem
---@return SbarItem
function Sbar.add(type, ...) end

---Remove an item by name or item handle.
---@param target string|SbarItem
function Sbar.remove(target) end

---Subscribe to events on a named item or item handle.
---
---Common events:
---  `front_app_switched`, `space_change`, `space_windows_change`, `display_change`,
---  `volume_change`, `brightness_change`, `power_source_change`, `wifi_change`,
---  `media_change`, `system_will_sleep`, `system_woke`,
---  `mouse.entered`, `mouse.exited`, `mouse.entered.global`, `mouse.exited.global`,
---  `mouse.clicked`, `mouse.scrolled`, `mouse.scrolled.global`
---
---@param target   string|SbarItem
---@param events   string|string[]  Event name(s), e.g. "front_app_switched", {"routine", "forced"}
---@param callback fun(env: SbarEnv)  Called when event fires; receives environment table
function Sbar.subscribe(target, events, callback) end

---Query properties of an item. Returns a JSON-parsed Lua table mirroring the
---full property tree (icon.color, label.string, etc.).
---@param target string|SbarItem
---@return table
function Sbar.query(target) end

---Push an array of float values [0..1] to a graph item.
---@param target string|SbarItem
---@param values number[]
function Sbar.push(target, values) end

---Animate property changes within the callback.
---All `set` / `bar` calls inside the callback are animated with the given curve
---and duration (duration = frame count on 60 Hz display, i.e. seconds = frames / 60).
---
---Curves: "linear", "quadratic", "tanh", "sin", "exp", "circ"
---
---@param curve    "linear"|"quadratic"|"tanh"|"sin"|"exp"|"circ"    Animation curve
---@param duration integer   Frame count
---@param callback fun()     Animated set/bar calls go here
function Sbar.animate(curve, duration, callback) end

---Trigger a custom event, optionally with environment variables.
---@param event string        Event name (must have been added via `add("event", ...)`)
---@param env?  table         Optional key-value pairs exposed as env vars in scripts
function Sbar.trigger(event, env) end

---Execute a shell command asynchronously. Does NOT block the event loop.
---The callback receives the command's stdout as the first argument.
---If stdout is valid JSON it is auto-parsed into a Lua table.
---@param command   string                                          Shell command string
---@param callback? fun(result: string|table, exit_code: integer)   Optional completion handler
function Sbar.exec(command, callback) end

---Schedule a function to run after a delay (seconds). Non-blocking.
---@param seconds  number
---@param callback fun()
function Sbar.delay(seconds, callback) end

return Sbar
