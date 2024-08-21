return {
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            require('which-key').setup(
                {
                    preset = "helix",
                    delay = 0,
                }
            )
            -- Document existing key chains
            require('which-key').add(
                {
                    { "<leader>c",  group = "Code" },
                    { "<leader>c_", hidden = true },
                    { "<leader>d",  group = "Document" },
                    { "<leader>d_", hidden = true },
                    { "<leader>r",  group = "Rename" },
                    { "<leader>r_", hidden = true },
                    { "<leader>f",  group = "Telescope" },
                    { "<leader>f_", hidden = true },
                    { "<leader>s",  group = "Search" },
                    { "<leader>e", group = "Explorer" , icon = {icon = "󰪶", color = "green"}},
                    { "<leader>e_", hidden = true},
                    { "<leader>s_", hidden = true },
                    { "<leader>t",  group = "Terminal"},
                    { "<leader>t_", hidden = true },
                    { "<leader>w",  group = "Workspace" },
                    { "<leader>w_", hidden = true },
                    { "<leader>x",  group = "Trouble" , icon = {icon = " ", color="orange"}},
                    { "<leader>x_", hidden = true },
                })
        end,
    },
}
