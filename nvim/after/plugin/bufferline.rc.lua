local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    theme = 'night-owl',
  },
--  highlights = {
--    separator = {
----      fg = '#073642',
----     bg = '#002b36',
--      fg = '#abb2bf',
--      bg = '#1a1b26',
--    },
--    separator_selected = {
--      --fg = '#073642',
--      fg = '#abb2bf',
--    },
--    background = {
--      --fg = '#657b83',
--      --bg = '#002b36'
--      fg = '#abb2bf',
--      bg = '#1a1b26',
--    },
--    buffer_selected = {
--      fg = '#fdf6e3',
--      --fg = '#282a36',
--      italic = false
--    },
--    fill = {
--      -- bg = '#073642'
--      bg = '#1a1b26'
--    }
--  },
})

vim.api.nvim_set_keymap('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.api.nvim_set_keymap('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
