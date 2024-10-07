local options = {

    base46 = {
        theme = "one_light",
        hl_add = {},
        hl_override = {},
        integrations = {},
        changed_themes = {},
        transparency = false,
        theme_toggle = { "catppuccin", "one_light" },
    },

    ui = {
        cmp = {
            icons = true,
            lspkind_text = true,
            style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
        },

        telescope = { style = "bordered" }, -- borderless / bordered

        statusline = {
            theme = "vscode_colored",
            separator_style = "default",
            order = nil,
            modules = nil,
        },

        -- lazyload it when there are 1+ buffers
        tabufline = {
            enabled = true,
            lazyload = true,
            order = { "treeOffset", "buffers", "tabs", "btns" },
            modules = nil,
        },

        
    },
    nvdash = {
        load_on_startup = true,

        header = {
            -- "           ▄ ▄                   ",
            -- "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            -- "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            -- "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            -- "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            -- "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            -- "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            -- "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            -- "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
            "nvim 0.10",
            "",
        },

        buttons = {
            { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
            { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
            { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
            { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
            { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
            { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

        },
    },
    term = {
        winopts = { number = false, relativenumber = false },
        sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
        float = {
            relative = "editor",
            row = 0.3,
            col = 0.25,
            width = 0.5,
            height = 0.4,
            border = "single",
        },
    },

    lsp = { signature = true },

    cheatsheet = {
        theme = "grid",                                                   -- simple/grid
        excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
    },

    mason = { cmd = true, pkgs = {} },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
