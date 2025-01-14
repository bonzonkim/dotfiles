local status, renderMarkdown = pcall(require, "render-markdown")
if not status or renderMarkdown then return end

renderMarkdown.setup({
  file_types = { 'markdown', 'quarto' },
  enabled = true,
})
