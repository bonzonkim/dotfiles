local status, simulators = pcall(require, "simulators")
if not status then return end

simulators.setup({
  android_emulator = false,
  apple_simulator = true,
})
