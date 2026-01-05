-- Load .vimrc file
local vimrc_path = vim.fn.expand("~/.config/vim/vimrc")

if vim.fn.filereadable(vimrc_path) == 1 then
    vim.cmd('source ' .. vimrc_path)
else
    print("Warning: Vim config not found at " .. vimrc_path)
end

vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.inccommand = 'nosplit'
vim.opt.cursorline = true

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', 
        lazy = false, 
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "python", "lua", "vim" },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true, },
                indent = { enable = true, },
            })
        end,
    },
    {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        vim.o.background = 'dark'
        vim.g.everforest_background = 'hard'
        vim.g.everforest_better_performance = true 
        vim.g.everforest_enable_italic = true
        vim.g.everforest_transparent_background = true
        vim.cmd.colorscheme('everforest')
      end
    },
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {
            delay = 0,

            icons = {
                mappings = vim.g.have_nerd_font,
                keys = vim.g.have_nerd_font and {},
            },

            spec = {
                { '<leader>b', group = '[B]uffer' },
                    { '<leader>bd', desc = '[D]elete [B]uffer' },

                { '<leader>w', desc = '[W]rite (Save)' },
                { '<leader>q', desc = '[Q]uit' },
                { '<leader>\\', desc = 'Vertical Split' },
                { '<leader>-', desc = 'Horizontal Split' },

                { '<leader>f', group = '[F]ind' },
            },
        },
    },
    {
        'nvim-lua/plenary.nvim',
    },
    { 
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' 
    },
    {
        'nvim-telescope/telescope.nvim', 
        tag = 'v0.2.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 
                'nvim-telescope/telescope-fzf-native.nvim', 
                build = 'make' 
            },
        }
    },
    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
})

-- Telescope bindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Find Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
