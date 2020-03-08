// 网易商城相关的逻辑

globals
    integer array tiezhang_flag
    integer array tangmen_flag
    integer array talent_flag
    integer array wudu_flag
    integer array mall_addition // 商城积分加成
    integer array level_award // 萌新礼包（无视等级领取等级奖励）
    integer array wukong_flag // 悟空皮肤权限
    integer array panda_flag // 熊猫皮肤权限
    // A 永久性道具 B 计时性道具
    string PROPERTY_TALENT = "AR98FE7J3P" // 天赋的道具
    string PROPERTY_TIEZHANG = "A198FYU9ME" // 解锁铁掌帮的道具
    string PROPERTY_TANGMEN = "AR87S95C34" // 解锁唐门的道具
    string PROPERTY_WUDU = "AWUDU12345" // 解锁五毒教的道具
    string PROPERTY_WUKONG = "ARWUKONG59" // 悟空的道具
    string PROPERTY_PANDA = "ARPANDA072" // 熊猫的道具

    string PROPERTY_DOUBLE_POINT = "BC98FNY5L9" // 双倍积分卡的道具
    string PROPERTY_LEVEL_AWARD = "BYOUARES13" // 无视等级领取等级奖励
endglobals

function checkPurchase takes nothing returns nothing
    local integer i = 1
    loop
        exitwhen i > 5
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_TALENT) or udg_isTest[i-1] then
            set talent_flag[i] = 1
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_TIEZHANG) or udg_isTest[i-1] then
            set tiezhang_flag[i] = 1
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_TANGMEN) or udg_isTest[i-1] then
            set tangmen_flag[i] = 1
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_WUDU) or udg_isTest[i-1] then
            set wudu_flag[i] = 1
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_DOUBLE_POINT) or udg_isTest[i-1] then
            set mall_addition[i] = 1
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_LEVEL_AWARD) or udg_isTest[i-1] then
            set level_award[i] = 1
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_WUKONG) or udg_isTest[i-1] then
            set wukong_flag[i] = 1
            call SetPlayerTechResearched(Player(i-1),'R004',1)
        endif
        if DzAPI_Map_HasMallItem(Player(i-1), PROPERTY_PANDA) or udg_isTest[i-1] then
            set panda_flag[i] = 1
            call SetPlayerTechResearched(Player(i-1),'R005',1)
        endif
        set i = i + 1
    endloop
endfunction


function mallInit takes nothing returns nothing
    local timer t = CreateTimer()
    local integer i = 1
    loop
        exitwhen i > 5
        set tiezhang_flag[i] = 0
        set tangmen_flag[i] = 0
        set wudu_flag[i] = 0
        set talent_flag[i] = 0
        set mall_addition[i] = 0
        set level_award[i] = 0
        set panda_flag[i] = 0
        set wukong_flag[i] = 0
        set i = i + 1
    endloop

    call TimerStart(t, 1, true, function checkPurchase)
    set t = null
endfunction