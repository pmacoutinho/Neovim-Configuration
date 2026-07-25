-- nvim-treesitter `main` branch: a full rewrite, incompatible with `master`.
-- `master` is frozen (archived 2025-05-18) and breaks on Nvim 0.12 -- its query
-- predicates assume `match[id]` is a single TSNode, but it is a list since 0.11.
local ensure_installed = {
    "bash", "bibtex", "c", "cmake", "cpp", "css", "csv", "dart", "desktop",
    "dockerfile", "elixir", "gitignore", "go", "gomod", "haskell", "html",
    "hyprlang", "ini", "java", "javascript", "json", "kotlin", "lua", "make",
    "markdown", "markdown_inline", "php", "python", "query", "regex",
    "requirements", "ruby", "rust", "scss", "ssh_config", "tmux", "toml",
    "tsx", "typescript", "vim", "vimdoc", "yaml",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- `main` does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.setup()

        -- `main` dropped tmux from its parser registry, so register it by hand.
        -- Its queries are vendored in ~/.config/nvim/queries/tmux/ (copied from
        -- the frozen `master` branch; they use only the standard `#set!`).
        vim.api.nvim_create_autocmd("User", {
            pattern = "TSUpdate",
            callback = function()
                require("nvim-treesitter.parsers").tmux = {
                    install_info = {
                        url = "https://github.com/Freed-Wu/tree-sitter-tmux",
                        revision = "0252ecd080016e45e6305ef1a943388f5ae2f4b4",
                    },
                }
            end,
        })

        -- `main` dropped `auto_install`; parsers are installed explicitly.
        -- No-op once they are present.
        ts.install(ensure_installed)

        -- `main` dropped the `highlight` and `indent` modules. Highlighting is
        -- Neovim's own (`:h treesitter-highlight`); indent is still provided by
        -- the plugin but is considered experimental.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                if not pcall(vim.treesitter.start, args.buf) then
                    return -- no parser for this filetype
                end
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
