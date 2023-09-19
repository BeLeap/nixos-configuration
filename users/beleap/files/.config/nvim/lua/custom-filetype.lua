local is_helm = function(path)
	local is_helm = false

	if string.find(path, "templates") then
		local parent = vim.fs.dirname(vim.fs.dirname(path))
		is_helm = vim.fs.find("Chart.yaml", {
			path = parent,
			type = "file",
		})
	end

	return is_helm
end

vim.filetype.add({
	pattern = {
		[".*yaml"] = {
			priority = 1,
			function(path)
				if is_helm(path) then
					return "helm"
				elseif string.find(path, "playbook") then
					return "yaml.ansible"
				end
			end,
		},
		[".*%.tpl"] = {
			function(path)
				if is_helm(path) then
					return "helm"
				end
			end,
		},
		[".*mdx"] = {
			"markdown",
		},
	},
})
