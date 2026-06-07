return {
  black       = 0xff1c1c1c,
  white       = 0xfff7f1ff,
  red         = 0xfffc618d,
  green       = 0xff7bd88f,
  blue        = 0xff5ad4e6,
  yellow      = 0xfffce566,
  orange      = 0xfffd9353,
  magenta     = 0xff948ae3,
  grey        = 0xff8b888f,
  transparent = 0x00000000,

  bar = {
    bg     = 0x4a181a22,  -- dark glass, cool tint, translucent
    border = 0x2ab0b8cc,  -- visible glass edge highlight
  },
  popup = {
    bg     = 0xd01c1e24,
    border = 0x50b0b8cc,
    },

  bg_solid = 0xff363537,
    bg0         = 0xaa363537,
   bg05 = 0x5a363537,
  bg1 = 0x1a363537,  -- glass pill fill
  bg2 = 0x0abcc2d0, -- glass pill border
with_alpha = function(color, alpha)
if alpha > 1.0 or alpha < 0.0 then return color end
return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end,
}
