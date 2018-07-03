local act = function()
	error("Hello, World!")
	core.request_shutdown()
end
minetest.after(0, act)
