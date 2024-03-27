local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
--
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

ls.filetype_extend("typescriptreact", { "javascript" })
ls.filetype_extend("typescript", { "javascript" })

ls.filetype_extend("lua", { "javascript" })

local snippets, autosnippets = {}, {}
-- local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })

table.insert(
	autosnippets,
	s(
		{ trig = "if", regTrig = false, hidden = true },
		fmta(
			[[
       if(<condition>) {
            <content>
       }
       <after>
        ]],
			{
				condition = i(1),
				content = i(2),
				after = i(0),
			}
		)
	)
)

table.insert(
	snippets,
	s(
		"rfc",
		fmta(
			[[
interface <name>Props {
  <type>
}

export const <componentName> = ({<props>}: <propsName>Props) <arrow> {
    <state>

    return(
        <content>
    )
}
]],
			{
				name = i(1),
				type = i(2),
				state = i(3),
				componentName = rep(1),
				props = f(function(args)
					local parts = {}
					for _, value in ipairs(args[1]) do
						local a = vim.split(value, ":")
						local part = a[1] or ""
						part = vim.trim(part)
						if part ~= "" then
							table.insert(parts, part)
						end
					end
					return table.concat(parts, ", ")
				end, 2),
				propsName = rep(1),
				arrow = t("=>"),
				content = f(function(args)
					return "<div>Hello from " .. args[1][1] .. "</div>"
				end, 1),
			}
		)
	)
)

-- const ola mari =
-- c(1, {
-- 	t("Ugh boring, a text node"),
-- 	i(nil, "At least I can edit something now..."),
-- 	f(function(args)
-- 		return "Still only counts as text!!"
-- 	end, {}),
-- })
--
return snippets, autosnippets
