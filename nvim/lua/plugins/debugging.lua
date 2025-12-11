local dap = require 'dap'
local dapui = require 'dapui'

require('dap-go').setup {
  dap_configurations = {
    {
      type = 'go',
      name = 'Debug (Sem otimizar deps)',
      request = 'launch',
      program = '${file}',
      -- O segredo está aqui: removemos o "all="
      -- Isso aplica -N -l apenas ao seu código, deixando as libs (sonic) compilarem normal.
      buildFlags = "-gcflags '-N -l'",
    },
  },
}
require('dapui').setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<F5>', dap.continue, {})
vim.keymap.set('n', '<S-F5>', dap.terminate, {})
