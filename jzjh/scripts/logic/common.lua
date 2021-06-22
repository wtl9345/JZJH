---
--- Generated by EmmyLua(https:--github.com/EmmyLua)
--- Created by G. Seinfeld.
--- DateTime: 2021/6/21 0021 15:09
---

require 'util.id'
require 'utility'
local g = require 'jass.globals'
local jass = require 'jass.common'

local chief_table = {
    { denom_id = 1, name = '少林方丈', str = 170, agi = 190, int = 480 },
    { denom_id = 2, name = "古墓掌门", str = 240, agi = 240, int = 0 },
    { denom_id = 3, name = "丐帮帮主", str = 480, agi = 0, int = 0 },
    { denom_id = 4, name = "华山掌门", str = 0, agi = 170, int = 290 },
    { denom_id = 5, name = "全真掌教", str = 0, agi = 360, int = 0 },
    { denom_id = 6, name = "血刀掌门", str = 0, agi = 0, int = 1200 },
    { denom_id = 7, name = "恒山掌门", str = 0, agi = 460, int = 0 },
    { denom_id = 8, name = "峨眉掌门", str = 240, agi = 170, int = 0 },
    { denom_id = 9, name = "武当掌门", str = 240, agi = 0, int = 600 },
    { denom_id = 10, name = "星宿掌门", str = 0, agi = 600, int = 300 },
    { denom_id = 12, name = "灵鹫宫主", str = 220, agi = 220, int = 220 },
    { denom_id = 13, name = "慕容家主", str = 100, agi = 280, int = 300 },
    { denom_id = 14, name = "明教教主", str = 210, agi = 310, int = 160 },
    { denom_id = 15, name = "衡山掌门", str = 350, agi = 260, int = 100 },
    { denom_id = 16, name = "男神龙", str = 350, agi = 0, int = 200 },
    { denom_id = 17, name = "女神龙", str = 200, agi = 350, int = 0 },
    { denom_id = 18, name = "泰山掌门", str = 320, agi = 220, int = 120 },
    { denom_id = 19, name = "铁掌帮主", str = 300, agi = 0, int = 225 },
    { denom_id = 20, name = "唐门门主", str = 0, agi = 225, int = 300 },
    { denom_id = 21, name = "五毒教主", str = 300, agi = 225, int = 0 },
    { denom_id = 22, name = "桃花岛主", str = 225, agi = 0, int = 300 },
    { denom_id = 23, name = "野螺掌派", str = 225, agi = 300, int = 0 },
}

--[[
设置称号
1 扫地神僧
2 达摩祖师
3 大轮明王
4 金轮法王
5 神雕侠
6 小龙女
7 神雕侠侣
8 赤炼仙子
9 北丐
10 北乔峰
11 君子剑
12 风清扬

14 中神通
15 血刀老祖
16 空心菜
17 仪琳
18 笑傲江湖
19 芷若
20 小东邪
21 邋遢仙人
22 张三丰
23 星宿老仙
24 天山童姥
25 虚竹子
26 慕容龙城
27 白眉鹰王
28 青翼蝠王
29 金毛狮王
30 无忌
31 莫大先生
32 神龙教主
33 教主夫人
34 天门道长
35 铁掌水上漂
36 搜魂侠

38 西毒
39 东邪
40 南帝

42 小虾米

44 神仙姐姐
45 婆婆姊姊
46 女中诸葛
47 爵爷
*/
--]]
--- 是否有某称号
--- @param i number 玩家序号
--- @param title number 称号序号
local function has_title(i, title)
    if title <= 30 then
        return g.title0[i] & (1 << title - 1) ~= 0
    else
        return g.title1[i] & (1 << title - 31) ~= 0
    end
end

--- 设置称号
--- @param i number 玩家序号
--- @param title number 称号序号
local function set_title_(i, title)
    if title <= 30 then
        g.title0[i] = g.title0[i] | (1 << title - 1)
    else
        g.title1[i] = g.title1[i] | (1 << title - 31)
    end
end

--[[
掌门
1 少林
2 古墓
3 丐帮
4 华山
5 全真
6 血刀
7 恒山
8 峨眉
9 武当
10 星宿
11 自由
12 灵鹫
13 慕容
14 明教
15 衡山
16 神龙
17 神龙（女）
18 泰山
19 铁掌
20 唐门
21 五毒
22 桃花岛
23 野螺派
]]

--- 是否为某掌门
--- @param i number 玩家序号
--- @param denomination number 称号序号
local function is_chief(i, denomination)
    return g.chief[i] & (1 << denomination - 1) ~= 0
end

--- 设置为某掌门
--- @param i number 玩家序号
--- @param denomination number 称号序号
local function set_chief_(i, denomination)
    g.chief[i] = g.chief[i] | (1 << denomination - 1)
end

--- @param u unit 单位
--- @param i number 玩家序号
--- @param config table 配置
local function title_cond(u, i, config)
    if config.abilities then
        for k, v in pairs(config.abilities, defaultComp) do
            if u:get_ability_level(k) < v then
                return false
            end
        end
    end
    if config.attrs then
        for k, v in pairs(config.attrs, defaultComp) do
            if g[k][i] < v then
                return false
            end
        end
    end
    if config.items then
        for _, v in ipairs(config.items) do
            if not u:has_item(v) then
                return false
            end
        end
    end
    if config.title and has_title(i, config.title) then
        return false
    end
    return true
end

local function saodi(u, i)
    return title_cond(u, i, { abilities = { A05O = 1 }, attrs = { yishu = 32 }, title = 1 })
end

local function damo(u, i)
    return title_cond(u, i, { abilities = { A09D = 1, A080 = 1 }, title = 2 })
end

local function dalun(u, i)
    return title_cond(u, i, { abilities = { A083 = 1, A03P = 1 }, attrs = { wuxing = 31 }, title = 3 })
end

local function jinlun(u, i)
    return title_cond(u, i, { abilities = { S002 = 1 }, attrs = { gengu = 31 }, title = 4 })
end

local function shendiao(u, i)
    return title_cond(u, i, { abilities = { A07G = 1 }, items = { 'I099' }, title = 5 })
end

local function longnv(u, i)
    return title_cond(u, i, { abilities = { A07U = 1 }, items = { 'I09A' }, title = 6 })
end

local function shendiaoxialv(u, i)
    return title_cond(u, i, { abilities = { A07G = 1, A07U = 1 }, items = { 'I09C' }, title = 7 })
end

local function chilian(u, i)
    return title_cond(u, i, { abilities = { A07A = 6 }, title = 8 })
end

local function beigai(u, i)
    return title_cond(u, i, { abilities = { A07L = 1, A07E = 1 }, items = { 'I097' }, title = 9 })
end

local function qiaofeng(u, i)
    return title_cond(u, i, { abilities = { A07E = 3, A03V = 1 }, items = { 'I097' }, title = 10 })
end

local function junzi(u, i)
    return title_cond(u, i, { abilities = { A07T = 1, A07J = 1 }, title = 11 })
end

local function fengqingyang(u, i)
    return title_cond(u, i, { abilities = { A07F = 5 }, title = 12 })
end

local function shentong(u, i)
    return title_cond(u, i, { abilities = { A06P = 1, A07S = 1, A0CH = 1 }, title = 14 })
end

local function xuedao(u, i)
    return title_cond(u, i, { items = { 'I098' }, title = 15 })
end

local function kongxincai(u, i)
    return title_cond(u, i, { abilities = { A07X = 1, A06J = 1, A071 = 1 }, title = 16 })
end

local function yilin(u, i)
    return title_cond(u, i, { abilities = { A01Z = 7, A021 = 7, A0CD = 7 }, title = 17 })
end

local function xiaoao(u, i)
    return title_cond(u, i, { abilities = { A07F = 1, A09D = 1, A07R = 1, A08W = 1 }, title = 18 })
end

local function zhiruo(u, i)
    return title_cond(u, i, { abilities = { A07N = 1 }, items = { 'I00B' }, title = 19 })
end

local function xiaodongxie(u, i)
    return title_cond(u, i, { abilities = { A0C6 = 1 }, items = { 'I09D' }, title = 20 })
end

local function lata(u, i)
    return title_cond(u, i, { abilities = { A0DN = 1, A09D = 1 }, title = 21 })
end

local function zhangsanfeng(u, i)
    return title_cond(u, i, { abilities = { A08R = 9 }, items = { 'I0DK' }, title = 22 })
end

local function laoxian(u, i)
    return title_cond(u, i, { abilities = { A07P = 1, A083 = 1 }, title = 23 })
end

local function tonglao(u, i)
    return title_cond(u, i, { abilities = { A02G = 6, A07A = 1, A082 = 1 }, title = 24 })
end

local function xuzhu(u, i)
    return title_cond(u, i, { abilities = { A07A = 1, A082 = 1, A07O = 1 }, items = { 'I0DT' }, title = 25 })
end

local function murong(u, i)
    return title_cond(u, i, { abilities = { A07Q = 1 }, title = 26 })
end

local function yingwang(u, i)
    return title_cond(u, i, { abilities = { A030 = 9 }, title = 27 })
end

local function fuwang(u, i)
    return title_cond(u, i, { abilities = { A032 = 9 }, title = 28 })
end

local function shiwang(u, i)
    return title_cond(u, i, { abilities = { A06R = 9, A07M = 3 }, items = { 'I00D' }, title = 29 })
end

local function wuji(u, i)
    return title_cond(u, i, { abilities = { A07W = 6, A0DN = 1, A08R = 4 }, title = 30 })
end

local function moda(u, i)
    return title_cond(u, i, { abilities = { A04M = 7, A04N = 7, A04P = 7 }, title = 31 })
end

local function shenlong(u, i)
    return title_cond(u, i, { abilities = { A0DN = 1, S002 = 1 }, title = 32 })
end

local function furen(u, i)
    return title_cond(u, i, { abilities = { A07S = 1, A083 = 1 }, title = 33 })
end

local title_table = {
    { chief = 1, cond = saodi, name = "扫地神僧", agi = 720, title = 1 },
    { chief = 1, cond = damo, name = "达摩祖师", str = 200, agi = 220, int = 200, to9 = { 'A05O', 'S000' }, title = 2 },
    { chief = 1, cond = dalun, name = "大轮明王", str = 200, agi = 200, int = 200, title = 3 },
    { chief = 1, cond = jinlun, name = "金轮法王", str = 200, agi = 200, int = 200, title = 4 },
    { chief = 2, cond = shendiao, name = "神雕侠", str = 480, to9 = 'A07G', title = 5 },
    { chief = 2, cond = longnv, name = "小龙女", int = 600, title = 6 },
    { chief = 2, cond = shendiaoxialv, name = "神雕侠侣", str = 480, int = 600, to9 = 'A07G', item = 'I04A', title = 7 },
    { chief = 2, cond = chilian, name = "赤炼仙子", to9 = 'A07A', title = 8 },
    { chief = 3, cond = beigai, name = "北丐", str = 480, to9 = { 'A07L', 'A07E' }, title = 9 },
    { chief = 3, cond = qiaofeng, name = "北乔峰", str = 500, agi = 500, int = 500, to9 = 'A07E', title = 10 },
    { chief = 4, cond = junzi, name = "君子剑", str = 600, to9 = 'A07J', item = 'I069', title = 11 },
    { chief = 4, cond = fengqingyang, name = "风清扬", str = 250, agi = 250, int = 200, to9 = 'A07F', item = 'I066', title = 12 },
    { chief = 5, cond = shentong, name = "中神通", str = 300, agi = 300, int = 300, to9 = 'A0CH', title = 14 },
    { chief = 6, cond = xuedao, name = "血刀老祖", str = 480, to9 = 'A0DH', title = 15 },
    { chief = 6, cond = kongxincai, name = "空心菜", str = 200, agi = 200, int = 360, extra = kongxincai_extra, title = 16 },
    { chief = 7, cond = yilin, name = "仪琳", agi = 200, int = 200, to9 = "A01Z", title = 17 },
    { chief = 7, cond = xiaoao, name = "笑傲江湖", str = 480, agi = 500, int = 600, to9 = { "A07F", "A08W" }, title = 18 },
    { chief = 8, cond = zhiruo, name = "芷若", str = 480, to9 = "A07N", title = 19 },
    { chief = 8, cond = xiaodongxie, name = "小东邪", agi = 360, title = 20 },
    { chief = 9, cond = lata, name = "邋遢仙人", agi = 420, extra = lata_extra, title = 21 },
    { chief = 9, cond = zhangsanfeng, name = "张三丰", str = 300, agi = 300, int = 300, title = 22 },
    { chief = 10, cond = laoxian, name = "星宿老仙", agi = 600, int = 300, to9 = { 'A0BT', 'A0BV' }, title = 23 },
    { chief = 12, cond = tonglao, name = "天山童姥", str = 280, agi = 280, int = 320, to9 = { 'A02G', 'A02F' }, title = 24 },
    { chief = 12, cond = xuzhu, name = "虚竹子", str = 100, agi = 500, int = 100, title = 25 },
    { chief = 13, cond = murong, name = "慕容龙城", str = 200, int = 200, agi = 250, title = 26 },
    { chief = 14, cond = yingwang, name = "白眉鹰王", int = 500, title = 27 },
    { chief = 14, cond = fuwang, name = "青翼蝠王", agi = 300, title = 28 },
    { chief = 14, cond = shiwang, name = "金毛狮王", str = 300, title = 29 },
    { chief = 14, cond = wuji, name = "无忌", agi = 1000, int = 500, to9 = 'A08R', item = 'I0CS', extra = wuji_extr, title = 30 },
    { chief = 15, cond = moda, name = "莫大先生", extra = moda_extr, title = 31 },
    { chief = 16, cond = shenlong, name = "神龙教主", str = 200, agi = 400, int = 300, title = 32 },
    { chief = 17, cond = furen, name = "教主夫人", str = 400, agi = 200, int = 300, title = 33 },
    { chief = 18, cond = tianmen, name = "天门道长", str = 300, agi = 600, title = 34 },
    { chief = 19, cond = shuishangpiao, name = "铁掌水上漂", str = 300, agi = 200, int = 100, title = 35 },
    { chief = 20, cond = souhun, name = "搜魂侠", str = 300, agi = 200, int = 300, title = 36 },
    { chief = 21, cond = popo, name = "婆婆姊姊", str = 300, agi = 300, int = 300, title = 45 },
    { chief = 22, cond = nvzhuge, name = "女中诸葛", extr = nvzhuge_extr, title = 46 },
    { chief = 22, cond = dongxie, name = "东邪", agi = 240, int = 300, to9 = { 'A06H', 'A018' }, item = { 'I04Q', 'I04Q' }, title = 39 },
    { chief = 23, cond = jueye, name = "爵爷", str = 400, agi = 400, int = 200, title = 47 },
    { cond = xidu, name = "西毒", str = 600, int = 360, item = { 'I070', 'I09G' }, to9 = 'A089', title = 38 },
    { cond = nandi, name = "南帝", agi = 480, int = 600, to9 = { 'A06P', 'A0CH' }, item = 'I09H', title = 40 },
    { cond = xiami, name = "小虾米", str = 1000, agi = 1000, int = 1000, item = 'I068', to9 = 'A07I', title = 42 },
    { cond = shenxian, name = "神仙姐姐", str = 300, agi = 500, int = 300, to9 = { 'A07E', 'A017' }, title = 44 }
}

--- @param u unit 英雄单位
--- @param denom_id number 门派编号
local function can_become_chief(u, denom_id)
    local special0 = (denom_id == 20) and 1 or 6 -- 唐门
    local special1 = (denom_id == 14) and 4 or 6 -- 明教
    return u:get_ability_level(g.X7[denom_id]) >= 6
            and u:get_ability_level(g.Y7[denom_id]) >= 6
            and u:get_ability_level(g.Z7[denom_id]) >= 6
            and (u:get_ability_level(g.Q8[denom_id]) >= special0
            or u:get_ability_level(g.P8[denom_id]) >= special1)
end

--- @param u unit 英雄单位
local function become_chief_(u)
    local p = u:get_owner()
    local p_id = p:get()
    for i = 1, #chief_table do
        local denom_id = chief_table[i].denom_id
        if not is_chief(p_id, denom_id) and can_become_chief(u, denom_id) then
            force.send_message("|cff66ff00恭喜玩家" .. p_id .. "获得了称号：" .. chief_table[i].name)
        end
        if chief_table[i].str > 0 then
            u:set_str(u:get_str() + chief_table[i].str)
        end
        if chief_table[i].agi > 0 then
            u:set_agi(u:get_agi() + chief_table[i].agi)
        end
        if chief_table[i].int > 0 then
            u:set_int(u:get_int() + chief_table[i].int)
        end
        p:set_name("〓" .. chief_table[i].name .. "〓" + jass.LoadStr(g.YDHT, jass.GetHandleId(p), jass.GetHandleId(p)))
        set_chief_(p_id, denom_id)
    end
end

--- @param u unit 升重单位
local function levelup_coeff(u)
    local i = 1 + u:get_owner():get()
    -- 是否激活九阳真经残卷
    local jyd = g.JYd[i]
    -- 是否有王语嫣称号
    local wyy = has_title(i, 44)

    local coeff = 0
    -- 七绝或新手神器
    if u:has_any_item('I01J', 'I0DB') then
        coeff = coeff + 1
    end
    -- 九阳残卷
    if jyd == 1 then
        coeff = coeff + 2
    end
    -- 王语嫣
    if wyy then
        coeff = coeff + 2
    end

    return coeff
end

--- @param u unit 升重单位
--- @param id number|string 技能ID
local function increase_ability_and_item_charge(u, id)
    u:set_ability_level(id, u:get_ability_level(id) + 1)
    for i = 1, 6 do
        local it = u:get_item_in_slot(i)
        if base.string2id(it:get_id()) == g.ITEM_HAN_SHA then
            it:set_charges(it:get_charges() + 1)
        end
    end
end

function Deputy_isDeputy(i, whichDeputy)
    return g.deputy[i] & (1 << (whichDeputy - 1)) ~= 0
end
-- 设置副职
function Deputy_setDeputy(i, whichDeputy)
    g.deputy[i] = g.deputy[i] | (1 << (whichDeputy - 1))
end
-- 判断是否具备某副职的大师
function Deputy_isMaster(i, whichMaster)
    return g.master[i] & (1 << (whichMaster - 1)) ~= 0
end
-- 设置副职大师
function Deputy_setMaster (i, whichMaster)
    g.master[i] = g.master[i] | (1 << (whichMaster - 1))
end

--- @param u unit 升重单位
--- @param id number|string 技能ID
--- @param r number 升重系数
local function do_kungfu_levelup(u, id, r)
    local level = u:get_ability_level(id)
    local p = u:get_owner()
    local i = 1 + p:get()
    local exp = 0
    if level > 0 and level < 7 then
        -- 慕容家训
        if u:has_buff('B010') then
            exp = (3 + g.udg_xinggeA[i])
                    * (g.wuxing[i] + 5 + jass.GetRandomInt(0, jass.R2I(r / 60)))
                    * (5 + u:get_ability_level('A02V') / 2 + 2 * g.udg_jwjs[i]) * (2 + levelup_coeff(u)) / 40
        else
            exp = (3 + g.udg_xinggeA[i])
                    * (g.wuxing[i] + 5 + jass.GetRandomInt(0, jass.R2I(r / 60)))
                    * (4 + 2 * g.udg_jwjs[i]) * (2 + levelup_coeff(u)) / 40
        end

        -- 天赋：天纵奇才 增加升重速度
        if u:has_buff('B01O') then
            exp = jass.R2I(exp * (1.5 + g.bigTalent[i] * 0.5))
        end

        if type(id) == 'string' then
            id = base.string2id(id)
        end
        local p_handle_id = jass.GetHandleId(u:get_owner().handle)
        jass.SaveInteger(g.YDHT, p_handle_id, id, jass.LoadInteger(g.YDHT, p_handle_id, id) + exp)
        jass.SaveStr(g.YDHT, p_handle_id, id * 2, jass.I2S(jass.LoadInteger(g.YDHT, p_handle_id, id)) + "/" + jass.I2S(jass.R2I(r * level)))
        if jass.LoadInteger(g.YDHT, p_handle_id, id) > jass.R2I(r) * level then
            jass.SaveInteger(g.YDHT, p_handle_id, id, 0)
            increase_ability_and_item_charge(u, id)
            jass.SaveInteger(g.YDHT, p_handle_id, id * 5, u:get_ability_level(id))

            force.send_message("|cff66ff00恭喜玩家" .. i .. "领悟了武功：" .. jass.GetObjectName(id) .. "第" .. (level + 1) .. "重")
            if base.id2string(id) == 'A0DP' then
                -- 归元吐纳功
                g.fuyuan[i] = g.fuyuan[i] + 2
                g.gengu[i] = g.gengu[i] + 2
                g.wuxing[i] = g.wuxing[i] + 2
                g.jingmai[i] = g.jingmai[i] + 2
                g.danpo[i] = g.danpo[i] + 2
                g.yishu[i] = g.yishu[i] + 2
            end
        end
    elseif level > 0 and level < 9 then
        local p_handle_id = jass.GetHandleId(u:get_owner().handle)
        if (jass.GetRandomReal(1., r * level) <= (g.wuxing[i]) / 2 * (1 + 0.6 * g.udg_jwjs[i])) or ((u:has_buff('B010') or u:has_buff('B01O')) and jass.GetRandomReal(1., r * level) <= (g.wuxing[i]) / 2 * (2 + 0.3 * u:get_ability_level('A02V') + 0.6 * g.udg_jwjs[i])) then
            if id ~= 'A07W' then
                increase_ability_and_item_charge(u, id)
                jass.SaveInteger(g.YDHT, p_handle_id, id * 5, u:get_ability_level(id))
                force.send_message("|cff66ff00恭喜玩家" .. i .. "领悟了武功：" .. jass.GetObjectName(id) .. "第" .. (level + 1) .. "重")
                if level + 1 == 9 and Deputy_isDeputy(i, g.JING_WU) then
                    g.wuxuedian[i] = g.wuxuedian[i] + 2
                    p:send_message("|cff66ff00精武师有技能升级到九重，获得两个自创武学点")
                    if (g.udg_jwjs[i] <= 2) and not Deputy_isMaster(i, g.JING_WU) then
                        g.udg_jwjs[i] = g.udg_jwjs[i] + 1
                        p:send_message("|CFF66FF00恭喜您练成第" .. g.udg_jwjs[i] .. "个九重武功，练成3个可获得宗师哦")
                    end
                    if (g.udg_jwjs[i] == 3) and not Deputy_isMaster(i, g.JING_WU) then
                        Deputy_setMaster(i, g.JING_WU)
                        --  SaveStr(g.YDHT, GetHandleId(p), GetHandleId(p), "〓精武宗师〓" + LoadStr(g.YDHT, GetHandleId(p), GetHandleId(p)))
                        force.send_message("|CFF66FF00恭喜" .. p:get_name() .. "获得精武宗师", 15)
                        p:set_name("〓精武宗师〓" .. jass.LoadStr(g.YDHT, p_handle_id, p_handle_id))
                    end
                end
            end
        else
            if g.udg_xinggeB[i] >= 4 or u:has_any_item('I01J', 'I0DB') or g.JYd[i] == 1 then
                if id ~= 'A07W' then
                    if u:has_buff('B010') then
                        exp = jass.LoadInteger(g.YDHT, p_handle_id, id) + (3 + g.udg_xinggeA[i]) * (g.wuxing[i] + 5 + jass.GetRandomInt(0, jass.R2I(r / 60))) * (2 + levelup_coeff(u)) / 20 * (2 + u:get_ability_level('A02V') / 4 + g.udg_jwjs[i]) / 3 * 2
                    else
                        exp = jass.LoadInteger(g.YDHT, p_handle_id, id) + (3 + g.udg_xinggeA[i]) * (g.wuxing[i] + 5 + jass.GetRandomInt(0, jass.R2I(r / 60))) * (2 + levelup_coeff(u)) / 20 * (2 + g.udg_jwjs[i]) / 3 * 2
                    end
                    -- 天赋：天纵奇才 增加升重速度
                    if u:has_buff('B01O') then
                        exp = jass.R2I(exp * (1.5 + g.bigTalent[i] * 0.5))
                    end
                    jass.SaveInteger(g.YDHT, p_handle_id, id, exp)
                end
                jass.SaveStr(g.YDHT, p_handle_id, id * 2, jass.I2S(g.LoadInteger(g.YDHT, p_handle_id, id)) + "/" + jass.I2S(jass.R2I(r * level)))
                if g.LoadInteger(g.YDHT, p_handle_id, id) > jass.R2I(r) * level then
                    jass.SaveInteger(g.YDHT, p_handle_id, id, 0)
                    increase_ability_and_item_charge(u, id)
                    jass.SaveInteger(g.YDHT, p_handle_id, id * 5, u:get_ability_level(id))
                    force.send_message("|cff66ff00恭喜玩家" .. jass.I2S(i) .. "领悟了武功：" .. jass.GetObjectName(id) .. "第" .. (level + 1) .. "重")
                    if id == 'A0DP' then
                        -- 归元吐纳功
                        g.fuyuan[i] = g.fuyuan[i] + 2
                        g.gengu[i] = g.gengu[i] + 2
                        g.wuxing[i] = g.wuxing[i] + 2
                        g.jingmai[i] = g.jingmai[i] + 2
                        g.danpo[i] = g.danpo[i] + 2
                        g.yishu[i] = g.yishu[i] + 2
                    end
                    if level + 1 == 9 and Deputy_isDeputy(i, g.JING_WU) then
                        g.wuxuedian[i] = g.wuxuedian[i] + 2
                        p:send_message("|cff66ff00精武师有技能升级到九重，获得两个自创武学点")
                        if (g.udg_jwjs[i] <= 2) and not Deputy_isMaster(i, g.JING_WU) then
                            g.udg_jwjs[i] = g.udg_jwjs[i] + 1
                            p:send_message("|CFF66FF00恭喜您练成第" + I2S(g.udg_jwjs[i]) + "个九重武功，练成3个可获得宗师哦")
                        end
                        if (g.udg_jwjs[i] == 3) and not Deputy_isMaster(i, g.JING_WU) then
                            Deputy_setMaster(i, g.JING_WU)
                            --  SaveStr(g.YDHT, GetHandleId(p), GetHandleId(p), "〓精武宗师〓" + LoadStr(g.YDHT, GetHandleId(p), GetHandleId(p)))
                            force.send_message("|CFF66FF00恭喜" .. p:get_name() .. "获得精武宗师", 15)
                            p:set_name("〓精武宗师〓" + jass.LoadStr(g.YDHT, p_handle_id, p_handle_id))
                        end
                    end
                end
            end
        end
    end

end

--- @param u unit 升重单位
--- @param id number|string 技能ID
--- @param r number 升重系数
local function kungfu_levelup(u, id, r)
    local level = u:get_ability_level(id)
    local p = u:get_owner()
    local i = 1 + p:get()

    -- 武功升重
    do_kungfu_levelup(u, id, r)

    -- 掌门
    become_chief_(u)

    -- 称号
    determine_titles(u)
end

--- @param source unit 伤害来源
--- @param target unit 伤害目标
--- @param w1 number 伤害系数w1
--- @param w2 number 伤害系数w2
--- @param coeff number 伤害系数
--- @param id number|string 技能ID
local function damage_formula(source, target, w1, w2, coeff, id)
    local p = source:get_owner()
    local i = p:get() + 1
    local damage = 0

    local attack -- 伤害因子
    local target_def -- 目标防御因子
    local special_def -- 特殊防御因子
    local dodge -- 闪避因子
    local random -- 随机因子
    local basic_damage -- 基础伤害
    local str = source:get_str() -- 招式伤害
    local agi = source:get_agi() -- 内力
    local int = source:get_int() -- 真实伤害

    if source:is_hero() then
        attack = 1 + 0.3 * source:get_ability_level('A059')
                * 160
                * g.udg_lilianxishu[i]
                * (w1 * (1 + str / 300) * (1 + agi / 300) + w2 * 0.02 * int)
                * (1.5 + 0.5 * source:get_ability_level(id))
                * (1 + g.udg_shanghaijiacheng[i])
                * coeff

        if g.udg_yanglao then
            attack = attack * 30
        end

        if source:get_ability_level(id) == 9 then
            attack = attack * 3
        end

        if source:has_item('I0EE') then
            attack = attack * 3
        end

        local unit_id = source:get_type_id()
        if source:has_item('I099') and base.is_include(unit_id, { 'O000', 'O001', 'O004', 'O02J' }) then
            attack = attack * 1.5
        end
        if source:has_item('I09A') and base.is_include(unit_id, { 'O002', 'O003', 'O023', 'O02H', 'O02I' }) then
            attack = attack * 1.5
        end
    else
        attack = 750 * (w1 + w2) * (1 + source:get_ability_level(id)) * coeff
    end

    -- 敌方防御因子
    target_def = target and 1 / (1 + 0.1 * target:get_level()) or 1

    -- 特防
    if g.special_attack[i] >= 6 * (1 + g.udg_nandu) or target:has_ability('B022') then
        special_def = math.max(1 + (g.special_attack[i] - 6 * (1 + g.udg_nandu)) * 0.06, 1)
    else
        special_def = 1 / (1 + 0.06 * ((1 + g.udg_nandu) * 6 - g.special_attack[i]))
    end

    if not target then
        dodge = 25
    else
        dodge = math.min(target:get_level() / 5, 95)
        if (target:has_ability('Bslo')) then
            dodge = 0
        end
    end

    random = math.random(0.95, 0.95 + g.udg_xinggeB[i] / 20)
    basic_damage = attack * target_def * random * special_def

    -- 红怪
    if jass.LoadInteger(g.YDHT, jass.GetHandleId(target), jass.StringHash("color")) == 1 then
        basic_damage = basic_damage / 100
    end
    -- 绿怪
    if jass.LoadInteger(g.YDHT, jass.GetHandleId(target), jass.StringHash("color")) == 2 then
        basic_damage = basic_damage / 1000
    end
    -- 蓝怪
    if jass.LoadInteger(g.YDHT, jass.GetHandleId(target), jass.StringHash("color")) == 3 then
        basic_damage = basic_damage / 10000
    end

    -- 无尽BOSS战模式第N个BOSS
    if target == g.udg_boss[7] and g.tiaoZhanIndex == 3 then
        basic_damage = basic_damage / jass.Pow(10, g.endless_count)
    end

    -- 先天功不会miss
    if source:get_ability_level('A0CH') >= 1 then
        dodge = 0
    end

    if jass.GetRandomReal(0, 100) < dodge then
        damage = 0
    else
        damage = basic_damage
    end

    if type(id) == 'string' then
        id = base.string2id(id)
    end

    jass.SaveReal(jass.YDHT, i, id * 3, basic_damage)
    return damage
end

--- @param ability_id number|string 技能ID
--- @param source unit 伤害来源
--- @param target unit|table<number, unit> 伤害目标
--- @param action nil|function 伤害动作
--- @param effect function 特效 自己、敌人、地面
--- @param possibility number|function 触发概率
--- @param exclusive function 专属加成
--- @param damage_coefficients table<number, number> 伤害系数[w1, w2]
--- @param levelup_coefficients number 升重系数
--- @param combinations table<number, function> 搭配
local function passive_ability(ability_id, source, target, action, effect,
                               possibility, exclusive, damage_coefficients, levelup_coefficients, combinations)
    -- 技能ID
    if type(ability_id) == 'string' then
        ability_id = base.string2id(ability_id)
    end

    -- 触发概率
    local p = source:get_owner()
    local i = p:get() + 1
    if type(possibility) == 'function' then
        possibility = possibility(g.fuyuan[i])
    end
    -- 专属加成


    if source:has_ability(ability_id) and math.random(1, 100) <= possibility then
        -- 伤害动作
        if not action then
            -- 直接造成伤害

            if type(target) == 'table' then
                -- AOE
            else
                -- 单体
            end
        else
            -- 自定义，如马甲施放技能、召唤物等
            if type(action) == 'function' then
                action(source, target)
            end
        end

        -- 特效
        effect(source, target)

        -- 升重

    end

end

common_ability = common_ability or {}

common_ability.passive = function(config)
    local ability_id = config.ability_id
    local source = config.source ---@type unit
    local target = config.target
    local action = config.action -- 可选
    local effect_str = config.effect_str
    local effect_target = config.effect_target or 'target'
    local effect_attach = config.effect_attach or 'overhead'
    local effect_point = config.effect_point or source:get_point()
    local possibility = config.possibility or 20
    local exclusive = config.exclusive
    local damage_coefficients = config.damage_coefficients or { 10, 10 }
    local levelup_coefficients = config.levelup_coefficients or 1000
    local combinations = config.combinations

    local effect = function(us, ut)
        if effect_target == 'source' then
            et.effect.add_to_unit(effect_str, us, effect_attach):destroy()
        elseif effect_target == 'target' then
            if type(ut) == 'table' then
                for _, v in ipairs(ut) do
                    et.effect.add_to_unit(effect_str, v, effect_attach):destroy()
                end
            else
                et.effect.add_to_unit(effect_str, ut, effect_attach):destroy()
            end

        elseif effect_target == 'point' then
            et.effect.add_to_point(effect_point, effect_point)
        end
    end
    passive_ability(ability_id, source, target, action, effect,
            possibility, exclusive, damage_coefficients, levelup_coefficients, combinations)

end
