local set = vim.keymap.set

local hooks = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    local installed_or_updated = (kind == "install" or kind == "update")

    if name == "telescope-fzf-native.nvim" and installed_or_updated then
        vim.system({ "make" }, { cwd = ev.data.path })
    end

    if name == "nvim-treesitter" and installed_or_updated then
        if not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd("TSUpdate")
    end

    if name == "blink.cmp" and installed_or_updated then
        if not ev.data.active then
            vim.cmd.packadd("blink.lib")
            vim.cmd.packadd("blink.cmp")
        end
        vim.notify("Building blink.cmp")
        require("blink.cmp").build():wait(60000)
        vim.notify("Finished building blink.cmp")
    end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})
local telescope = require("telescope")
telescope.setup()
telescope.load_extension("fzf")
local telescope_builtin = require("telescope.builtin")

set("n", "<C-f>", telescope_builtin.find_files)
set("n", "<C-g>", telescope_builtin.live_grep)
set("n", "<leader>fw", telescope_builtin.grep_string)
set("n", "<leader>fq", telescope_builtin.quickfix)

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
local function setup_python_lsp()
    if vim.fn.executable("ty") == 1 then
        vim.lsp.enable("ty")
    elseif vim.fn.executable("pyright-langserver") == 1 or vim.fn.executable("pyright") == 1 then
        vim.lsp.enable("pyright")
    elseif vim.fn.executable("uvx") == 1 then
        vim.lsp.config("ty", { cmd = { "uvx", "ty", "server" } })
        vim.lsp.enable("ty")
    else
        vim.notify("No Python type checker found (ty/pyright/uvx)", vim.log.levels.WARN)
    end

    if vim.fn.executable("ruff") == 0 then
        vim.lsp.config("ruff", { cmd = { "uvx", "ruff", "server" } })
    end
    vim.lsp.enable("ruff")
end
setup_python_lsp()

vim.lsp.config["lua_ls"] = {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                },
            },
        },
    },
}
vim.lsp.enable("lua_ls")

vim.schedule(function()
    vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })
    require("blink.cmp").setup({
        keymap = {
            ["<C-j>"] = {
                function(cmp)
                    return cmp.scroll_documentation_down(4)
                end,
            },
            ["<C-k>"] = {
                function(cmp)
                    return cmp.scroll_documentation_up(4)
                end,
            },
        },
        cmdline = { enabled = false },
        signature = { enabled = true, window = { border = "single" } },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            menu = {
                draw = {
                    columns = {
                        { "label", gap = 1 },
                        { "kind_icon", "kind", "source_name", gap = 1 },
                    },
                },
            },
            accept = { auto_brackets = { enabled = false } },
            documentation = {
                auto_show_delay_ms = 0,
            },
        },
    })
end)

vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
require("nvim-web-devicons").setup()

vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})
require("nvim-treesitter")
require("treesitter-context")
local textobjects = require("nvim-treesitter-textobjects")
set({ "x", "o" }, "af", function()
    textobjects.select_textobject("@function.outer", "textobjects")
end)
set({ "x", "o" }, "if", function()
    textobjects.select_textobject("@function.inner", "textobjects")
end)
set({ "x", "o" }, "ac", function()
    textobjects.select_textobject("@class.outer", "textobjects")
end)
set({ "x", "o" }, "ic", function()
    textobjects.select_textobject("@class.inner", "textobjects")
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local filetype = vim.bo.filetype
        if filetype and filetype ~= "" then
            pcall(vim.treesitter.start)
        end
    end,
})

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
local gitsigns = require("gitsigns")
gitsigns.setup({
    current_line_blame_opts = {
        delay = 50,
    },
})
set("n", "<leader>pd", gitsigns.preview_hunk_inline)
set("n", "<leader>rh", gitsigns.reset_hunk)
set("n", "<leader>ph", function()
    gitsigns.nav_hunk("prev")
end)
set("n", "<leader>nh", function()
    gitsigns.nav_hunk("next")
end)
set("n", "<leader>gb", gitsigns.toggle_current_line_blame)

vim.pack.add({ "https://github.com/linrongbin16/gitlinker.nvim" })
require("gitlinker").setup({ highlight_duration = 0 })
set({ "n", "v" }, "<leader>cgl", require("gitlinker").link)

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        htmldjango = { "djlint" },
        json = { "jq" },
        python = { "ruff_format", "ruff_organize_imports" },
        go = { "gofmt" },
        lua = { "stylua" },
    },
})
set({ "n", "v" }, "<leader>fc", function()
    conform.format({ async = true, lsp_fallback = true })
end)

vim.pack.add({ { src = "https://github.com/theprimeagen/harpoon", version = "harpoon2" } })

local harpoon = require("harpoon")
harpoon:setup()
local function get_harpoon_statusline()
    local marks_length = harpoon:list():length()
    if marks_length == 0 then
        return ""
    end
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    local contents = {}
    for index = 1, marks_length do
        local harpoon_file_path = harpoon:list():get(index).value
        local file_name = vim.fn.fnamemodify(harpoon_file_path, ":t")

        if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#Search# %s. %%#Search#%s %%#Statusline#", index, file_name)
        else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
        end
    end

    return table.concat(contents)
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "User" }, {
    callback = function(_)
        local harpoon_files = get_harpoon_statusline()
        if harpoon_files ~= "" then
            vim.o.tabline = harpoon_files
        end
    end,
})

set("n", ",,", function()
    harpoon:list():add()
end)
set("n", ",w", function()
    harpoon.ui:toggle_quick_menu(require("harpoon"):list())
end)
set("n", ",a", function()
    harpoon:list():select(1)
end)
set("n", ",s", function()
    harpoon:list():select(2)
end)
set("n", ",d", function()
    harpoon:list():select(3)
end)
set("n", ",f", function()
    harpoon:list():select(4)
end)
set("n", ",g", function()
    harpoon:list():select(5)
end)

vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup({
    progress = {
        display = {
            done_icon = "",
        },
    },
    notification = {
        window = {
            winblend = 0,
        },
    },
})

vim.pack.add({ "https://github.com/ntpeters/vim-better-whitespace" })

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
    options = {
        section_separators = { "", "" },
        component_separators = { "|", "|" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { { "mode", upper = true } },
        lualine_b = { { "branch", icon = "" }, { "diagnostics" } },
        lualine_c = { { "filename", file_status = true } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "diff", "diagnostics" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    winbar = {
        lualine_c = { "filename" },
    },
    inactive_winbar = {
        lualine_c = { "filename" },
    },
})

vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("nvim-autopairs").setup({ check_ts = true })

vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
require("colorizer").setup()
