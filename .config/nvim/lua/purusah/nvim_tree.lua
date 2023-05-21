vim.g.nvim_tree_indent_markers = 1 -- this option shows indent markers when folders are open

require('nvim-tree').setup {
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
        highlight_opened_files = "all",
        icons = {
            show = {
                file = false,
                folder = true,
                folder_arrow = true,
                git=true,
            },
        },
		indent_markers = { 
		    enable = true
		}
    },
}

