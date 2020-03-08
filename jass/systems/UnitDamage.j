
function UnitDamage_Conditions takes nothing returns boolean
	local unit u = GetEventDamageSource()
	local unit uc = null
	local unit ut = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(u)
	local location loc2 = GetUnitLoc(ut)
	local real damage = GetEventDamage()
	local trigger t = null

    if damage == 5.93 then
        call wanChuEffect()
    endif

	if damage == 5.41 then
        call wuDuZhouDamage()
    endif

	set t = null
	set u = null
	set ut = null
	set uc = null
	set loc = null
	set loc2 = null
	set p = null
	return false
endfunction




//任意单位伤害事件系统
function UnitDamage takes nothing returns nothing
	local trigger t = CreateTrigger()

	call YDWESyStemAnyUnitDamagedRegistTrigger( t )
	call TriggerAddCondition(t,Condition(function UnitDamage_Conditions))
	set t = null
endfunction
