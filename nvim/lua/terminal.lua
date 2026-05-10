-- =============================================================================
-- Terminal & Build Commands
-- =============================================================================

local M = {}

-- State
M.term = {
	buf = nil,
	win = nil,
	job_id = nil,
}

-- Terminal settings (disable line numbers)
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Disable line numbers in terminal buffers",
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Open a small bottom terminal
function M.open_terminal()
	-- Reuse existing terminal if valid
	if M.term.buf and vim.api.nvim_buf_is_valid(M.term.buf) then
		if M.term.win and vim.api.nvim_win_is_valid(M.term.win) then
			vim.api.nvim_set_current_win(M.term.win)
			return
		end
		-- Buffer exists but window doesn't - recreate window
		vim.cmd.new()
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 15)
		vim.api.nvim_win_set_buf(0, M.term.buf)
		M.term.win = vim.api.nvim_get_current_win()
		return
	end

	-- Create new terminal
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
	vim.cmd.term()

	M.term.buf = vim.api.nvim_get_current_buf()
	M.term.win = vim.api.nvim_get_current_win()
	M.term.job_id = vim.bo.channel
end

-- Close terminal
function M.close_terminal()
	if M.term.win and vim.api.nvim_win_is_valid(M.term.win) then
		vim.api.nvim_win_close(M.term.win, false)
		M.term.win = nil
	end
end

-- Toggle terminal
function M.toggle_terminal()
	if M.term.win and vim.api.nvim_win_is_valid(M.term.win) then
		M.close_terminal()
	else
		M.open_terminal()
	end
end

-- Send command to terminal
function M.send_command(cmd)
	M.open_terminal()
	if M.term.job_id then
		vim.fn.chansend(M.term.job_id, cmd .. "\r\n")
	end
end

-- =============================================================================
-- Build Commands (customize these)
-- =============================================================================

local commands = {
	build = "echo 'building...'",
	test = "echo 'testing...'",
	run = "echo 'running...'",
}

-- =============================================================================
-- Keymaps
-- =============================================================================

vim.keymap.set("n", "<leader>st", M.toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>b", function()
	M.send_command(commands.build)
end, { desc = "Build project" })
vim.keymap.set("n", "<leader>tr", function()
	M.send_command(commands.run)
end, { desc = "Run project" })
vim.keymap.set("n", "<leader>tt", function()
	M.send_command(commands.test)
end, { desc = "Test project" })

-- Toggle diagnostic float / close floating windows
vim.keymap.set("n", "<leader>.", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, false)
			return
		end
	end
	vim.diagnostic.open_float()
end, { desc = "Toggle diagnostics float" })

return M
