--------------------------------
-- Common functions
--------------------------------
local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


--------------------------------
-- Plugins
--------------------------------
require("packer").startup(function(use)
    -- Let packer to manage itself
    use "wbthomason/packer.nvim"

    -- Code style
    use {"numirias/semshi", run = ":UpdateRemotePlugins"} -- Python syntax highlight
    use {"sheerun/vim-polyglot", event="VimEnter"}
    use "dense-analysis/ale"
    use {'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end}
    use {"winston0410/commented.nvim", config = function() require("commented").setup() end}

    -- Color scheme
    use "navarasu/onedark.nvim"

    -- Utilities
    use "nvim-lualine/lualine.nvim"
    use "nvim-tree/nvim-tree.lua"
    use "junegunn/fzf.vim"
end)


--------------------------------
-- Colors
--------------------------------
require("onedark").setup {
    style = "deep",
    transparent = true,
    lualine = {
        transparent = true,
    },
    highlights = {
        ["Whitespace"] = {fg = "$bg_d"},
    }
}
require("onedark").load()


--------------------------------
-- Statusline
--------------------------------
require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = "onedark",
        disabled_filetypes = {
            statusline = {"packer", "NvimTree"},
        },
    }
}


--------------------------------
-- ALE
--------------------------------
vim.g.ale_fix_on_save = 1

vim.g.ale_linters = {
    python = {"ruff"},
}
vim.g.ale_fixers = {
    -- ["*"] = {"remove_trailing_lines", "trim_whitespace"},
    ["*"] = {"remove_trailing_lines"},
    go = {"gofmt"},
    python = {"black", "isort"},
    terraform = {"terraform"},
}


--------------------------------
-- NvimTree
--------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
    renderer = {
        highlight_git = true,
        icons = {
            git_placement = "signcolumn",
            show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                symlink = "➛",
                folder = {
                    arrow_closed = "›",
                    arrow_open = "⏷",
                },
                git = {
                    unstaged = "*",
                    staged = "~",
                    unmerged = "!",
                    renamed = "➜",
                    untracked = "+",
                    deleted = "-",
                    ignored = "◌",
                },
            },
        },
        special_files = {},
    },
}


--------------------------------
-- Polyglot
--------------------------------
vim.g.polyglot_disabled = {"python", "python-indent"}

vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_function_parameters = 1
vim.g.go_highlight_types = 1


--------------------------------
-- Custom mappings
--------------------------------
map("i", "<Home>", "<C-o>^") -- Move to text start in insert mode
map("n", "<Home>", "^") -- Move to text start in normal mode
map("n", "<leader>h", ":noh<CR>") -- Clear search highligths
map("", "<C-p>", ":Files<CR>") -- Trigger fzf like ctrlp
map("", "<F2>", ":NvimTreeToggle<CR>") -- Toggle tree view explorer
