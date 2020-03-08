local jass = require 'jass.common'
local debug = require 'jass.debug'

base = base or {}

function base.CreateTrigger(call_back)
	local trg = jass.CreateTrigger()
	debug.handle_ref(trg)
	jass.TriggerAddAction(trg, call_back)
	return trg
end

function base.DestroyTrigger(trg)
	jass.DestroyTrigger(trg)
	debug.handle_unref(trg)
end
