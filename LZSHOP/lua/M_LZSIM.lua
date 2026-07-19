-- 第一个参数effectObject没有用到，用下划线 _ 占住位置，确保第二个参数 creatureObject 能正确接收到克隆体指针
function LZSIMCAI(_, creatureObject)  --Simulacrum Change AI

	local playerchoice = EEex_GameState_GetGlobalInt("LZIMAGAI")
		if playerchoice < 1 or playerchoice > 3 then return end

	if aiButtonToggle == 0 then return end

	local creatureData = LZ_ME_UDToPtr(creatureObject)
	local targetID = LZ_EEex_ReadDword(creatureData + 0x48)   -- 读取克隆体 ID
	local masterID = LZ_EEex_ReadDword(creatureData + 0x5214) -- 读取主人 ID
		if targetID == 0 or masterID <= 0 then return end      -- 没找到主人则直接退出

	local share = LZ_EEex_GetActorShare(targetID)
		if share == 0 then return end -- 安全保护，防止指针获取失败

	-- 1. 获取克隆体相关数据
	local scriptname = EEex_ReadLString(share + 0x488, 32)
	local specificsscript = EEex_ReadLString(share + 0x3B68, 8)
	local allegiance = LZ_EEex_ReadByte(share + 0x38)

	-- 2. 前置条件：必须是特定的脚本名且 specificsscript 为空
		if scriptname == "COPY" and (specificsscript == nil or specificsscript == "") then

			local apply  = EEex_GameObject_ApplyEffect
			local getObj = EEex_GameObject_Get

			local function applyAiScript(resName)
				apply(getObj(targetID), {
					["effectID"]     = 82,
					["targetType"]   = 2,
					["dwFlags"]      = 2,
					["res"]          = resName,
					["sourceID"]     = targetID -- sourceID 作为自我来源标识
				})
			end

			local function runBranchA()
				if allegiance == 255 then
					applyAiScript("LZSIMAI1")
				end
			end
			
			local function runBranchB()
				if allegiance <= 7 then
					applyAiScript("LZSIMPC1")
				end
			end

			-- 根据 playerchoice 变量进行分流判断
			if playerchoice == 1 then
				runBranchA()
			elseif playerchoice == 2 then
				runBranchB()
			elseif playerchoice == 3 then
				runBranchA()
				runBranchB()
			end
			
		end
	
end


--[[
function EEex_ApplyEffectToActor(actorID, args)
	if args["effectList"] == nil then
		args["effectList"] = 1
	end

	EEex_GameObject_ApplyEffect(EEex_GameObject_Get(actorID), {
["effectID"] = args["opcode"],
["targetType"] = args["target"],
["spellLevel"] = args["power"],
["effectAmount"] = args["parameter1"],
["dwFlags"] = args["parameter2"],
["durationType"] = args["timing"],
["duration"] = args["duration"],
["probabilityUpper"] = args["probability1"],
["probabilityLower"] = args["probability2"],
["res"] = args["resource"],
["m_res"] = args["resource"],
["numDice"] = args["dicenumber"],
["diceSize"] = args["dicesize"],
["savingThrow"] = args["savingthrow"],
["saveMod"] = args["savebonus"],
["special"] = args["special"],
["school"] = args["school"],
["m_flags"] = args["resist_dispel"],
["m_effectAmount2"] = args["parameter3"],
["m_effectAmount3"] = args["parameter4"],
["m_effectAmount4"] = args["parameter5"],
["m_effectAmount5"] = args["time_applied"],
["m_res2"] = args["vvcresource"],
["m_res3"] = args["resource2"],
["sourceX"] = args["source_x"],
["sourceY"] = args["source_y"],
["targetX"] = args["target_x"],
["targetY"] = args["target_y"],
["m_sourceType"] = args["restype"],
["m_sourceRes"] = args["parent_resource"],
["m_sourceFlags"] = args["resource_flags"],
["m_projectileType"] = args["impact_projectile"],
["m_slotNum"] = args["sourceslot"],
["m_scriptName"] = args["effvar"],
["m_casterLevel"] = args["casterlvl"],
["m_firstCall"] = args["internal_flags"],
["m_secondaryType"] = args["sectype"],
["sourceTarget"] = args["source_target"],
["sourceID"] = args["source_id"],
["effectList"] = args["effectList"],
["noSave"] = args["noSave"],
["immediateResolve"] = args["immediateResolve"],
})
end
]]