local status, snap = pcall(require, "snap")
if not status then return end

snap.maps{
  { "<Leader><Leader>", snap.config.file {producer = "ripgrep.file"} },
}
