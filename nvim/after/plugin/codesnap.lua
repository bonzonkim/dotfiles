local status, snap = pcall(require, "codesnap")
if not status then return end

snap.setup({
  watermark = "",
  bg_padding = 0,
})
