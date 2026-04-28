return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer", "basedpyright", "ruff", "stylua" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- vim.diagnostic.config({ virtual_text = true })
			vim.diagnostic.config({ virtual_lines = true })

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
					workspace = {
						library = {
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
						},
					},
				},
				capabilities = capabilities,
			})
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust_analyzer"] = {
						diagnostics = {
							enable = true,
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
						check = {
							overrideCommand = {
								"cargo",
								"clippy",
								"--workspace",
								"--message-format=json",
								"--all-targets",
								"--all-features",
							},
						},
					},
					capabilities = capabilities,
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			-- vim.lsp.enable("rust_analyzer")
		end,
	},
}
