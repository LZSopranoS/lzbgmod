--[[
EEex_Actionbar_AddListener(function(config, state)
    for i = 0, 11 do
        if buttonArray:GetButtonType(i) == EEex_Actionbar_ButtonType.QUICK_SPELL_1 then
            EEex_Actionbar_SetButton(i, EEex_Actionbar_ButtonType.QUICK_WEAPON_3)
        end
        if buttonArray:GetButtonType(i) == EEex_Actionbar_ButtonType.QUICK_SPELL_2 then
            EEex_Actionbar_SetButton(i, EEex_Actionbar_ButtonType.QUICK_WEAPON_4)
        end
    end
end)
]]

--local SAVEKEY = 1
local TBAID = {}  --THIEVING Button Active Char ID
--local TBAN = {}   --THIEVING Button Active Char Name

--[[
function SaveTableToGlobal()
    -- 1. 将表格 {100, 200, 300} 转换成字符串 "100,200,300"
    local dataString = table.concat(TBAID, ",")
    
    -- 2. 存入 EEex 全局变量 (这就写入了存档)
    EEex_SetGlobal("SAVEKEY", dataString)
    
    --print("已保存数据: " .. dataString)
end

function LoadTableFromGlobal()
    -- 1. 读取字符串
    local dataString = EEex_GetGlobal(SAVEKEY)
    
    if dataString and dataString ~= "" then
        -- 2. 重置表格
        TBAID = {}
        
        -- 3. 将字符串 "100,200,300" 分割回表格
        -- 注意：EEex/Lua 环境通常自带 strsplit 或类似函数，如果没有可以用 string.gmatch
        for value in string.gmatch(dataString, "[^,]+") do
            table.insert(TBAID, tonumber(value)) -- 记得转回数字
        end
        
        --print("数据已读取，共有 " .. #TBAID .. " 个ID")
    else
        TBAID = {} -- 没读到数据，初始化为空
    end
end
]]

function GETTBACN() --Get THIEVING Button Active Char Name,通过effect调用一次使button和特定角色绑定
   local sprite = EEex_Sprite_GetSelected()

   local actorID = EEex_GetActorIDSelected(sprite)
   
   --local aa = EEex_GetActorIDArea(actorID)
   
   --local aaa = EEex_GetActorStat(actorID, 88)
   --EEex_DS(aaa)
   local bbb = EEex_GetActorState(actorID)
   EEex_DS(bbb)
   --local ccc = EEex_HasState(actorID, 2415919104)
   --EEex_DS(ccc)
   local ddd = EEex_GetActorSpellState(actorID, 119)
   EEex_DS(ddd)
   --local eee = EEex_GetActorModalState(actorID)
   --EEex_DS(eee)
   --local fff = EEex_IsImmuneToOpcode(actorID, opcode)
   --EEex_DS(fff)
   
   --local eff1 = EEex_Sprite_IterateEffects(sprite, func)
   --EEex_DS(eff1)
   --local eff2 = EEex_IterateActorEffects(actorID, func)
   --EEex_DS(eff2)
   
   --local actorID = EEex_GetActorIDCharacter(slot)
   --local actorID = EEex_GetActorIDShare(CGameAIBase)
   --local actorID = EEex_ReadDword(CGameEffect + 0x10C)
    if actorID == -1 then 
        return 
    end

    for _, v in ipairs(TBAID) do
        if v == actorID then
            Infinity_DisplayString("已存在" .. actorID)
            return
        end
    end


        table.insert(TBAID, actorID)
        Infinity_DisplayString("添加成功" .. actorID)
		EEex_DS(TBAID)
		--EEex_DS(aa)


end
   
   
   --table.insert(TBAID, actorID)
   
      -- 2. 【关键】立即保存整个表格到 Global
   --SaveTableToGlobal()
      -- 数据变动后，立即保存（或者只在存档时保存，看你需求）
   --EEex_GameState_SetGlobalInt("SAVEKEY", actorID)
   --Infinity_DisplayString("TBAID数据: " .. actorID)
   --EEex_DS(TBAID)
   --EEex_DS(SAVEKEY)
   
   --EEex_SetGlobal("SAVEKEY", actorID) 
   --Infinity_DisplayString("TBAID数据: " .. actorID)
   --EEex_DS(TBAID)
   --EEex_DS(SAVEKEY)
   --table.insert(TBAN, name)
   --Infinity_DisplayString("TBAN数据: " .. name)
--end

function SETBTOCH() --Set Button To Character
   local sprite = EEex_Sprite_GetSelected()
   local actorID = EEex_GetActorIDSelected(sprite)
   --local creatureData = EEex_GetActorShare(actorID)
   --local name = EEex_ReadDword(creatureData + 0x560)
   
   local ddd = EEex_GetActorSpellState(actorID, 119)
   EEex_DS(ddd)
   
    if buttonArray:GetButtonType(4) ~= 12 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
	    for i, CID in ipairs(TBAID) do  -- Character ID In Table
		if CID == actorID then
		EEex_Actionbar_SetButton(4, 12)
        Infinity_DisplayString("激活: " .. CID)
		EEex_DS(TBAID)
		break -- 找到后跳出循环
		end
    end
end

--if buttonArray:GetButtonType(4) ~= 12 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 and actorID == 140642401 then
		--EEex_Actionbar_SetButton(4, 12)
        --Infinity_DisplayString("激活: " .. CID)
--end


end
EEex_Actionbar_AddListener(SETBTOCH)

--[[
function LZDualClassButtonChange()
   local SO = EEex_GameObject_GetSelected() -- 选择的角色
   local SOClass = EEex_GameObject_GetClass(SO) -- 转职后的职业
   local actorID = EEex_GetActorIDSelected(SO)
   --local actor = EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568)
   --local DCCheck = ME_IsDualClassed(actorID) -- 判断转职
   --local Flag = EEex_GetActorShare(actorID)
   
   --local player1D = EEex_GetActorShare(EEex_GetActorIDCharacter(0))
   --local name = EEex_ReadDword(creatureData + 0x560)
   local creatureData = EEex_GetActorShare(actorID)
   local OC = EEex_ReadByte(creatureData + 0x568) --Original class
   Infinity_DisplayString(actorID)
   EEex_DS(creatureData)
   
   local constantID = EEex_ReadDword(creatureData + 0x780)
   local extraFlags = EEex_ReadDword(creatureData + 0x784)
   local animationData = EEex_ReadDword(EEex_GetActorShare(actorID) + 0x580)
   local overrideScript = EEex_ReadLString(creatureData + 0x7A0, 8)
   local defaultScript = EEex_ReadLString(creatureData + 0x7C0, 8)
   EEex_DS(constantID)
   EEex_DS(extraFlags)
   EEex_DS(animationData)
   EEex_DS(overrideScript)
   EEex_DS(defaultScript)
   
   EEex_SetLocal(actorID, LZLPlayer1, 2)
   EEex_SetGlobal(LZGPlayer1, 3)
   
   local MOLI1 = EEex_GetLocal(actorID, LZLPlayer1)
   EEex_DS(MOLI1)
   
   local sprite = EEex_Sprite_GetSelected()
   local OLI1 = EEex_Sprite_GetLocalInt(sprite, LZLPlayer1)
   local OLI2 = EEex_Sprite_GetLocalInt(sprite, LZLPlayer2)
   local OLS = EEex_Sprite_GetLocalString(sprite, LZTest)
   local OGI1 = EEex_GameState_GetGlobalInt(LZGPlayer1)
   local OGS2 = EEex_GameState_GetGlobalString(LZGPlayer2)
   Infinity_DisplayString(OLI1)
   EEex_DS(OLI2)
   EEex_DS(OLS)
   Infinity_DisplayString(OGI1)
   EEex_DS(OGI2)
   EEex_DS(OGS)
   
   --if OGI1 == 3 then
		--C:Eval("ActionOverride(Player1,SetGlobal("LZGPlayer1","GLOBAL",4))")
		--C:Eval("ActionOverride(Player1, SetGlobal(\"LZGPlayer1\", \"GLOBAL\", 4))")
	--end
   
end
]]

--[[
function LZDualClassButtonChange(config, state)
   local SO = EEex_GameObject_GetSelected() -- 选择的角色
   local SOClass = EEex_GameObject_GetClass(SO) -- 转职后的职业
   local actorID = EEex_GetActorIDSelected(SO)
   --local actor = EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568)
   --local DCCheck = ME_IsDualClassed(actorID) -- 判断转职
   --local Flag = EEex_GetActorShare(actorID)
   
   --local player1D = EEex_GetActorShare(EEex_GetActorIDCharacter(0))
   --local name = EEex_ReadDword(creatureData + 0x560)
   local creatureData = EEex_GetActorShare(actorID)
   local OC = EEex_ReadByte(creatureData + 0x568) --Original class
   
   if buttonArray:GetButtonType(5) ~= 7 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 and OC == 8 then  --原职业战士，背包、特殊技能栏没有["GUARD"] = 7按钮
      EEex_Actionbar_SetButton(5, 7)
   end
   if buttonArray:GetButtonType(4) ~= 12 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 and OC == 64 then  --原职业盗贼，背包、特殊技能栏没有["THIEVING"] = 12按钮
      EEex_Actionbar_SetButton(3, 4)
	  EEex_Actionbar_SetButton(4, 12)
	  EEex_Actionbar_SetButton(5, 11)
   end
   if buttonArray:GetButtonType(6) ~= 3 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 and OC == 16 then  --原职业法师，背包、特殊技能栏没有["CAST_SPELL"] = 3按钮
      EEex_Actionbar_SetButton(6, 3)
   end
   if buttonArray:GetButtonType(3) ~= 13 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 and OC == 32 then  --原职业牧师，背包、特殊技能栏没有["TURN_UNDEAD"] = 13按钮
      EEex_Actionbar_SetButton(3, 13)
   end
   if buttonArray:GetButtonType(3) ~= 2 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then  --诗人，背包、特殊技能栏没有["BARD_SONG"] = 2按钮
      EEex_Actionbar_SetButton(3, 2)
   end
end
--EEex_Actionbar_AddListener(LZDualClassButtonChange)
]]

--[[
function LZDualClassButtonChange(config, state)
   local SO = EEex_GameObject_GetSelected() -- 选择的角色
   local SOClass = EEex_GameObject_GetClass(SO) -- 转职后的职业
   local actorID = EEex_GetActorIDSelected(SO)
   --local actor = EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568)
   --local DCCheck = ME_IsDualClassed(actorID) -- 判断转职
   --local Flag = EEex_GetActorShare(actorID)
   
   --local player1D = EEex_GetActorShare(EEex_GetActorIDCharacter(0))
   --local creatureD = ME_UDToPtr(player1D)
   --local targe = EEex_ReadDword(creatureD + 0x34)
   
   --local actor = EEex_ReadDword(player1D + 0x10)
   
   local creatureData = EEex_GetActorShare(actorID)
   local OC = EEex_ReadByte(creatureData + 0x568) --Original class
   local BTA1 = buttonArray:GetButtonType(0)
   local BTA2 = buttonArray:GetButtonType(1)
   local BTA3 = buttonArray:GetButtonType(2)
   local BTA4 = buttonArray:GetButtonType(3)
   local BTA5 = buttonArray:GetButtonType(4)
   local BTA6 = buttonArray:GetButtonType(5)
   local BTA7 = buttonArray:GetButtonType(6)
   local BTA8 = buttonArray:GetButtonType(7)
   --Infinity_DisplayString(actorID)
   --EEex_DS(creatureData)
   --EEex_DS(OC)
   EEex_DS(BTA1)
   EEex_DS(BTA2)
   EEex_DS(BTA3)
   EEex_DS(BTA4)
   EEex_DS(BTA5)
   EEex_DS(BTA6)
   EEex_DS(BTA7)
   EEex_DS(BTA8)

   if buttonArray:GetButtonType(4) ~= 12 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 and OC == 64 then  --Original class is Thief
      EEex_WriteByte(creatureData + 0x568, 0)
	  game:SelectAll()
	  EEex_WriteByte(creatureData + 0x568, 64)
   end
end
EEex_Actionbar_AddListener(LZDualClassButtonChange)
]]

--[[
function LZDualClassButtonChange(config, state)
   local SO = EEex_GameObject_GetSelected() -- 选择的角色
   local SOClass = EEex_GameObject_GetClass(SO) -- 转职后的职业
   local actorID = EEex_GetActorIDSelected(SO)
   local DCCheck = ME_IsDualClassed(actorID) -- 判断转职
   EEex_DS(SOClass)
   Infinity_DisplayString(actorID)
   EEex_DS(DCCheck)
   if DCCheck and SOClass == 9 then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.THIEVING)
   end
end
EEex_Actionbar_AddListener(LZDualClassButtonChange)
]]

--[[
function LZDualClassButtonChange(config, state)
    -- 1. 获取选中对象
    local go = EEex_GameObject_GetSelected()
    if not go then return end -- 防止没选中人时报错

    -- 2. 获取属性
    local stats = go:getActiveStats()
    
    -- 3. 获取 Kit ID (注意：m_nKit 是 Kit，m_nClass 是基础职业)
    local kitId = stats.m_nKit
    
    -- 4. 打印结果 (修正了变量名和格式)
    -- 注意：这里直接打印数字，不要用 aiType
    print("    +--------------+-----+-----------------------------+")

    -- 5. 在这里写你的按钮逻辑 (比如根据 kitId 决定是否允许转职)
    -- if kitId == 0x4005 then ... end
end
]]

--[[
function PrintClass()
    local cccc = EEex_GameObject_GetSelected():getActiveStats().m_nKit
	print(cccc)
end
]]



