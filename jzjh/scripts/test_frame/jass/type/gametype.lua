---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2018/11/06 11:47
---

local gametype = {}

local mt = {}
gametype.__index = mt

mt.type = 'gametype'
mt.name = ''

function gametype.init()
	local gametype_names={}
	for i = 1, #gametype_names do
		local ga = {}
		ga.name = gametype_names[i]
		setmetatable(ga, gametype)
		table.insert(gametype, ga)
	end
end

return gametype