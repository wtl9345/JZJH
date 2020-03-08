globals
  
endglobals


//使用技能系统
function UseAbility_Conditions takes nothing returns boolean
	local integer id = GetSpellAbilityId()
	local unit u = GetTriggerUnit()
	local unit ut = GetSpellTargetUnit()
    local unit last = null
	local player p = GetOwningPlayer(u)
	local integer i = GetPlayerId(p)
	local timer t = null
	local real r = 0
	local integer j = 0
	local real range = 500
	local real rand = 0
	local integer randInt = 0
	local group g = null
    local integer life = 0

    // 五毒教：五毒笛咒
    if id == WU_DU_ZHOU then
        call wuDuZhou()
    endif

    // 五毒教：补天心经
    if id == BU_TIAN_JING then
        call buTianJing()
    endif

    // 五毒教：万蜍噬心
    if id == WAN_CHU_SHI_XIN then
        call wanChuShiXin()
    endif
   

 
	set u = null
	set ut = null
	set p = null
	set g = null
    set last = null
	return false
endfunction

//单位使用技能系统
function UseAbility takes nothing returns nothing
	local trigger t = CreateTrigger()

	call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t,Condition(function UseAbility_Conditions))
	set t = null
endfunction
