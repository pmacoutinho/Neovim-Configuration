return {
  'goolord/alpha-nvim',
    config = function ()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        }

        -- Logo colour: the desktop theme's accent, set in colorscheme.lua.
        if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = "headerArt" })) then
            vim.api.nvim_set_hl(0, "headerArt", { fg = "#F5C2E7", bg = "NONE" })
        end
        dashboard.section.header.opts = {
            hl = "headerArt",
            position = "center",
        }

        alpha.setup(dashboard.opts)
    end
}