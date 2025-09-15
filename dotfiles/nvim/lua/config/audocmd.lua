vim.api.nvim_create_autocmd('TermOpen', {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})
