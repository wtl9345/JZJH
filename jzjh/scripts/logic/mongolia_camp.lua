---
--- 1.7之蒙古大营
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/1/7 0007 17:31
---


local g = require 'jass.globals'

--- 专属武器
local denomWeapon = {
    { 'I0AL' }, -- 少林1 袈裟
    { 'I09C' }, -- 古墓2 双剑
    { 'I097' }, -- 丐帮3 打狗棒
    { 'I0E0' }, -- 华山4 养吾剑
    { 'I0DP' }, -- 全真5 七星道袍
    { 'I098' }, -- 血刀6 血刀
    { 'I0DU' }, -- 恒山7 拂尘
    { 'I00B' }, -- 峨眉8 倚天剑
    { 'I0DK' }, -- 武当9 真武剑
    { 'I0AM' }, -- 星宿10 神木王鼎
    { 'I0EE' }, -- 自由11 十四天书
    { 'I0DT' }, -- 灵鹫12 玉扳指
    { 'I0DS' }, -- 慕容13 燕国玉玺
    { 'I0EF' }, -- 明教14 屠龙刀
    { 'I0DY' }, -- 衡山15 镇岳尚方
    { 'I0DZ' }, -- 男神龙16 毒龙鞭
    { 'I0DZ' }, -- 女神龙17 毒龙鞭
    { 'I0E2' }, -- 泰山18 东灵铁剑
    { 'I0EJ' }, -- 铁掌19 铁掌令
    { 'I0EP', 'I0EQ' }, -- 唐门20 子午砂 观音泪
    { 'I0AE' }, -- 五毒21 含沙射影
    { 'I09D' }, -- 桃花岛22 玉箫
    { 'I0EU' }, -- 野螺23 野螺
}

--- @param u unit
--- @return boolean,string
local function hasDenomWeapon(u)
    local p = u:get_owner()
    local pId = p:get()
    for i = 1, #denomWeapon do
        if g.udg_runamen[pId] == i  then
            for _, v in ipairs(denomWeapon[i]) do
                if (u:has_item(v)) then
                    return true, v
                end
            end
        end
    end
    return false, nil
end

function initMongoliaCamp()
    --- @param u unit 触发单位
    --- @param it item 触发物品
    et.game:event '单位-使用物品'(function(self, u, it)
        local id = it:get_id()
        local pId = u:get_owner():get()
        local b, v = hasDenomWeapon(u)

        -- 胡卜处迩 可以将专属加武功伤害的效果内化入体内
        if g.ateDenom[pId] == 1 then
            u:get_owner():send_message("每局限使用一次哦")
        else
            -- 判断是否有专属
            if b then
                u:remove_item(v)
                g.ateDenom[pId] = 1
            else
                u:get_owner():send_message("身上没有专属")
                u:add_item(id)
            end
        end
    end)
end
