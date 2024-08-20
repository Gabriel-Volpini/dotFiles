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

local snippets, autosnippets = {}, {}
-- local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })

table.insert(
	snippets,
	s(
		"snippet",
		fmta(
			[=[
                table.insert(snippets, s("<trigger>", fmta([[<snippet>]],{<data>})))
            ]=],
			{
				trigger = i(1),
				snippet = i(2),
				data = i(0),
			}
		)
	)
)

table.insert(
	snippets,
	s(
		"autosnippets",
		fmta(
			[=[
                table.insert(autosnippets, s("<trigger>", fmta([[<snippet>]],{<data>})))
            ]=],
			{
				trigger = i(1),
				snippet = i(2),
				data = i(0),
			}
		)
	)
)

return snippets, autosnippets
