-- Bootstrap lazy.nvim (clones the stable branch on first launch) and load every
-- spec under lua/plugins/. See https://lazy.folke.io.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- `nvim <dir>`: Oil lists the directory asynchronously, so its callback would
-- queue behind the ~200 ms synchronous burst of VeryLazy plugin loads and the
-- listing would appear late. When starting on a directory, fire VeryLazy only
-- after Oil has drawn (OilEnter), with a timeout fallback. `:e .` is unaffected.
if vim.fn.argc(-1) == 1 and vim.fn.isdirectory(vim.fn.argv(0, -1)) == 1 then
  local Util = require('lazy.core.util')
  Util.very_lazy = function()
    local done = false
    local function load()
      if done or vim.v.exiting ~= vim.NIL then
        return
      end
      done = true
      vim.g.did_very_lazy = true
      Util.track({ event = 'VeryLazy' })
      vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy', modeline = false })
      Util.track()
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'OilEnter',
      once = true,
      callback = function()
        vim.cmd.redraw() -- paint the listing before the plugin-load burst
        vim.schedule(load)
      end,
    })
    vim.defer_fn(load, 500) -- fallback if Oil never fires OilEnter
  end
end

require('lazy').setup({
  spec = {
    { import = 'plugins' }, -- auto-import every lua/plugins/*.lua
  },
  defaults = {
    lazy = true, -- specs are lazy by default; opt into eager with lazy = false
    version = false, -- always use the latest commit (themes/tools move fast)
  },
  -- Install the hackertheme look during headless installs so the UI matches.
  install = { colorscheme = { 'hackertheme', 'tokyonight', 'habamax' } },
  checker = {
    enabled = true, -- periodically check for plugin updates …
    notify = false, -- … but don't nag on every startup
  },
  change_detection = { notify = false },
  ui = { border = 'rounded' },
  -- None of our plugins need luarocks; disabling it silences the hererocks
  -- ❌ in :checkhealth lazy and avoids an unused dependency.
  rocks = { enabled = false },
  performance = {
    rtp = {
      -- Disable some built-in runtime plugins for a faster startup.
      disabled_plugins = {
        'gzip', 'tarPlugin', 'zipPlugin', 'tohtml', 'tutor',
      },
    },
  },
})

-- Convenience: open the lazy.nvim UI.
vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>', { desc = 'Lazy plugin manager' })
