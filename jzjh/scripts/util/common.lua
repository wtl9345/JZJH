base = base or {}
local jass = require 'jass.common'

--- 马甲单位施放技能
--- @param tab {producer unit, target unit, point point, unit_id number|string, ability_id number, ability_level number, order_id number, lifetime number, shown boolean}
function base.dummy_issue_order(tab)
    local point = tab.point or tab.target:get_point()
    local dummy = tab.producer:get_owner():create_dummy(tab.unit_id or 'e009', tab.producer:get_point())
    dummy.producer = tab.producer
    dummy:show(not not shown)
    if tab.ability_id then
        dummy:add_ability(tab.ability_id, tab.ability_level or 1)
    end
    if tab.order_id then
        dummy:issue_order(tab.order_id)
        dummy:issue_order(tab.order_id, tab.target)
        dummy:issue_order(tab.order_id, point)
    end
    dummy:set_lifetime(tab.lifetime or 20)
end

--- 触发被动技能
--- @param params {attacker:unit, attacked:unit, spell_id:string, shadow_id:string, order_id:number, possibility:number, mana_cost:number, lifetime:number}
--- @return boolean
function base.triggerPassive(params)
    if params.attacker:has_ability(params.spell_id) and params.attacker:get_mana() >= params.mana_cost then
        local p = params.attacker:get_owner()
        if jass.GetRandomInt(0, 100) <= params.possibility then
            base.dummy_issue_order({
                producer = params.attacker,
                target = params.attacked,
                ability_id = params.shadow_id,
                order_id = params.order_id,
                ability_level = params.attacker:get_ability_level(params.spell_id),
                lifetime = params.lifetime or 20
            })
            params.attacker:set_mana(params.attacker:get_mana() - params.mana_cost)
            return true
        else
            return false
        end
    end
    return false
end



--- @param source unit
--- @param target unit
--- @param damage number
--- @param critical boolean
function base.apply_damage(source, target, damage, critical)
    if damage == 0 then
        et.tag.create("MISS", target:get_point(), 11, 0, 100, 0, 0, 30, 0.65, 400, base.random(80, 100))
        return
    end
    if critical then
        et.tag.create(math.floor(damage), target:get_point(), 14, 0, 100, 100, 0, 30, 0.65, 400, base.random(80, 100))
    else
        et.tag.create(math.floor(damage), target:get_point(), 11, 0, 100, 100, 100, 30, 0.65, 400, base.random(80, 100))
    end
    jass.UnitDamageTarget(source.handle, target.handle, damage, true, false, jass.ATTACK_TYPE_MAGIC, jass.DAMAGE_TYPE_NORMAL, jass.WEAPON_TYPE_WHOKNOWS)
end

function base.float_equal(x, v)
    local EPSILON = 0.000001
    return ((v - EPSILON) < x) and (x < (v + EPSILON))
end

function base.random(m, n)
    return jass.GetRandomReal(m, n)
end

function base.random_int(m, n)
    return jass.GetRandomInt(m, n)
end


require 'util.table_util'
