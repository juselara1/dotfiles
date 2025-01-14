return {
	setup = function ()
		local langs = {"lua"}
		for _, lang in ipairs(langs) do
			require(lang).setup()
		end
	end
}
