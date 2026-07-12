require("session"):setup({
	sync_yanked = true,
})

-- Filters are per-directory state and survive navigation; clear any
-- leftover filter whenever the cwd changes so they don't stick around
ps.sub("cd", function()
	ya.emit("escape", { filter = true })
end)
