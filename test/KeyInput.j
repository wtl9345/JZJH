
//========================================================================
//键盘输入系统
//========================================================================

#include "library/common_func.j"

function KeyInput takes nothing returns nothing
	local string s=GetEventPlayerChatString()
	local item it=null
	local player p=GetTriggerPlayer()
	local integer i=GetPlayerId(p)+1
	local integer j=0
	local location loc = null
	local string str = null
	local real array shanghai
	local integer pId =GetPlayerId(p)
	if s=="+" then
	    call SetCameraFieldForPlayer(p,CAMERA_FIELD_TARGET_DISTANCE,(GetCameraField(CAMERA_FIELD_TARGET_DISTANCE)+200.00),1.00)
	endif
	if s=="-" then
	    call SetCameraFieldForPlayer(p,CAMERA_FIELD_TARGET_DISTANCE,(GetCameraField(CAMERA_FIELD_TARGET_DISTANCE)-200.00),1.00)
	endif
	if s=="hg" or s=="HG" or s=="hc" or s=="HC" then
	    call SetUnitPosition(udg_hero[i],-1174,-678)
	    call PanCameraToTimedForPlayer(GetTriggerPlayer(),-1174,-678,0)
	endif
	if s=="q" then
		call SetUnitPosition(udg_hero[i],-869,796)
	    call PanCameraToTimedForPlayer(GetTriggerPlayer(),-869,796,0)
	endif
	if s=="3" then
		call SetUnitPosition(udg_hero[i],-869,-2000)
	    call PanCameraToTimedForPlayer(GetTriggerPlayer(),-869,-2000,0)
	endif
	if s=="4" then
		call SetUnitPosition(udg_hero[i],10692,-14847)
	    call PanCameraToTimedForPlayer(GetTriggerPlayer(),10692,-14847,0)
	endif

	if SubStringBJ(s,1,2)=="wq" then
		if UnitHaveItem(udg_hero[i], 'I0BH') == false then
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000当前未装备自制武器")
		else
			set it = FetchUnitItem(udg_hero[i], 'I0BH')
			call SaveStr(YDHT,GetHandleId(it),StringHash("武器名称"), SubStringBJ(s, 3, 40))
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000自制武器已更名为"+SubStringBJ(s, 3, 40))
		endif
	endif
	//if s == "randreal" then
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//endif
	if SubStringBJ(s,1,2)=="tx" then
		if S2I(SubStringBJ(s,3,4))>=1 and S2I(SubStringBJ(s,3,4))<=10 then
			set zizhiwugong[i].texiao=S2I(SubStringBJ(s,3,4))
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000自创武功已更改为第"+SubStringBJ(s, 3, 40)+"种特效")
		endif
	endif
	if SubStringBJ(s,1,2)=="wg" then
		if GetUnitAbilityLevel(udg_hero[i], 'A036') == 0 then
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000当前无自创武功")
		else
			set zizhiwugong[i].name = SubStringBJ(s, 3, 40)
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000自创武功已更名为"+SubStringBJ(s, 3, 40))
		endif
	endif
	if s=="ckwg" or s=="CKWG" then
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000剩余自创武功点："+I2S(wuxuedian[i]))
		if GetUnitAbilityLevel(udg_hero[i], 'A036') == 0 then
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000当前无自创武功")
		else
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000武功："+zizhiwugong[i].name)
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000伤害范围："+I2S(R2I(400.+100.*I2R(zizhiwugong[i].range))))
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000伤害系数："+R2S(1. + 0.5 * I2R(zizhiwugong[i].xishu)))
			set j = 1
			loop
				exitwhen j > zizhiwugong[i].dapeishu
				call DisplayTextToPlayer(p,0,0,dapei[20*i+j].XiaoGuoShuoMing())
				set j = j+1
			endloop
		endif
	endif
	if s=="ckwq" or s=="CKWQ" then
		if UnitHaveItem(udg_hero[i], 'I0BH') == false then
			call DisplayTextToPlayer(p,0,0,"|cFFFF0000当前未装备自制武器")
		else
			set it = FetchUnitItem(udg_hero[i], 'I0BH')
			if LoadStr(YDHT,GetHandleId(it),StringHash("武器名称"))=="" then
	    		call DisplayTextToPlayer(p,0,0,"|cFF00FF00武器名称：尚未输入")
	    	else
	    		call DisplayTextToPlayer(p,0,0,"|cFF00FF00武器名称："+LoadStr(YDHT,GetHandleId(it),StringHash("武器名称")))
			endif
	    	call DisplayTextToPlayer(p,0,0,"|cFFFF6600升级概率："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("升级概率"))))+"%")
	    	call DisplayTextToPlayer(p,0,0,"|cFFE500AF招式伤害："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("招式伤害"))))+" 内力："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("内力"))))+" 真实伤害："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("真实伤害")))))
	    	call DisplayTextToPlayer(p,0,0,"|cFFFF0033暴击伤害："+I2S(R2I(100*LoadReal(YDHT,GetHandleId(it),StringHash("暴击伤害"))))+"% 暴击率："+I2S(R2I(100*LoadReal(YDHT,GetHandleId(it),StringHash("暴击率"))))+"% 绝学领悟："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("绝学领悟")))))
	    	call DisplayTextToPlayer(p,0,0,"|cFFFFFF33根骨："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("根骨"))))+" 胆魄："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("胆魄"))))+" 悟性："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("悟性")))))
	    	call DisplayTextToPlayer(p,0,0,"|cFFFFFF33医术："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("医术"))))+" 经脉："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("经脉"))))+" 福缘："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("福缘")))))
			call DisplayTextToPlayer(p,0,0,"|cFF9933FF伤害回复："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("伤害回复"))))+" 杀怪回复："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("杀怪回复"))))+" 生命回复："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("生命回复"))))+" 法力回复："+I2S(R2I(LoadReal(YDHT,GetHandleId(it),StringHash("法力回复")))))
		endif
		//set j = 1
		//loop
		//	exitwhen j >= 7
	 //           if(GetItemType(UnitItemInSlotBJ(udg_hero[i],j))==ITEM_TYPE_ARTIFACT)then
		//	    	set it= UnitItemInSlotBJ(udg_hero[i],j)
		//	    	call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000当前使用武器："+GetItemName(it))
		//			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000武器耐久度:"+I2S(LoadInteger(YDHT,GetHandleId(it),0))+"/"+I2S(WeaponNaiJiu(it)))
		//			if udg_bqdsbool[i]==true then
		//				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000对"+GetItemName(it)+"的熟练度:"+I2S(R2I(LoadReal(YDHT,GetHandleId(p),GetItemTypeId(it))))+"/"+I2S(R2I(10000. * (1+WeaponLevel(GetItemTypeId(it))))))
		//			elseif Ce[i]==3 then
		//				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000对"+GetItemName(it)+"的熟练度:"+I2S(R2I(LoadReal(YDHT,GetHandleId(p),GetItemTypeId(it))))+"/"+I2S(R2I(5000. * (1+WeaponLevel(GetItemTypeId(it))))))
		//			else
		//				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000对"+GetItemName(it)+"的熟练度:"+I2S(R2I(LoadReal(YDHT,GetHandleId(p),GetItemTypeId(it))))+"/"+I2S(R2I(3000. * (1+WeaponLevel(GetItemTypeId(it))))))
		//			endif
	 //           endif
		//	set j = j + 1
		//endloop
		//if it==null then
		//	call DisplayTextToPlayer(p,0,0,"|cFFFF0000当前未装备武器")
		//endif
		//if Ce[i]==3 then
		//	call DisplayTextToPlayer(p, 0, 0, "|CFF66FF00您已经炼成了"+I2S(udg_bqds[i])+" / 3把武器")
		//endif
		//call DisplayTextToPlayer(p, 0, 0, "|CFF66FF00该系统已下线，欢迎体验新系统")
	endif
	
	if s=="ckjn" or s=="CKJN" then
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000人物性格：你学武资质"+XingGeA(udg_xinggeA[i])+"，态度"+XingGeB(udg_xinggeB[i]))
		call DisplayTextToPlayer(p,0,0,"|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
		set j = 1
		loop
			exitwhen j > wugongshu[i]
			call DisplayTextToPlayer(p,0,0,"|cFF00FFFF"+GetAbilityName(I7[(i-1)*20+j])+"第"+I2S(GetUnitAbilityLevel(udg_hero[i],I7[(i-1)*20+j]))+"重，升级进度："+LoadStr(YDHT,GetHandleId(p),I7[(i-1)*20+j]*2))
			set j = j + 1
		endloop
	    call DisplayTextToPlayer(p,0,0,"|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
	endif
	if s=="ckhf" or s=="CKHF" then
		call DisplayTextToPlayer(p,0,0,"|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
		call DisplayTextToPlayer(p,0,0,"|cFF00FFFF杀怪回复："+I2S(R2I(shaguaihufui[i])))
		call DisplayTextToPlayer(p,0,0,"|cFF00FFFF伤害回复："+I2S(R2I(shanghaihuifu[i])))
		call DisplayTextToPlayer(p,0,0,"|cFF00FFFF生命回复："+I2S(R2I(shengminghuifu[i])))
		call DisplayTextToPlayer(p,0,0,"|cFF00FFFF法力回复："+I2S(R2I(falihuifu[i])))
	    call DisplayTextToPlayer(p,0,0,"|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
	endif

	// 查看专属
	if s == "ckzs" then
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF灵鹫：玉扳指，天山童姥20%爆，八荒加属性概率增加")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF峨眉：倚天剑，灭绝师太接任务，打死副本3张无忌；或者副本6东方不败爆")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF明教：屠龙刀，副本6东方不败爆")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF武当：真武剑，90级去挑战场挑战张三丰,太极拳主动使用永久加1绝学领悟，被动使用概率加绝学领悟")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF全真：七星道袍，90级找丘处机接任务，加金雁攻速，三花聚顶弹射次数+50")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF少林：袈裟，90级去挑战场打达摩")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF华山：养吾剑，90级令狐冲处接任务挑战令狐冲，剑附带破防效果")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF恒山：拂尘，90级令狐冲接任务，教训田伯光，加2级拂尘范围")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF衡山：镇岳尚方，90级令狐冲接任务，江南水乡解决费彬，剑加青龙光环")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF泰山：东灵铁剑，90级令狐冲接任务，雁门关解决玉玑子，永久触发泰山十八盘")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF慕容：燕国玉玺，慕容复发布任务，慕容龙城称号和等级超过100级可以获取专属，袖中指加属性概率增加")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF神龙：毒龙鞭，副本1韦小宝（神龙教）触发任务杀死洪安通，接任务后洪安通出现在桃花岛上")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF丐帮：打狗棒，桃花岛洪七公，90级杀他才爆")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF古墓：双剑，副本4君子、淑女剑合成")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF星宿：神木王鼎，乔峰接任务，副本1杀丁春秋杀阿紫")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF血刀：血刀，90级挑战场挑战血刀老祖")
		 call DisplayTextToPlayer(p,0,0,"|cFF00FFFF自由：十四天书，具体合成请看基地右边NPC随风")
	endif

	if s == "cx" or s == "CX" then
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|cFFFF00CC"+"查询玩家:"+"|r"+LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9系统提示：|r"+"|CFFFE890D"+"战斗力："+I2S(udg_zdl[pId]))
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9系统提示：|r"+"|CFFFE890D"+"积分："+I2S(udg_jf[pId]))
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9系统提示：|r"+"|CFFFE890D"+"每局可用积分剩余："+I2S(jf_max - jf_useMax[pId]))
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9系统提示：|r"+"|CFFFE890D"+"通关次数："+I2S(udg_success[pId]))
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9系统提示：|r"+"|CFFFE890D"+"伤害兑换："+R2S(bonus_wugong[pId]*100)+"%")
		call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9系统提示：|r"+"|CFFFE890D"+"最高伤害："+R2S(max_damage[pId]))
	endif
	if s == "cxs" or s == "CXS" then
		loop
			exitwhen j > 4
			call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|cFFFF00CC"+"查询玩家:"+"|r"+GetPlayerName(Player(j)))
			call DisplayTimedTextToPlayer(Player(pId),0,0,10,"|CFF1CE6B9战斗力：|r"+I2S(udg_zdl[j])+",|CFF1CE6B9积分：|r"+I2S(udg_jf[j])+",|CFF1CE6B9每局积分：|r"+I2S(jf_max-jf_useMax[j])+",|r|CFF1CE6B9通关次数："+I2S(udg_success[j])+",|r|CFF1CE6B9伤害加成："+R2S(bonus_wugong[j])+",|r|CFF1CE6B9最高伤害："+R2S(max_damage[j]))
			set j = j + 1
		endloop
	endif

	// if s == "save" and is_victory and not saveFlag[pId] then
	// 	call DisplayTextToPlayer(p,0,0,"|CFF99CC00获得战斗力和积分："+I2S(get_zdl))
	// 	// 保存战斗力到服务器
	// 	set udg_zdl[pId] = udg_zdl[pId] + get_zdl
	// 	set udg_jf[pId] = udg_jf[pId] + get_zdl
	// 	call DzAPI_Map_StoreInteger(Player(pId),"zdl",udg_zdl[pId])
	// 	call DzAPI_Map_StoreInteger(Player(pId),"jf",udg_zdl[pId])
	// 	if GetPlayerServerValueSuccess(Player(pId)) then
	// 		call DisplayTextToPlayer(p,0,0,"|CFFFE890D"+GetPlayerName(Player(pId))+"|CFF99CC00数据保存成功")
	// 		set saveFlag[pId] = true
	// 	else
	// 		call DisplayTextToPlayer(p,0,0,"|CFFFE890D"+GetPlayerName(Player(pId))+"|CFFFF0303数据保存失败")
	// 		set saveFlag[pId] = false
	// 	endif
	// endif

	//if s=="碧海潮生" then
	//	call UnitAddAbility(udg_hero[i],'A018')
	//endif
	//if s=="空明" then
	//	call UnitAddAbility(udg_hero[i],'A017')
	//endif
	if s=="ck" then
			set j = 1
		loop
			exitwhen j >wugongshu[i]
			set shanghai[j]=LoadReal(YDHT,1+GetPlayerId(p),I7[(i-1)*20+j]*3)
			if I7[(i-1)*20+j] == 'A034' then
				set shanghai[j]=LoadReal(YDHT,1+GetPlayerId(p),'A035'*3)
			endif
			if shanghai[j]<10000. then
	            call DisplayTextToPlayer(p,0,0,"|cFF00FFFF"+GetAbilityName(I7[(i-1)*20+j])+"伤害："+R2S(shanghai[j]))
	        elseif shanghai[j]<100000000. then
	            call DisplayTextToPlayer(p,0,0,"|cFF00FFFF"+GetAbilityName(I7[(i-1)*20+j])+"伤害："+R2S(shanghai[j]/10000.)+"万")
	        elseif shanghai[j]/10000.<100000000. then
	            call DisplayTextToPlayer(p,0,0,"|cFF00FFFF"+GetAbilityName(I7[(i-1)*20+j])+"伤害："+R2S(shanghai[j]/100000000.)+"亿")
	        elseif shanghai[j]/100000000.<100000000. then
	        	call DisplayTextToPlayer(p,0,0,"|cFF00FFFF"+GetAbilityName(I7[(i-1)*20+j])+"伤害："+R2S(shanghai[j]/100000000./10000.)+"万亿")
	        else
	        	call DisplayTextToPlayer(p,0,0,"|cFF00FFFF"+GetAbilityName(I7[(i-1)*20+j])+"伤害："+R2S(shanghai[j]/100000000./100000000.)+"亿亿")
	        endif
			set j = j + 1
		endloop
	endif
	if s=="1" and GetUnitAbilityLevel(udg_hero[i],'A07W')>0 and IsUnitAliveBJ(udg_hero[i]) then
		if RectContainsUnit(lh_r,udg_hero[i]) then
			call DisplayTextToPlayer(p,0,0,"桃花岛不能创建飞行点")
		else
			call RemoveUnit(J9[i])
			set loc = GetUnitLoc(udg_hero[i])
			call CreateNUnitsAtLoc(1,1697656906,p,loc,bj_UNIT_FACING)
			set J9[i]=bj_lastCreatedUnit
			call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"创建飞行点")
			call RemoveLocation(loc)
			set loc = null
		endif
	endif
	if s=="2" and GetUnitAbilityLevel(udg_hero[i],'A07W')>0 and IsUnitAliveBJ(udg_hero[i]) then
		if J9[i]==null then
			call DisplayTextToPlayer(p,0,0,"你还没有设置飞行点，请输入聊天信息“1”来设置")
		else
			set loc = GetUnitLoc(J9[i])
			call SetUnitPositionLoc(udg_hero[i],loc)
			call PanCameraToTimedLocForPlayer(p,loc,0)
			call RemoveLocation(loc)
			set loc = null
		endif
	endif
	if s=="11" and GetUnitAbilityLevel(udg_hero[i],'A07W')>3 and IsUnitAliveBJ(udg_hero[i]) then
		if RectContainsUnit(lh_r,udg_hero[i]) then
			call DisplayTextToPlayer(p,0,0,"桃花岛不能创建飞行点")
		else
			call RemoveUnit(qiankun2hao[i])
			set loc = GetUnitLoc(udg_hero[i])
			call CreateNUnitsAtLoc(1,1697656906,p,loc,bj_UNIT_FACING)
			set qiankun2hao[i]=bj_lastCreatedUnit
			call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"创建飞行点")
			call RemoveLocation(loc)
			set loc = null
		endif
	endif
	if s=="22" and GetUnitAbilityLevel(udg_hero[i],'A07W')>3 and IsUnitAliveBJ(udg_hero[i]) then
		if qiankun2hao[i]==null then
			call DisplayTextToPlayer(p,0,0,"你还没有设置飞行点，请输入聊天信息“11”来设置")
		else
			set loc = GetUnitLoc(qiankun2hao[i])
			call SetUnitPositionLoc(udg_hero[i],loc)
			call PanCameraToTimedLocForPlayer(p,loc,0)
			call RemoveLocation(loc)
			set loc = null
		endif
	endif
	// if s=="111" and GetUnitAbilityLevel(udg_hero[i],'A07W')>2 and IsUnitAliveBJ(udg_hero[i]) then
	// 	if RectContainsUnit(lh_r,udg_hero[i]) then
	// 		call DisplayTextToPlayer(p,0,0,"桃花岛不能创建飞行点")
	// 	else
	// 		call RemoveUnit(qiankun3hao[i])
	// 		set loc = GetUnitLoc(udg_hero[i])
	// 		call CreateNUnitsAtLoc(1,1697656906,p,loc,bj_UNIT_FACING)
	// 		set qiankun3hao[i]=bj_lastCreatedUnit
	// 		call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"创建飞行点")
	// 		call RemoveLocation(loc)
	// 		set loc = null
	// 	endif
	// endif
	// if s=="222" and GetUnitAbilityLevel(udg_hero[i],'A07W')>2 and IsUnitAliveBJ(udg_hero[i]) then
	// 	if qiankun3hao[i]==null then
	// 		call DisplayTextToPlayer(p,0,0,"你还没有设置飞行点，请输入聊天信息“111”来设置")
	// 	else
	// 		set loc = GetUnitLoc(qiankun3hao[i])
	// 		call SetUnitPositionLoc(udg_hero[i],loc)
	// 		call PanCameraToTimedLocForPlayer(p,loc,0)
	// 		call RemoveLocation(loc)
	// 		set loc = null
	// 	endif
	// endif
	//if s==GetVIPNum(p, LoadStr(YDHT, GetHandleId(p), GetHandleId(p)*2)) then
	//	set udg_vip[i] = 1
	//	call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,15.,"|CFFff9933感谢玩家"+GetPlayerName(p)+"对决战江湖的赞助|r")
	//endif
	//if s=="我是赞助者" and udg_vip[i]==0 and vipbanlvbool[i]==false then
	//	set vipbanlv[i] = CreateUnit(p,'n00G',1860,-4140,254.7)
	//	set vipbanlvbool[i] = true
	//endif
	//if SubStringBJ(s,1,3)=="VIP" then
	//	set s = SubStringBJ(s, 4, 50)
	//	//call BJDebugMsg(s)
	//	//call BJDebugMsg(I2S(StringLength(s)))
	//	//call BJDebugMsg(I2S(IAbsBJ(StringHash(s))))
	//	set s = I2S(IAbsBJ(StringHash(s)))
	//	if StringLength(s) >= 6 then
	//		if StringLength(s) == 10 then
	//			call BJDebugMsg("您的VIP激活码是："+SubStringBJ(s, 5, 10))
	//		else
	//			call BJDebugMsg("您的VIP激活码是："+SubStringBJ(s, 1, 6))
	//		endif
	//	else
	//		call BJDebugMsg("您的VIP激活码是："+SubStringBJ(s+"013478", 1, 6))
	//	endif
	//endif
	if s=="-ms" then
		call DisplayTextToPlayer(p,0,0,"|cFF00FFFF您当前的移动速度为"+I2S(R2I(GetUnitMoveSpeedEx(udg_hero[i]))))
	endif
	if s=="-random" and udg_runamen[i]==0 and udg_hero[i]!=null then
	    call randomMenpai(p,1)
	endif
	if s=="www.juezhanjianghu.com" and udg_runamen[i]==0 and udg_hero[i]!=null then
		call DisplayTextToPlayer(p,0,0,"|cFF00FFFF灵鹫宫已加入积分兑换，请输入hg选择自由门派后去基地左下方兑换")
	endif
	// if s=="www.juezhanjianghu.com" and udg_runamen[i]==0 and udg_hero[i]!=null then
	// 	set udg_runamen[i]=12
	// 	call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,15.,"|CFFff9933玩家"+GetPlayerName(p)+"选择了隐藏门派〓灵鹫宫〓|r")
	//     call SetPlayerName(p,"〓灵鹫宫〓"+LoadStr(YDHT,GetHandleId(p),GetHandleId(p)))
	//     set danpo[i]=(danpo[i]+2)
	// 	set jingmai[i]=(jingmai[i]+2)
	// 	set fuyuan[i]=(fuyuan[i]+1)
	// 	call DisplayTimedTextToPlayer(p,0,0,15.,"|CFFff9933获得武功：凌波微步，你可以在主城和传送石之间任意传送了")
	// 	call AddCharacterABuff(udg_hero[i], udg_xinggeA[i])
    //     call AddCharacterBBuff(udg_hero[i], udg_xinggeB[i])
	//     call UnitAddAbility(udg_hero[i],'A05R')
	//     if udg_vip[i]<2 and udg_elevenvip[i]<1 then
	//     	call UnitAddAbility(udg_hero[i],'A040')
	//     	call UnitAddAbility(udg_hero[i],'A041')
	//     	call UnitAddAbility(udg_hero[i],'A042')
	//     endif
	//     set I7[(((i-1)*20)+8)]='A05R'
	//     call UnitRemoveAbility(udg_hero[i],'Avul')
	//     set Q4=GetRandomLocInRect(He)
	//     call SetUnitPositionLoc(udg_hero[i],Q4)
	//     call PanCameraToTimedLocForPlayer(p,Q4,0)
	//     call CreateNUnitsAtLoc(1,'nvul',p,Q4,bj_UNIT_FACING)
	//     set P4[i]=bj_lastCreatedUnit
	//     call RemoveLocation(Q4)
	//     call UnitAddItemByIdSwapped(1227896394,udg_hero[i])
	// endif

	// if s == "my gao v" and udg_vip[i] == 1 and udg_elevenvip[i] == 1 and udg_changevip[i] == 1 then
	// 	call DisplayTextToPlayer(p, 0, 0, I2S(NameProdVIP(LoadStr(YDHT, GetHandleId(p), GetHandleId(p)*2), 3)/10000))
	// endif
	//存青龙之戒
	// if s == "saveql" and UnitHaveItem(udg_hero[i], 'I0CQ') then
		// set str = GetPlayerName(p)
		// call SetPlayerName(p, LoadStr(YDHT, GetHandleId(p), GetHandleId(p)*2))
		// set it = FetchUnitItem(udg_hero[i], 'I0CQ')
		// call YDWE_PreloadSL_Set( p, "青龙", 6, 1 )
		// call YDWE_PreloadSL_Set( p, "招式伤害", 7, LoadInteger(YDHT,GetHandleId(it),StringHash("招式伤害")) )
		// call YDWE_PreloadSL_Set( p, "内力", 8, LoadInteger(YDHT,GetHandleId(it),StringHash("内力")) )
		// call YDWE_PreloadSL_Set( p, "真实伤害", 9, LoadInteger(YDHT,GetHandleId(it),StringHash("真实伤害")) )
		// call YDWE_PreloadSL_Set( p, "暴击伤害", 10, LoadInteger(YDHT,GetHandleId(it),StringHash("暴击伤害")) )
		// call YDWE_PreloadSL_Set( p, "绝学领悟", 11, LoadInteger(YDHT,GetHandleId(it),StringHash("绝学领悟")) )
		// call YDWE_PreloadSL_Set( p, "根骨", 12, LoadInteger(YDHT,GetHandleId(it),StringHash("根骨")) )
		// call YDWE_PreloadSL_Set( p, "胆魄", 13, LoadInteger(YDHT,GetHandleId(it),StringHash("胆魄")) )
		// call YDWE_PreloadSL_Set( p, "医术", 14, LoadInteger(YDHT,GetHandleId(it),StringHash("医术")) )
		// call YDWE_PreloadSL_Set( p, "经脉", 15, LoadInteger(YDHT,GetHandleId(it),StringHash("经脉")) )
		// call YDWE_PreloadSL_Set( p, "悟性", 16, LoadInteger(YDHT,GetHandleId(it),StringHash("悟性")) )
		// call YDWE_PreloadSL_Set( p, "福缘", 17, LoadInteger(YDHT,GetHandleId(it),StringHash("福缘")) )
		// call YDWE_PreloadSL_Set( p, "杀人数", 18, LoadInteger(YDHT,GetHandleId(it),StringHash("杀人数")) )
		// set udg_loadql[i] = true
		// call YDWE_PreloadSL_Save( p, "JueZhan", "VIP", SAV_NUM)
		// call DisplayTextToPlayer(p, 0, 0, "|CFFff9933青龙之戒状态已保存")
		// call SetPlayerName(p, str)
		// //call SaveQingLongZhiJie()
	// endif
	// if s == "loadql" and udg_loadql[i] == false then
		// //call BJDebugMsg("青龙在这")

		// //call YDWE_PreloadSL_Load( p, "JueZhan", "VIP", 18 )
		// if ((bj_lastLoadPreloadSLResult == true)) then
			// //call BJDebugMsg("青龙在这2")
        	// if YDWE_PreloadSL_Get(p, "ID", 1) == StringHash(LoadStr(YDHT, GetHandleId(p), GetHandleId(p)*2)) and YDWE_PreloadSL_Get(p, "青龙之戒", 6) == 1 then
        		// //call BJDebugMsg("青龙在这3")
        		// set loc = GetUnitLoc(udg_hero[i])
				// set it = CreateItemLoc('I0CQ', loc)
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("招式伤害"), YDWE_PreloadSL_Get(p, "招式伤害", 7))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("内力"), YDWE_PreloadSL_Get(p, "内力", 8))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("真实伤害"), YDWE_PreloadSL_Get(p, "真实伤害", 9))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("暴击伤害"), YDWE_PreloadSL_Get(p, "暴击伤害", 10))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("绝学领悟"), YDWE_PreloadSL_Get(p, "绝学领悟", 11))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("根骨"), YDWE_PreloadSL_Get(p, "根骨", 12))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("胆魄"), YDWE_PreloadSL_Get(p, "胆魄", 13))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("医术"), YDWE_PreloadSL_Get(p, "医术", 14))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("经脉"), YDWE_PreloadSL_Get(p, "经脉", 15))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("悟性"), YDWE_PreloadSL_Get(p, "悟性", 16))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("福缘"), YDWE_PreloadSL_Get(p, "福缘", 17))
				// call SaveInteger(YDHT,GetHandleId(it),StringHash("杀人数"), YDWE_PreloadSL_Get(p, "杀人数", 18))
				// call DisplayTextToPlayer(p, 0, 0, "|CFFff9933青龙之戒已读取")
				// set udg_loadql[i] = true
				// call RemoveLocation(loc)
				// set loc = null
        	// endif

    	// endif
	// endif
	// //查看青龙之戒
	// if s == "ckql" then
		// if UnitHaveItem(udg_hero[i], 'I0CQ') == false then
			// call DisplayTextToPlayer(p,0,0,"|cFFFF0000当前未装备青龙之戒")
		// else
			// set it = FetchUnitItem(udg_hero[i], 'I0CQ')
			// call DisplayTextToPlayer(p,0,0,"|cFFE500AF当前累积杀敌数："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("杀人数"))))
	    	// call DisplayTextToPlayer(p,0,0,"|cFFE500AF招式伤害："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("招式伤害")))+" 内力："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("内力")))+" 真实伤害："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("真实伤害"))))
	    	// call DisplayTextToPlayer(p,0,0,"|cFFFF0033暴击伤害："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("暴击伤害")))+"% 绝学领悟："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("绝学领悟"))))
	    	// call DisplayTextToPlayer(p,0,0,"|cFFFFFF33根骨："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("根骨")))+" 胆魄："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("胆魄"))))
	    	// call DisplayTextToPlayer(p,0,0,"|cFFFFFF33医术："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("医术")))+" 经脉："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("经脉"))))
	    	// call DisplayTextToPlayer(p,0,0,"|cFFFFFF33悟性："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("悟性")))+" 福缘："+I2S(LoadInteger(YDHT,GetHandleId(it),StringHash("福缘"))))
		// endif
	// endif

	if s=="jzjh.uuu9.com" and udg_runamen[i]==0 and udg_hero[i]!=null then
		set udg_runamen[i]=13
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,15.,"|CFFff9933玩家"+GetPlayerName(p)+"选择了隐藏门派〓姑苏慕容〓|r")
	    call SetPlayerName(p,"〓姑苏慕容〓"+LoadStr(YDHT,GetHandleId(p),GetHandleId(p)))
	    set udg_shuxing[i]=udg_shuxing[i]+5
		call DisplayTimedTextToPlayer(p,0,0,15.,"|CFFff9933获得武功：凌波微步，你可以在主城和传送石之间任意传送了")
	    call UnitAddAbility(udg_hero[i],'A05R')
	    call AddCharacterABuff(udg_hero[i], udg_xinggeA[i])
        call AddCharacterBBuff(udg_hero[i], udg_xinggeB[i])
	    if udg_vip[i]<2 and udg_elevenvip[i]<1 then
	    	call UnitAddAbility(udg_hero[i],'A040')
	    	call UnitAddAbility(udg_hero[i],'A041')
	    	call UnitAddAbility(udg_hero[i],'A042')
	    endif
	    set I7[(((i-1)*20)+8)]='A05R'
	    call UnitRemoveAbility(udg_hero[i],'Avul')
	    set Q4=GetRandomLocInRect(He)
	    call SetUnitPositionLoc(udg_hero[i],Q4)
	    call PanCameraToTimedLocForPlayer(p,Q4,0)
	    call CreateNUnitsAtLoc(1,'nvul',p,Q4,bj_UNIT_FACING)
	    set P4[i]=bj_lastCreatedUnit
	    call RemoveLocation(Q4)
	    call UnitAddItemByIdSwapped(1227896394,udg_hero[i])
	endif
	//if s=="jiafuyuan" then
	//	set fuyuan[i]=fuyuan[i]+20
	//	call DisplayTextToPlayer(p,0,0,"|cFFFF0000福缘+20")
	//endif
	if s=="cksx" then
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000剩余属性点："+I2S(udg_shuxing[i]))
	endif
	if s=="ckjf" then
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000剩余守家积分："+I2S(shoujiajf[i]))
	endif
	if s=="累积积分" then
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000累积游戏积分："+I2S(udg_MeiJuJiFen[i]))
	endif
	if SubStringBJ(s,1,5) == "zy500" and  udg_MeiJuJiFen[i] >= 500 then
		set udg_MeiJuJiFen[S2I(SubStringBJ(s,6,6))] = udg_MeiJuJiFen[S2I(SubStringBJ(s,6,6))] + 500
		set udg_MeiJuJiFen[i] = udg_MeiJuJiFen[i] - 500
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"|cFFFF0000"+LoadStr(YDHT,GetHandleId(p),GetHandleId(p))+"已向"+LoadStr(YDHT,GetHandleId(Player(S2I(SubStringBJ(s,6,6))-1)),GetHandleId(Player(S2I(SubStringBJ(s,6,6))-1)))+"转移500点积分")
	endif
	if s=="baolv" then
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000锁喉枪的爆率为："+I2S(udg_baolv[1]))
	endif
	if s=="+ys" or s=="+YS" then
		call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,(GetCameraField(CAMERA_FIELD_TARGET_DISTANCE)+200.00),1.00)
	endif
	if s=="+js" or s=="+JS" then
		call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,(GetCameraField(CAMERA_FIELD_TARGET_DISTANCE)-200.00),1.00)
	endif
	if s=="sj" then
		call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,1800.,0)
	endif
	if s=="fb" then
		call FBdaojishi()
	endif
	if s=="bl" then
		call BanLvShuXing()
	endif
	if s=="yx" then
		call YaoXing()
	endif
	if s=="jy" then
		call TransferJY()
	endif
	//自由属性点系统
	if SubStringBJ(s,1,2)=="wx" or SubStringBJ(s,1,2)=="WX" then
	    if udg_shuxing[i]>=1 then
	        if S2I(SubStringBJ(s,3,5))<=0 or S2I(SubStringBJ(s,3,5))>udg_shuxing[i] then
	            set wuxing[i]=wuxing[i]+1
	            set udg_shuxing[i]=udg_shuxing[i]-1
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配1点悟性，剩余属性点："+I2S(udg_shuxing[i]))
	        else
	            set wuxing[i]=wuxing[i]+S2I(SubStringBJ(s,3,5))
	            set udg_shuxing[i]=udg_shuxing[i]-S2I(SubStringBJ(s,3,5))
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配"+SubStringBJ(s,3,5)+"点悟性，剩余属性点："+I2S(udg_shuxing[i]))
	        endif
	    else
	        call DisplayTextToPlayer(p,0,0,"|cFFFF0000属性点已用完")
	    endif
	elseif SubStringBJ(s,1,2)=="fy" or SubStringBJ(s,1,2)=="FY" then
	    if udg_shuxing[i]>=1 then
	        if S2I(SubStringBJ(s,3,5))<=0 or S2I(SubStringBJ(s,3,5))>udg_shuxing[i] then
	            set fuyuan[i]=fuyuan[i]+1
	            set udg_shuxing[i]=udg_shuxing[i]-1
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配1点福缘，剩余属性点："+I2S(udg_shuxing[i]))
	        else
	            set fuyuan[i]=fuyuan[i]+S2I(SubStringBJ(s,3,5))
	            set udg_shuxing[i]=udg_shuxing[i]-S2I(SubStringBJ(s,3,5))
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配"+SubStringBJ(s,3,5)+"点福缘，剩余属性点："+I2S(udg_shuxing[i]))
	        endif
	    else
	        call DisplayTextToPlayer(p,0,0,"|cFFFF0000属性点已用完")
	    endif
	elseif SubStringBJ(s,1,2)=="gg" or SubStringBJ(s,1,2)=="GG" then
	    if udg_shuxing[i]>=1 then
	        if S2I(SubStringBJ(s,3,5))<=0 or S2I(SubStringBJ(s,3,5))>udg_shuxing[i] then
	            set gengu[i]=gengu[i]+1
	            set udg_shuxing[i]=udg_shuxing[i]-1
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配1点根骨，剩余属性点："+I2S(udg_shuxing[i]))
	        else
	            set gengu[i]=gengu[i]+S2I(SubStringBJ(s,3,5))
	            set udg_shuxing[i]=udg_shuxing[i]-S2I(SubStringBJ(s,3,5))
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配"+SubStringBJ(s,3,5)+"点根骨，剩余属性点："+I2S(udg_shuxing[i]))
	        endif
	    else
	        call DisplayTextToPlayer(p,0,0,"|cFFFF0000属性点已用完")
	    endif
	elseif SubStringBJ(s,1,2)=="dp" or SubStringBJ(s,1,2)=="DP" then
	    if udg_shuxing[i]>=1 then
	        if S2I(SubStringBJ(s,3,5))<=0 or S2I(SubStringBJ(s,3,5))>udg_shuxing[i] then
	            set danpo[i]=danpo[i]+1
	            set udg_shuxing[i]=udg_shuxing[i]-1
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配1点胆魄，剩余属性点："+I2S(udg_shuxing[i]))
	        else
	            set danpo[i]=danpo[i]+S2I(SubStringBJ(s,3,5))
	            set udg_shuxing[i]=udg_shuxing[i]-S2I(SubStringBJ(s,3,5))
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配"+SubStringBJ(s,3,5)+"点胆魄，剩余属性点："+I2S(udg_shuxing[i]))
	        endif
	    else
	        call DisplayTextToPlayer(p,0,0,"|cFFFF0000属性点已用完")
	    endif
	elseif SubStringBJ(s,1,2)=="ys" or SubStringBJ(s,1,2)=="YS" then
	    if udg_shuxing[i]>=1 then
	        if S2I(SubStringBJ(s,3,5))<=0 or S2I(SubStringBJ(s,3,5))>udg_shuxing[i] then
	            set yishu[i]=yishu[i]+1
	            set udg_shuxing[i]=udg_shuxing[i]-1
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配1点医术，剩余属性点："+I2S(udg_shuxing[i]))
	        else
	            set yishu[i]=yishu[i]+S2I(SubStringBJ(s,3,5))
	            set udg_shuxing[i]=udg_shuxing[i]-S2I(SubStringBJ(s,3,5))
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配"+SubStringBJ(s,3,5)+"点医术，剩余属性点："+I2S(udg_shuxing[i]))
	        endif
	    else
	        call DisplayTextToPlayer(p,0,0,"|cFFFF0000属性点已用完")
	    endif
	elseif SubStringBJ(s,1,2)=="jm" or SubStringBJ(s,1,2)=="JM" then
	    if udg_shuxing[i]>=1 then
	        if S2I(SubStringBJ(s,3,5))<=0 or S2I(SubStringBJ(s,3,5))>udg_shuxing[i] then
	            set jingmai[i]=jingmai[i]+1
	            set udg_shuxing[i]=udg_shuxing[i]-1
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配1点经脉，剩余属性点："+I2S(udg_shuxing[i]))
	        else
	            set jingmai[i]=jingmai[i]+S2I(SubStringBJ(s,3,5))
	            set udg_shuxing[i]=udg_shuxing[i]-S2I(SubStringBJ(s,3,5))
	            call DisplayTextToPlayer(p,0,0,"|cFFFF0000分配"+SubStringBJ(s,3,5)+"点经脉，剩余属性点："+I2S(udg_shuxing[i]))
	        endif
	    else
	        call DisplayTextToPlayer(p,0,0,"|cFFFF0000属性点已用完")
	    endif
	endif
	
	//测试码
	if s=="代码不乱用吧" and udg_isTest[GetPlayerId(p)] then
		call SetHeroLevel(udg_hero[i],GetHeroLevel(udg_hero[i])+5,true)
		set wuxuedian[i] = wuxuedian[i] + 5
		call unitadditembyidswapped(1227895642,udg_hero[i])
		call unitadditembyidswapped('I053',udg_hero[i])
		call unitadditembyidswapped('I054',udg_hero[i])
		call unitadditembyidswapped('I055',udg_hero[i])
		call unitadditembyidswapped('I04E',udg_hero[i])
		call unitadditembyidswapped('I02S',udg_hero[i])
		//call CreateNUnitsAtLoc(1,'o01U',GetTriggerPlayer(),GetUnitLoc(udg_hero[i]),bj_UNIT_FACING)
		set shengwang[i]=shengwang[i]+5000
		set xiuxing[i] = 5
		set udg_lilianxishu[i]=udg_lilianxishu[i]+3
		set udg_shuxing[i]=udg_shuxing[i]+3000
		set shoujiajf[i]=shoujiajf[i]+1000
	endif
	if s=="ts" and testVersion then
		call unitadditembyidswapped('I0CI',udg_hero[i])
		call unitadditembyidswapped('I0CH',udg_hero[i])
		call unitadditembyidswapped('I0DO',udg_hero[i])
		call unitadditembyidswapped('I01X',udg_hero[i])
		call unitadditembyidswapped('I01P',udg_hero[i])
		call unitadditembyidswapped('I01C',udg_hero[i])
		call unitadditembyidswapped('I010',udg_hero[i])
		call unitadditembyidswapped('I00W',udg_hero[i])
		call unitadditembyidswapped('I06F',udg_hero[i])
		call unitadditembyidswapped('I03A',udg_hero[i])
		call unitadditembyidswapped('I00L',udg_hero[i])
		call unitadditembyidswapped('I08W',udg_hero[i])
	endif
	if s=="九阴真人" and testVersion then
		call unitadditembyidswapped('I02X',udg_hero[i])
		call unitadditembyidswapped('I03I',udg_hero[i])
		call unitadditembyidswapped('I09H',udg_hero[i])
		call unitadditembyidswapped('I09I',udg_hero[i])
		call unitadditembyidswapped('I09G',udg_hero[i])
		call unitadditembyidswapped('I09J',udg_hero[i])
		call unitadditembyidswapped('I09K',udg_hero[i])
	endif
	if s=="贼哥牛逼" and testVersion then
		if UnitTypeNotNull(GetTriggerUnit(),UNIT_TYPE_HERO) then
			call ModifyHeroStat(0, GetTriggerUnit(), 0, 100000)
            call ModifyHeroStat(1, GetTriggerUnit(), 0, 100000)
            call ModifyHeroStat(2, GetTriggerUnit(), 0, 100000)
		endif
		call AdjustPlayerStateBJ(1000000, p, PLAYER_STATE_RESOURCE_GOLD) // 奖励金钱
		call AdjustPlayerStateBJ(1000000,p,PLAYER_STATE_RESOURCE_LUMBER) // 木头
		call SetHeroLevel(udg_hero[i],GetHeroLevel(udg_hero[i])+5,true)
		set wuxuedian[i] = wuxuedian[i] + 500
		call unitadditembyidswapped(1227895642,udg_hero[i])
		call unitadditembyidswapped('I08V',udg_hero[i])
		call unitadditembyidswapped('I08W',udg_hero[i])
		call unitadditembyidswapped('I08X',udg_hero[i])
		call unitadditembyidswapped('I08Y',udg_hero[i])
		call unitadditembyidswapped('I08Z',udg_hero[i])
		call unitadditembyidswapped('I090',udg_hero[i])
		set shengwang[i]=shengwang[i]+50000
		set xiuxing[i] = 5
		set udg_lilianxishu[i]=udg_lilianxishu[i]+3
		set udg_shuxing[i]=udg_shuxing[i]+30000
		set shoujiajf[i]=shoujiajf[i]+10000
	endif
	if s == "next" and testVersion then
		set udg_boshu=udg_boshu+1
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000已跳转至下一波")
	endif 
	if s=="撸下一波" and udg_isTest[GetPlayerId(p)] then
		set udg_boshu=udg_boshu+1
		call DisplayTextToPlayer(p,0,0,"|cFFFF0000已跳转至下一波")
	endif
	if s == "撸Boss8" or s=="撸boss8" and udg_isTest[GetPlayerId(p)] then 
		call CreateNUnitsAtLocFacingLocBJ(1,u7[8],Player(6),v7[6],v7[4])
	endif
	// if s == "撸Boss" or s=="撸boss" and udg_isTest[GetPlayerId(p)] then 
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[5],Player(6),v7[6],v7[4])
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[1],Player(6),v7[6],v7[4])
	// endif
	// if s=="撸Boss1" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[1],Player(6),v7[6],v7[4])
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[1],Player(0),v7[6],v7[4])
	// elseif s=="撸Boss2" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[2],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss3" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[3],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss4" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[4],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss5" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[5],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss6" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[6],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss7" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[7],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss8" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[8],Player(6),v7[6],v7[4])
	// elseif s=="撸LiaoGuo" and udg_vip[i]>1 then
	// 	call LiaoGuoJinGong()
	// elseif s=="撸LingJiu" and udg_vip[i]>1 then
	// 	call LingJiuGongJinGong()
	// endif
	set p=null
	set it=null
endfunction

function KeyInputSystem takes nothing returns nothing
	local trigger t = CreateTrigger()
	local integer i = 0
	loop
		exitwhen i > 6
		call TriggerRegisterPlayerChatEvent(t,Player(i),"",true)
		set i = i + 1
	endloop
	call TriggerAddAction(t,function KeyInput)
	set t = null
endfunction
