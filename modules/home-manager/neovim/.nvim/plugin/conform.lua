local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		cpp = { "clang-format" },
		json = { "jq" },
		lua = { "stylua" },
	},
})

vim.keymap.set("n", "<leader>f", conform.format, { desc = "Format buffer" })
