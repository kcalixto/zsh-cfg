return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			format = { enable = true },
			validate = true,
			-- Disable default Red Hat telemetry tracking
			telemetry = { enable = false },
			-- Add schemas manually or use SchemaStore.nvim (recommended)
			-- schemas = {
			-- 	kubernetes = "*.k8s.yaml",
			-- 	["https://schemastore.org"] = ".github/workflows/*",
			-- },
		},
	},
}
