require('neogit').setup {
	disable_commit_confirmation = true,
	signs = {
		-- { CLOSED, OPENED }
		section = {"▷","▼"},
		item = {"▷","▼"}
	}
}

