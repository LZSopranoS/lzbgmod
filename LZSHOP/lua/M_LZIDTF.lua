-- 职业字典表格（放在函数外部，只在脚本加载时初始化一次）
local classDict = {
	[1]  = "MAGE", [2]  = "FIGHTER", [3]  = "CLERIC", [4]  = "THIEF", [5]  = "BARD", [6]  = "PALADIN",[7]  = "FIGHTER_MAGE", [8]  = "FIGHTER_CLERIC", [9]  = "FIGHTER_THIEF", [10] = "FIGHTER_MAGE_THIEF", [11] = "DRUID",
	[12] = "RANGER", [13] = "MAGE_THIEF",[14]  = "CLERIC_MAGE", [15]  = "CLERIC_THIEF", [16]  = "FIGHTER_DRUID", [17]  = "FIGHTER_MAGE_CLERIC", [18]  = "CLERIC_RANGER", [19]  = "SORCERER", [20]  = "MONK", [21]  = "SHAMAN",
}

-- 效果字典放在函数外部（只在脚本加载时初始化一次，省内存）
local opcodeDict = {
	[0]  = "AC bonus", [1]  = "Modify attacks per round", [3]  = "Berserk", [5]  = "Charm creature", [6]  = "Charisma bonus", [10]  = "Constitution bonus", [12]  = "Damage", [13]  = "Kill target", [15]  = "Dexterity bonus",
	[16]  = "Haste", [17]  = "Current HP bonus", [18]  = "Maximum HP bonus", [19]  = "Intelligence bonus", [21]  = "Lore bonus", [22]  = "Luck bonus", [23]  = "Morale bonus", [24]  = "Panic", [25]  = "Poison",
	[27]  = "Acid resistance bonus", [28]  = "Cold resistance bonus", [29]  = "Electricity resistance bonus", [30]  = "Fire resistance bonus", [31]  = "Magic damage resistance bonus", [33]  = "Save vs death bonus",
	[34]  = "Save vs wand bonus", [35]  = "Save vs polymorph bonus", [36]  = "Save vs breath bonus", [37]  = "Save vs spell bonus", [38]  = "Silence", [39]  = "Sleep", [40]  = "Slow", [42]  = "Bonus wizard spells",
	[43]  = "Stone to flesh", [44]  = "Strength bonus", [45]  = "Stun", [48]  = "Vocalize", [49]  = "Wisdom bonus", [53]  = "Animation change", [54]  = "Base THAC0 bonus", [55]  = "Slay", [58]  = "Dispel effects",
	[60]  = "Casting failure", [62]  = "Bonus priest spells", [65]  = "Blur", [73]  = "Attack damage bonus", [74]  = "Blindness", [76]  = "Feeblemindedness", [78]  = "Disease", [80]  = "Deafness",
	[86]  = "Slashing resistance bonus", [87]  = "Crushing resistance bonus", [88]  = "Piercing resistance bonus", [89]  = "Missile resistance bonus", [93]  = "Fatigue bonus", [94]  = "Intoxication",
	[98]  = "Regeneration", [106]  = "Morale break", [109]  = "Paralyze", [111]  = "Create weapon", [126]  = "Movement rate bonus", [128]  = "Confusion", [134]  = "Petrification", [135]  = "Polymorph",
	[151]  = "Replace self", [157]  = "Web effect", [163]  = "Free action", [165]  = "Pause target", [166]  = "Magic resistance bonus", [167]  = "Missile THAC0 bonus", [168]  = "Remove creature",
	[173]  = "Poison resistance bonus", [175]  = "Hold creature", [176]  = "Movement rate bonus 2", [185]  = "Hold creature 2", [191]  = "Casting level bonus", [193]  = "Invisibility detection", [209]  = "Power word kill",
	[210]  = "Power word stun", [211]  = "Imprisonment", [213]  = "Maze", [216]  = "Level drain", [217]  = "Power word sleep", [222]  = "Teleport field", [224]  = "Restoration", [235]  = "Wing buffet",
	[238]  = "Disintegrate", [241]  = "Control creature", [263]  = "Backstab bonus", [264]  = "Drop item", [271]  = "Disable creature", [274]  = "Phase", [278]  = "THAC0 bonus", [280]  = "Wild magic",
	[281]  = "Wild surge bonus", [284]  = "Melee THAC0 bonus", [285]  = "Melee weapon damage bonus", [286]  = "Missile weapon damage bonus", [288]  = "Fist THAC0 bonus", [289]  = "Fist damage bonus", [316]  = "Rest",
	[317]  = "Haste 2", [333]  = "Static charge", [343]  = "HP swap",
}

--[[写法2
	local effectNameToOpcode = {
		Haste = 16, Slow = 40, ["Stone to flesh"] = 43, ["Strength bonus"] = 44, Stun = 45, ["Wisdom bonus"] = 49, ["Animation change"] = 53, Slay = 55, Polymorph = 135, Disintegrate = 238,
	}
]]


-- 一次遍历检测角色所有免疫状态：武器，法术等级，特殊，特定 Opcode 免疫，锁血/锁属性
function LZ_GetActorImmunitySummaryX(actorID)
	-- 1. 内部动态初始化结果表格
	local result = {
		-- 武器免疫
		non_magicl = false, magicl = false,
		-- 1~9 级法术等级免疫初始
		sl1 = false, sl2 = false, sl3 = false, sl4 = false, sl5 = false, sl6 = false, sl7 = false, sl8 = false, sl9 = false,
		-- 4 种特殊免疫
		backstab = false, turnundead = false, track = false, timestop = false,
		-- 专门存放特定 Opcode 免疫结果的子表格
		min_hp = false, min_stats = false,
		--通常习惯把子表格放在大表格的最后一行
		opcodes = {}
	}
	
	-- 根据外部字典，动态将需要检测的 Opcode 免疫初始设为 false
	for opNum, _ in pairs(opcodeDict) do result.opcodes[opNum] = false end
	
	
	-- 2. 核心单次遍历开始
	LZ_EEex_IterateActorEffects(actorID, function(eData)
	
		local the_opcode = LZ_EEex_ReadDword(eData + 0x10)

		-- 分流 A：处理武器免疫 (Opcode 120)
		if the_opcode == 120 then
			local the_parameter2 = LZ_EEex_ReadDword(eData + 0x20)
			if the_parameter2 == 2 then
				result.non_magicl = true
			elseif the_parameter2 == 1 then
				result.magicl = true
			elseif the_parameter2 == 0 then
				local the_parameter1 = LZ_EEex_ReadDword(eData + 0x1C)
				-- 只有当读出来的等级在 1~6 范围内时，才进行精准赋值
				if the_parameter1 >= 1 and the_parameter1 <= 6 then
					result[the_parameter1] = true
				end
			end
	
		-- 分流 B：处理法术等级免疫 (Opcode 102, 199)
		elseif the_opcode == 102 or the_opcode == 199 then
			local the_parameter1 = LZ_EEex_ReadDword(eData + 0x1C)
			for sLv = 1, 9 do
				if the_parameter1 == sLv then result["sl" .. sLv] = true end
			end
		
		-- 分流 C：处理特定免疫 (Opcode 292, 297, 308, 310)
		elseif the_opcode == 292 or the_opcode == 297 or the_opcode == 308 or the_opcode == 310 then
			local the_parameter2 = LZ_EEex_ReadDword(eData + 0x20)
			if the_parameter2 == 1 then
				if the_opcode == 292 then result.backstab = true
				elseif the_opcode == 297 then result.turnundead = true
				elseif the_opcode == 308 then result.track = true
				elseif the_opcode == 310 then result.timestop = true
				end
			end
		
		-- 分流 D：处理特定 Opcode 免疫 (Opcode 101, 198)
		elseif the_opcode == 101 or the_opcode == 198 then
			local the_parameter2 = LZ_EEex_ReadDword(eData + 0x20)
			-- 读取结果是数字直接作为键存入，省去所有 tonumber 和判断
			result.opcodes[the_parameter2] = true
		
		-- 分流 E：检测 208 和 367 的不死机制
		elseif the_opcode == 208 or the_opcode == 367 then
			if the_opcode == 208 then
				local the_parameter1 = LZ_EEex_ReadDword(eData + 0x1C)
				if the_parameter1 > 0 then result.min_hp = true end
			else
				local the_parameter2 = LZ_EEex_ReadDword(eData + 0x20)
				if the_parameter2 > 0 then result.min_stats = true end
			end
		end		
	end)
	
	return result
end

--生物信息查看功能，鼠标移动到目标生物上按下K起效。

EEex_Key_AddPressedListener(function(key)
    if key == EEex_Key_GetFromName("K") then
        LZ_CREIdentify()
    end
end)


function LZ_CREIdentify() --Creature Identify

	local object = EEex_GameObject_GetUnderCursor()
		if not object or not EEex_GameObject_IsSprite(object) then return end

    local sprite = EEex_Sprite_GetSelected()
		if not sprite then return end
		--if not EEex_GameObject_IsSprite(sprite) then return end
		
	local actorID = object.m_id
	
	--local id = EEex_Sprite_GetSelectedID()  改用UnderCursor判断，非Selected判断
	
	Infinity_DisplayString("======== ^0xFF00E000Creature Information^- ========")

-- ========================================================
-- 核心：定义输出的字符串变量
-- ========================================================
	local baseInfoStr = ""

	-- 辅助函数：用来向 baseInfoStr 追加信息并自动补上 " | " 分隔符
	local function appendBaseInfo(text)
		if text and text ~= "" then
			baseInfoStr = (baseInfoStr == "") and text or (baseInfoStr .. " | " .. text)
		end
	end

-- ========================================================
-- 名字
-- ========================================================	
	local nameref = object.m_sName.m_pchData:get()
	--local nameref = EEex_Sprite_GetNameRef(sprite)
	if nameref and nameref ~= "" then
		appendBaseInfo("^0x00FFFF8BName^-: " .. nameref)
	end

-- ========================================================
-- 血量格式 99/100
-- ========================================================
--[[
	local CurrentHP = 0 -- 外面登记变量，给个默认值

	local share = LZ_EEex_GetActorShare(actorID)
	if share > 0 then
		CurrentHP = LZ_EEex_ReadSignedWord(share + 0x57C, 0x0) -- 不要加 local
	end
]]
	local share = LZ_EEex_GetActorShare(actorID)
	local CurrentHP = (share > 0) and LZ_EEex_ReadSignedWord(share + 0x57C, 0x0) or 0  -- 三元表达式写法

	--local CurrentHP = EEex_GetActorCurrentHP(actorID)
	--local CurrentHP = LZ_EEex_ReadWord(creatureData + 0x57C, 0x0)

	local MaxHP = EEex_Sprite_GetStat(object, 1)
	--local MaxHP = EEex_GetActorStat(actorID, 1)

	if CurrentHP and MaxHP then
		appendBaseInfo(string.format("^0xFF8000FFHP^-: %d/%d", CurrentHP, MaxHP))
	else
		appendBaseInfo("^0xFF8000FFHP^-: Unknown")
	end

-- ========================================================
-- AC
-- ========================================================
	local ac = EEex_Sprite_GetStat(object, 2)
	if ac then
		appendBaseInfo("^DAC^-: " .. ac)
	else
		appendBaseInfo("^DAC^-: Unknown")
	end

-- ========================================================
-- 职业
-- ========================================================
	--local classNum = EEex_GetActorClass(actorID)
	local classNum = EEex_GameObject_GetClass(object)
	local className = "Other"  -- 默认设为 Other

	if classNum then
		-- 使用 or 运算符安全查询字典，如果没查到就保持默认的 "Other"
		className = classDict[classNum] or "Other"
	end
	appendBaseInfo("^0xFFDDA0DDClass^-: " .. className)

-- ========================================================
-- 等级格式 11/12/13
-- ========================================================
	local level1 = EEex_Sprite_GetStat(object, 34)
	local level2 = EEex_Sprite_GetStat(object, 68)
	local level3 = EEex_Sprite_GetStat(object, 69)

	if level1 then
		local levelStr = "^0xFFDA70D6Level^-: " .. level1
		if level2 then levelStr = levelStr .. "/" .. level2 end
		if level3 then levelStr = levelStr .. "/" .. level3 end
		appendBaseInfo(levelStr)
	else
		appendBaseInfo("^0xFFDA70D6Level^-: Unknown")  -- 读不到主等级时，显示为文本
	end

-- ========================================================
-- 最终拼接输出
-- ========================================================
	if baseInfoStr ~= "" then
		Infinity_DisplayString(baseInfoStr)
	end


-- ========================================================
-- 豁免
-- ========================================================
	local savevsspell = EEex_Sprite_GetStat(object, 13)
	local savevsdeath = EEex_Sprite_GetStat(object, 9)
	local savevsbreath = EEex_Sprite_GetStat(object, 12)
	local savevswand = EEex_Sprite_GetStat(object, 10)
	local savevspoly = EEex_Sprite_GetStat(object, 11)
	
	local savestr
	
	if savevsdeath and savevswand and savevspoly and savevsbreath and savevsspell then 
		savestr = string.format("^0xFF8000FFSave^-: %d(Death), %d(Wand), %d(Polymorph), %d(Breath), %d(Spell)", savevsdeath, savevswand, savevspoly, savevsbreath, savevsspell) 
	else 
		savestr = "^0xFF8000FFSave^-: Unknown"
	end 

	Infinity_DisplayString(savestr)


-- ========================================================
-- 抗性
-- ========================================================
	local fireres = EEex_Sprite_GetStat(object, 14)
	local coldres = EEex_Sprite_GetStat(object, 15)
	local elecres = EEex_Sprite_GetStat(object, 16)
	local acidres = EEex_Sprite_GetStat(object, 17)
	local poisres = EEex_Sprite_GetStat(object, 74)
	local magicres = EEex_Sprite_GetStat(object, 18)
	local magicdamres = EEex_Sprite_GetStat(object, 73)
	local slashres = EEex_Sprite_GetStat(object, 21)
	local crushres = EEex_Sprite_GetStat(object, 22)
	local pierceres = EEex_Sprite_GetStat(object, 23)
	local missileres = EEex_Sprite_GetStat(object, 24)

	local resStr

	if fireres and coldres and elecres and acidres and poisres and magicres and magicdamres and slashres and crushres and pierceres and missileres then
		resStr = string.format(
			"^DResistance^-: %d(FR), %d(CR), %d(ER), %d(AR), %d(PR), %d(MR), %d(MDR), %d(Slash), %d(Crush), %d(Pierce), %d(Missile)",
			fireres, coldres, elecres, acidres, poisres, magicres, magicdamres, 
			slashres, crushres, pierceres, missileres
		)
	else
		resStr = "^DResistance^-: Unknown"
	end

	Infinity_DisplayString(resStr)


-- ========================================================
-- 核心调用：获取目标的所有免疫快照
-- ========================================================
	local immunity = LZ_GetActorImmunitySummaryX(actorID)

-- ========================================================
-- 1. 免疫武器显示
-- ========================================================
	local weaponStr = ""

	if immunity.non_magicl == true then
		weaponStr = "Non-magical"
	end

	if immunity.magicl == true then
		weaponStr = (weaponStr == "") and "Magical" or (weaponStr .. ", Magical")
	end

	-- 显示为 +1, +2等
	for enchant = 1, 6 do
		if immunity[enchant] == true then
			local text = "+" .. enchant
			weaponStr = (weaponStr == "") and text or (weaponStr .. ", " .. text)
		end
	end

	-- 如果字符串不为空，说明存在武器免疫，直接输出
	if weaponStr ~= "" then
		local formattedStr = string.format("^0xFF008BFFImmuneToWeapon^-: ^C%s^-", weaponStr)
		Infinity_DisplayString(formattedStr)
	end

-- ========================================================
-- 2. 法术等级显示 (1 ~ 9)
-- ========================================================
	local immunespllvStr = ""

	for spelllv = 1, 9 do
		if immunity["sl" .. spelllv] == true then
			local lvText = "Lv" .. spelllv
			-- 伪三元运算：如果是第一个等级直接赋值，后续等级自动用逗号拼接
			immunespllvStr = (immunespllvStr == "") and lvText or (immunespllvStr .. ", " .. lvText)
		end
	end

	-- 如果字符串不为空，说明存在法术等级免疫，直接输出
	if immunespllvStr ~= "" then
		local formattedStr = string.format("^0xFFFF8C00ImmuneToSpellLevel^-: ^0xFFFFE6D0%s^-", immunespllvStr)
		Infinity_DisplayString(formattedStr)
	end

-- ===========================================================
-- 3. 特定免疫显示 (Backstab, Turn Undead, Tracking, Time Stop)
-- ===========================================================
	local specialStr = ""

	if immunity.backstab then
		specialStr = "Backstab"
	end

	if immunity.turnundead then
		specialStr = (specialStr == "") and "Turn Undead" or (specialStr .. ", " .. turnundead)
	end

	if immunity.track then
		specialStr = (specialStr == "") and "Tracking" or (specialStr .. ", " .. "Tracking")
	end

	if immunity.timestop then
		specialStr = (specialStr == "") and "Time Stop" or (specialStr .. ", " .. "Time Stop")
	end

	-- 如果字符串不为空，说明有特定免疫，直接输出
	if specialStr ~= "" then
		Infinity_DisplayString(string.format("^0xFFDDA0DDImmuneToSpecial^-: ^4%s^-", specialStr))
	end

-- ========================================================
-- 4. 特定 Opcode 免疫显示
-- ========================================================
	local immuneOpcodeStr = ""

	for opcode, effectName in pairs(opcodeDict) do
		if immunity.opcodes[opcode] == true then
			-- 格式化出单个效果名，例如 "Panic(24)"
			local singleEffect = string.format("%s(%d)", effectName, opcode)  
			-- 类似条件 ? 结果1 : 结果2的“伪三元运算符”写法，：如果是第一个元素就直接赋值，后面的元素自动补上逗号
			immuneOpcodeStr = (immuneOpcodeStr == "") and singleEffect or (immuneOpcodeStr .. ", " .. singleEffect)
		end
	end

	-- 如果字符串不为空，说明有免疫效果，直接输出
	if immuneOpcodeStr ~= "" then
		local formattedStr = string.format("^0xFFDA70D6ImmuneToEffect^-: ^3%s^-", immuneOpcodeStr)
		Infinity_DisplayString(formattedStr)
	end

-- ========================================================
-- 5. 不死机制免疫显示
-- ========================================================
	local killImmStr = ""
	local labelText = ""

	-- 组合情况 1：两个同时存在
	if immunity.min_hp == true and immunity.min_stats == true then
		killImmStr = "Minimum HP(208), Minimum base stats(367)"
		labelText = "Can't be normally killed"

	-- 组合情况 2：只有 Minimum HP(208)
	elseif immunity.min_hp == true then
		killImmStr = "Minimum HP(208)"
		labelText = "Can't be normally killed"

	-- 组合情况 3：只有 Minimum base stats(367)
	elseif immunity.min_stats == true then
		killImmStr = "Minimum base stats(367)"
		labelText = "Protected by"
	end

	-- 如果触发了任意一种不死机制，则整合成一行高亮输出
	if killImmStr ~= "" then
		local formattedStr = string.format("^0xFF00FA9A%s^-: ^0xFF00FFFF%s^-", labelText, killImmStr)
		Infinity_DisplayString(formattedStr)
	end


-- ========================================================
-- 改良前的代码
-- ========================================================
--[[	
	-- 1. 保存 lv1~9 的法术层级
	local spellLevels = {1, 2, 3, 4, 5, 6, 7, 8, 9}
	local immunesplList = {} -- 用于临时存放所有判定为免疫的等级文本

	-- 2. 遍历表格，将所有免疫的等级收集到 immunesplList 中
	for _, spelllv in ipairs(spellLevels) do
		--if EEex_IsImmuneToSpellLevel(actorID, spelllv, includeSpellDeflection) then
		if EEex_IsImmuneToSpellLevel(actorID, spelllv, false) then
			table.insert(immunesplList, "Lv" .. spelllv) -- 满足条件则存入，例如 "Lv1"
		end
	end

	-- 3. 判断是否有免疫的等级，如果有，拼接成一行输出
	if #immunesplList > 0 then
		-- 使用 ", " 将表格内容连接起来，变成 "Lv1, Lv2, Lv5" 这样的纯文本
		local Immunespllvstr = table.concat(immunesplList, ", ")
    
		-- 只输出一次，呈现在同一行
		Infinity_DisplayString(string.format("ImmuneToSpellLevel:%s", Immunespllvstr))
	end
]]

--[[
	local immuneOpcodeList = {} -- 用于临时存放所有判定为免疫的效果文本

	-- 这里使用 pairs 遍历字典
	for opcode, effectName in pairs(opcodeDict) do
		if EEex_IsImmuneToOpcode(actorID, opcode) then
			-- 格式化为 "Haste(16)" 的字符串形式并存入表格
			local effectStr = string.format("%s(%d)", effectName, opcode)
			table.insert(immuneOpcodeList, effectStr)
		end
	end
--]]
--[[对应外部字典写法2	
	-- 此时遍历出来的是：名称在前（键），Opcode在后（值）
	for effectName, opcode in pairs(effectNameToOpcode) do
		if EEex_IsImmuneToOpcode(actorID, opcode) then
			local effectStr = string.format("%s(%d)", effectName, opcode)
			table.insert(immuneOpcodeList, effectStr)
		end
	end
]]	
--[[
	-- 判断是否有免疫的效果，如果有，拼接成一行输出，# 是长度操作符，空表格长度为0，加判断防止出现空白提示
	if #immuneOpcodeList > 0 then
		-- 使用 ", " 将表格内容连接起来，变成 "Haste(16), Slow(40)" 这样的纯文本
		local ImmuneOpcodestr = table.concat(immuneOpcodeList, ", ")
    
		-- 只输出一次，呈现在同一行
		Infinity_DisplayString(string.format("ImmuneToOpcode:%s", ImmuneOpcodestr))
	end
]]
	
end

--显示基本信息名字、血量……豁免、抗性需要function LZ_ME_UDToPtr(userdata)、function LZ_EEex_GetActorShare(actorID)支持
--显示免疫武器、法术、特殊、效果需要function LZ_EEex_IsSprite(actorID, allowDead)、function LZ_EEex_IterateActorEffects(actorID, func)支持