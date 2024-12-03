local cmp = require('cmp');
local cmp_lsp = require("cmp_nvim_lsp");
local capabilities = vim.tbl_deep_extend(
"force",
{},
vim.lsp.protocol.make_client_capabilities(),
cmp_lsp.default_capabilities());

require("fidget").setup({});
require("mason").setup();
require("mason-lspconfig").setup({
	ensure_installed = {
		"csharp_ls",
	},
	handlers = {
		function(server_name) -- default handler (optional)

			require("lspconfig")[server_name].setup {
				capabilities = capabilities
			}
		end,

		["lua_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "Lua 5.1" },
						diagnostics = {
							globals = { "vim", "it", "describe", "before_each", "after_each" },
						}
					}
				}
			}
		end,
		["clangd"] = function()
			local lspconfig = require("lspconfig")
			vim.keymap.set('n', "gh", [[:ClangdSwitchSourceHeader<CR>]], {desc="Switch to source/header file"})
			lspconfig.clangd.setup { }
		end,
	}
});

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

vim.diagnostic.config({
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

local autocmd = vim.api.nvim_create_autocmd;
autocmd('LspAttach', {
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {desc="Go to definition", buffer=e.buf});
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {desc="Show Information about symbol", buffer=e.buf});
		vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, {desc="Code Actions", buffer=e.buf});
		vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, {desc="Rename symbol", buffer=e.buf});
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {desc="Signature Help", buffer=e.buf});
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts);
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts);
	end
});
