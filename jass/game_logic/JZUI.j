globals
    Frame array zwidget
    Frame array zbutton
    string array attrStr
    // UI设置对齐锚点的常量 DzFrameSetPoint achor定义，从0开始
    constant integer TOPLEFT = 0
    constant integer TOP = 1
    constant integer TOPRIGHT = 2
    constant integer LEFT = 3
    constant integer CENTER = 4
    constant integer RIGHT = 5
    constant integer BOTTOMLEFT = 6
    constant integer BOTTOM = 7
    constant integer BOTTOMRIGHT = 8

    //DzFrameSetScript  注册ui事件的事件ID
    constant integer NONE = 0
    constant integer FRAME_EVENT_PRESSED = 1
    constant integer FRAME_MOUSE_ENTER = 2
    constant integer FRAME_MOUSE_LEAVE = 3
    constant integer FRAME_MOUSE_UP = 4
    constant integer FRAME_MOUSE_DOWN = 5
    constant integer FRAME_MOUSE_WHEEL = 6
    constant integer FRAME_FOCUS_ENTER = FRAME_MOUSE_ENTER
    constant integer FRAME_FOCUS_LEAVE = FRAME_MOUSE_LEAVE
    constant integer FRAME_CHECKBOX_CHECKED = 7
    constant integer FRAME_CHECKBOX_UNCHECKED = 8
    constant integer FRAME_EDITBOX_TEXT_CHANGED = 9
    constant integer FRAME_POPUPMENU_ITEM_CHANGE_START = 10
    constant integer FRAME_POPUPMENU_ITEM_CHANGED = 11
    constant integer FRAME_MOUSE_DOUBLECLICK = 12
    constant integer FRAME_SPRITE_ANIM_UPDATE = 13
endglobals

function toggleFuncBoard takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[3].toggle()
    endif
endfunction


function toggleAttrBoard takes nothing returns nothing
    local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[102].setText(I2S(IMinBJ(R2I((udg_baojilv[i]*100.)), 100))+"%")
        call zwidget[104].setText(I2S(R2I((udg_baojishanghai[i]*100.)))+"%")
        call zwidget[106].setText(I2S(R2I((udg_shanghaijiacheng[i]*100.)))+"%")
        call zwidget[108].setText(I2S(IMinBJ(R2I((udg_shanghaixishou[i]*100.)),80))+"%")

        call zwidget[110].setText(I2S(gengu[i]))
        call zwidget[112].setText(I2S(wuxing[i]))
        call zwidget[114].setText(I2S(jingmai[i]))
        call zwidget[116].setText(I2S(fuyuan[i]))
        call zwidget[118].setText(I2S(danpo[i]))
        call zwidget[120].setText(I2S(yishu[i]))

        call zwidget[122].setText(I2S(juexuelingwu[i]))
        call zwidget[124].setText(I2S(xiuxing[i]))
        call zwidget[126].setText("第"+I2S(wugongxiuwei[i])+"层")
        call zwidget[128].setText(I2S(shengwang[i]))
        call zwidget[130].setText(I2S(shoujiajf[i]))
        if not Deputy_isDeputy(i, LIAN_DAN) then
            call zwidget[132].setText(I2S(yongdanshu[i])+" / 10")
        else
            call zwidget[132].setText(I2S(yongdanshu[i])+" / 15")
        endif

        call zwidget[14].toggle()
    endif
endfunction

function toggleOpenButton takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[1].toggerHover("ReplaceableTextures\\CommandButtons\\BTNtab.blp", "ReplaceableTextures\\CommandButtons\\BTNtab.blp")
    endif
endfunction

function toggleWidget5 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[5].toggerHover("war3mapImported\\achievement01.tga", "war3mapImported\\achievement02.tga")
    endif
endfunction

function toggleWidget6 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[6].toggerHover("war3mapImported\\achievement01.tga", "war3mapImported\\achievement02.tga")
    endif
endfunction
function toggleWidget7 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[7].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
    endif
endfunction
function toggleWidget8 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[8].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
    endif
endfunction
function toggleWidget9 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[9].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
    endif
endfunction
function toggleWidget10 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[10].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
    endif
endfunction
function toggleWidget11 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[11].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
    endif
endfunction
function toggleWidget12 takes nothing returns nothing
    if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
        call zwidget[12].toggerHover("ReplaceableTextures\\CommandButtons\\BTNesc.blp", "ReplaceableTextures\\CommandButtons\\BTNesc.blp")
    endif
endfunction

function pressEsc takes nothing returns nothing
    local integer i = 1 + GetPlayerId(DzGetTriggerKeyPlayer())
    if DzGetTriggerKeyPlayer() == GetLocalPlayer() then
        call zwidget[102].setText(I2S(IMinBJ(R2I((udg_baojilv[i]*100.)), 100))+"%")
        call zwidget[104].setText(I2S(R2I((udg_baojishanghai[i]*100.)))+"%")
        call zwidget[106].setText(I2S(R2I((udg_shanghaijiacheng[i]*100.)))+"%")
        call zwidget[108].setText(I2S(IMinBJ(R2I((udg_shanghaixishou[i]*100.)),80))+"%")

        call zwidget[110].setText(I2S(gengu[i]))
        call zwidget[112].setText(I2S(wuxing[i]))
        call zwidget[114].setText(I2S(jingmai[i]))
        call zwidget[116].setText(I2S(fuyuan[i]))
        call zwidget[118].setText(I2S(danpo[i]))
        call zwidget[120].setText(I2S(yishu[i]))

        call zwidget[122].setText(I2S(juexuelingwu[i]))
        call zwidget[124].setText(I2S(xiuxing[i]))
        call zwidget[126].setText("第"+I2S(wugongxiuwei[i])+"层")
        call zwidget[128].setText(I2S(shengwang[i]))
        call zwidget[130].setText(I2S(shoujiajf[i]))
        if not Deputy_isDeputy(i, LIAN_DAN) then
            call zwidget[132].setText(I2S(yongdanshu[i])+" / 10")
        else
            call zwidget[132].setText(I2S(yongdanshu[i])+" / 15")
        endif
        call zwidget[134].setText(I2S(special_attack[i]))

        call zwidget[14].toggle()
    endif
endfunction

function releaseEsc takes nothing returns nothing
    if DzGetTriggerKeyPlayer() == GetLocalPlayer() then
        call zwidget[14].hide()
    endif
endfunction

function pressTab takes nothing returns nothing
    if DzGetTriggerKeyPlayer() == GetLocalPlayer() then
        call zwidget[3].toggle()
    endif
endfunction


function drawUI_Conditions takes nothing returns boolean
    local integer index = 100
    local integer ff1 = DzFrameGetHeroBarButton(1)
    local integer ff2 = DzFrameGetHeroBarButton(2)
    local integer ff3 = DzFrameGetHeroBarButton(3)
    local integer fh1 = DzFrameGetHeroHPBar(1)
    local integer fh2 = DzFrameGetHeroHPBar(2)
    local integer fh3 = DzFrameGetHeroHPBar(3)
    local integer fm1 = DzFrameGetHeroManaBar(1)
    local integer fm2 = DzFrameGetHeroManaBar(2)
    local integer fm3 = DzFrameGetHeroManaBar(3)

    call DzFrameSetSize(ff1, 0.03, 0.04)
    call DzFrameSetSize(ff2, 0.03, 0.04)
    call DzFrameSetSize(ff3, 0.03, 0.04)

    call DzFrameClearAllPoints(fh1)
    call DzFrameClearAllPoints(fh2)
    call DzFrameClearAllPoints(fh3)
    call DzFrameClearAllPoints(fm1)
    call DzFrameClearAllPoints(fm2)
    call DzFrameClearAllPoints(fm3)

    call DzFrameSetSize(fh1, 0.01, 0.01)
    call DzFrameSetSize(fh2, 0.01, 0.01)
    call DzFrameSetSize(fh3, 0.01, 0.01)
    call DzFrameSetSize(fm1, 0.01, 0.01)
    call DzFrameSetSize(fm2, 0.01, 0.01)
    call DzFrameSetSize(fm3, 0.01, 0.01)

    call DzFrameSetPoint(fh1,6,DzGetGameUI(),8,.1,.22)
    call DzFrameSetPoint(fh2,6,DzGetGameUI(),8,.1,.22)
    call DzFrameSetPoint(fh3,6,DzGetGameUI(),8,.1,.22)
    call DzFrameSetPoint(fm1,6,DzGetGameUI(),8,.1,.22)
    call DzFrameSetPoint(fm2,6,DzGetGameUI(),8,.1,.22)
    call DzFrameSetPoint(fm3,6,DzGetGameUI(),8,.1,.22)

    call DzLoadToc("ui\\custom.toc")

    // 创建功能开启按钮背景
    //set zwidget[1] = Frame.newImage1(GUI, "ReplaceableTextures\\CommandButtons\\BTNtab.blp", 0.03, 0.04)
    //call zwidget[1].setPoint(1, Frame.getFrame(DzFrameGetHeroBarButton(3)), 7, 0.0, -0.012)
    //call zwidget[1].setAlpha(255)


    // 创建功能开启按钮
    //set zbutton[1] = Frame.newTextButton(zwidget[1])
    //call zbutton[1].setAllPoints(zwidget[1])
    //call zbutton[1].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)

    //call DzFrameSetScript(udg_UI_Gn_AN[1], 2, "Trig_GN_JiemianAActions", false)
    //call DzFrameSetScript(udg_UI_Gn_AN[1], 3, "Trig_GN_JiemianBActions", false)
    //call DzFrameSetScript(udg_UI_Gn_AN[1], 1, "Trig_GN_JiemianCActions", false)
    // 功能界面
    set zwidget[3] = Frame.newImage1(GUI, "war3mapImported\\jz01.tga", 0.3, 0.3)
    call zwidget[3].setPoint(4, GUI, 4, 0.0, 0.08)
    call zwidget[3].hide()

    // 关闭按钮贴图
    set zwidget[4] = Frame.newImage1(zwidget[3], "war3mapImported\\close.tga", 0.02, 0.02)
    call zwidget[4].setPoint(4, zwidget[3], 2, - 0.01, - 0.01)

    // 关闭按钮
    set zbutton[2] = Frame.newTextButton(zwidget[4])
    call zbutton[2].setAllPoints(zwidget[4])
    call zbutton[2].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)

    // 任务面板
    set zwidget[5] = Frame.newImage1(zwidget[3], "war3mapImported\\achievement01.tga", 0.04, 0.015)
    call zwidget[5].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.021)

    set zbutton[3] = Frame.newTextButton(zwidget[5])
    call zbutton[3].setAllPoints(zwidget[5])
    call zbutton[3].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[3].regEvent(FRAME_MOUSE_ENTER, function toggleWidget5)
    call zbutton[3].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget5)

    // 地图成就
    set zwidget[6] = Frame.newImage1(zwidget[3], "war3mapImported\\achievement01.tga", 0.04, 0.015)
    call zwidget[6].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.061)

    set zbutton[4] = Frame.newTextButton(zwidget[6])
    call zbutton[4].setAllPoints(zwidget[6])
    call zbutton[4].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[4].regEvent(FRAME_MOUSE_ENTER, function toggleWidget6)
    call zbutton[4].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget6)

    set zwidget[7] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
    call zwidget[7].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.101)

    set zbutton[5] = Frame.newTextButton(zwidget[7])
    call zbutton[5].setAllPoints(zwidget[7])
    call zbutton[5].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[5].regEvent(FRAME_MOUSE_ENTER, function toggleWidget7)
    call zbutton[5].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget7)

    set zwidget[8] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
    call zwidget[8].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.141)

    set zbutton[6] = Frame.newTextButton(zwidget[8])
    call zbutton[6].setAllPoints(zwidget[8])
    call zbutton[6].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[6].regEvent(FRAME_MOUSE_ENTER, function toggleWidget8)
    call zbutton[6].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget8)

    set zwidget[9] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
    call zwidget[9].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.181)

    set zbutton[7] = Frame.newTextButton(zwidget[9])
    call zbutton[7].setAllPoints(zwidget[9])
    call zbutton[7].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[7].regEvent(FRAME_MOUSE_ENTER, function toggleWidget9)
    call zbutton[7].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget9)

    set zwidget[10] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
    call zwidget[10].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.221)

    set zbutton[8] = Frame.newTextButton(zwidget[10])
    call zbutton[8].setAllPoints(zwidget[10])
    call zbutton[8].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[8].regEvent(FRAME_MOUSE_ENTER, function toggleWidget10)
    call zbutton[8].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget10)

    set zwidget[11] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
    call zwidget[11].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.035,  -0.261)

    set zbutton[9] = Frame.newTextButton(zwidget[11])
    call zbutton[9].setAllPoints(zwidget[11])
    call zbutton[9].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
    call zbutton[9].regEvent(FRAME_MOUSE_ENTER, function toggleWidget11)
    call zbutton[9].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget11)

    // 创建属性开启按钮背景
    set zwidget[12] = Frame.newImage1(GUI, "ReplaceableTextures\\CommandButtons\\BTNesc.blp", 0.03, 0.04)
    call zwidget[12].setPoint(1, Frame.getFrame(DzFrameGetHeroBarButton(3)), 7, 0.0, -0.064)
    call zwidget[12].setAlpha(255)

    // 创建属性介绍
    //set zwidget[13]= Frame.newText1(zwidget[12], "属性", "TXA10")
    //call zwidget[13].setPoint(4, zwidget[12], 4, 0, 0)


    // 属性界面
    set zwidget[14] = Frame.newImage1(GUI, "war3mapImported\\blackback.tga", 0.3, 0.3)
    call zwidget[14].setPoint(4, GUI, 4, 0.0, 0.08)
    call zwidget[14].hide()

    // 显示属性
    set attrStr[1] = "暴击率："
    set attrStr[2] = "0%"
    set attrStr[3] = "暴击伤害："
    set attrStr[4] = "0%"
    set attrStr[5] = "伤害加成："
    set attrStr[6] = "0%"
    set attrStr[7] = "伤害吸收："
    set attrStr[8] = "0%"
    set attrStr[9] = "根骨："
    set attrStr[10] = "0"
    set attrStr[11] = "悟性："
    set attrStr[12] = "0"
    set attrStr[13] = "经脉："
    set attrStr[14] = "0"
    set attrStr[15] = "福缘："
    set attrStr[16] = "0"
    set attrStr[17] = "胆魄："
    set attrStr[18] = "0"
    set attrStr[19] = "医术："
    set attrStr[20] = "0"
    set attrStr[21] = "绝学领悟："
    set attrStr[22] = "0"
    set attrStr[23] = "修行："
    set attrStr[24] = "0"
    set attrStr[25] = "武学修为："
    set attrStr[26] = "0"
    set attrStr[27] = "江湖声望："
    set attrStr[28] = "0"
    set attrStr[29] = "守家积分："
    set attrStr[30] = "0"
    set attrStr[31] = "用丹数量："
    set attrStr[32] = "0"
    set attrStr[33] = "特殊攻击"
    set attrStr[34] = "0"

    set index = 101
    loop
        exitwhen index > 134
        set zwidget[index]= Frame.newText1(zwidget[14], attrStr[index - 100], "TXA15")
        if ModuloInteger(index, 2) == 0 then
            call zwidget[index].setPoint(TOPLEFT, zwidget[14], TOPLEFT, 0.01 + 0.07 * ModuloInteger(index - 101, 4) , (index - 97) / 4 * (-0.03))
        else
            call zwidget[index].setPoint(TOPLEFT, zwidget[14], TOPLEFT, 0.01 + 0.075 * ModuloInteger(index - 101, 4) , (index - 97) / 4 * (-0.03))
        endif
        if ModuloInteger(index, 2) == 0 then
            call zwidget[index].setColor255(255, 255, 255)
        else
            if index <= 108 then
                call zwidget[index].setColor255(0, 230, 230)
            elseif index <= 120 then
                call zwidget[index].setColor255(230, 230, 0)
            else
                call zwidget[index].setColor255(230, 0, 230)
            endif
        endif
        set index = index + 1
    endloop


    // 创建属性开启按钮
    set zbutton[10] = Frame.newTextButton(zwidget[12])
    call zbutton[10].setAllPoints(zwidget[12])
    call zbutton[10].regEvent(FRAME_EVENT_PRESSED, function toggleAttrBoard)

    set zwidget[1000] = Frame.newText1(zwidget[3], "杀狼任务（5/6）", "TXA15")
    call zwidget[1000].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, -0.035)
    call zwidget[1000].setColor255(0, 0, 0)

    set zwidget[1001] = Frame.newImage1(zwidget[3], "war3mapImported\\doing.tga", 0.044, 0.033)
    call zwidget[1001].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.235,  -0.027)

    set zwidget[1002] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
    call zwidget[1002].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, -0.09)
    call zwidget[1002].setColor255(0, 0, 0)

    set zwidget[1003] = Frame.newImage1(zwidget[3], "war3mapImported\\done.tga", 0.044, 0.033)
    call zwidget[1003].setPoint(TOPLEFT, zwidget[3], TOPLEFT,  0.235,  -0.082)

    set zwidget[1004] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
    call zwidget[1004].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, -0.145)
    call zwidget[1004].setColor255(0, 0, 0)

    set zwidget[1006] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
    call zwidget[1006].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, -0.2)
    call zwidget[1006].setColor255(0, 0, 0)

    set zwidget[1008] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
    call zwidget[1008].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, -0.255)
    call zwidget[1008].setColor255(0, 0, 0)

    // 按ESC查看人物属性
    // 27 = ESC, 9 = TAB
    call DzTriggerRegisterKeyEventByCode(null, 27, 1, false, function pressEsc)
    //call DzTriggerRegisterKeyEventByCode(null, 27, 0, false, function releaseEsc)

    // 按TAB查看任务
    //call DzTriggerRegisterKeyEventByCode(null, 9, 1, false, function pressTab)

    return false
endfunction


function initUI takes nothing returns nothing
    local trigger t = CreateTrigger()

	call TriggerRegisterTimerEventSingle(t, 1.)
	call TriggerAddCondition(t,Condition(function drawUI_Conditions))
	set t = null
    set t = null
endfunction