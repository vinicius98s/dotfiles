return {
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}
