-- Colourscheme from the desktop theme (theme-set / SUPER+CTRL+T in the
-- dotfiles). Reads ~/.local/state/theme/current/nvim.lua, and re-reads it when
-- theme-set sends SIGUSR1, so open editors switch along with everything else.
-- Without a desktop theme it falls back to Catppuccin, as before.
local theme_file = vim.fn.expand("~/.local/state/theme/current/nvim.lua")

local function read_theme()
    local ok, theme = pcall(dofile, theme_file)
    if ok and type(theme) == "table" and theme.colorscheme then
        return theme
    end
    return { colorscheme = "catppuccin-mocha", lualine = "dracula" }
end

local function apply()
    local theme = read_theme()
    if theme.colorscheme == "aether" and theme.palette then
        local ok, aether = pcall(require, "aether")
        if ok then
            aether.setup({ colors = theme.palette })
        end
    end
    if not pcall(vim.cmd.colorscheme, theme.colorscheme) then
        vim.cmd.colorscheme("catppuccin-mocha")
    end
    local ok, lualine = pcall(require, "lualine")
    if ok and lualine.get_config then
        local config = lualine.get_config()
        config.options.theme = theme.lualine or "auto"
        lualine.setup(config)
    end
end

-- lualine.lua reads this for its initial theme.
vim.g.desktop_theme_lualine = read_theme().lualine or "dracula"

-- The start screen's NeoVim logo (alpha.lua's "headerArt") in the theme's
-- accent colour, re-set after every colourscheme change since those clear it.
local function logo_colour()
    vim.api.nvim_set_hl(0, "headerArt", { fg = read_theme().accent or "#F5C2E7", bg = "NONE" })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = logo_colour })

vim.api.nvim_create_autocmd("Signal", {
    pattern = "SIGUSR1",
    callback = function()
        vim.schedule(apply)
    end,
})

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
            apply()
        end,
    },
    -- Loaded by lazy.nvim when their colourscheme is applied.
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { transparent = true },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        opts = { styles = { transparency = true } },
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        opts = { transparent_mode = true },
    },
    {
        -- Omarchy's pick for Osaka Jade.
        "ribru17/bamboo.nvim",
        lazy = true,
        opts = { transparent = true },
    },
    {
        "Mofiqul/dracula.nvim",
        lazy = true,
        opts = { transparent_bg = true },
    },
    {
        "neanias/everforest-nvim",
        main = "everforest",
        lazy = true,
        opts = { transparent_background_level = 2 },
    },
    {
        -- The Snow theme's pick: light and monochrome.
        "bjarneo/snow.nvim",
        name = "snow",
        lazy = true,
    },
    {
        -- Omarchy's palette-based colourscheme, used by the Black & White theme.
        "omacom/aether.nvim",
        branch = "v3",
        name = "aether",
        lazy = true,
    },
}
