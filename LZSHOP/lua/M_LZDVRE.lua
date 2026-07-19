--队友死亡变量保护，每次休息后且非战斗情况下开启检测，有问题自动恢复。机制类似休息后出现敌人。

function LZ_DVCAR() --Death Variable Check And ‌Reset
--[[
    --EEex_IsPartyMember(targetID)

	local ScriptName = EEex_GetActorScriptName(actorID)
	local deathvariable = "SPRITE_IS_DEAD" .. ScriptName
	local isdead = EEex_GameState_GetGlobalInt(deathvariable)
	
]]

	-- 启动 0 ~ 5 的循环（对应 Player 1 ~ 6）
	for portraitIndex = 0, 5 do
		local actorID = EEex_Sprite_GetInPortraitID(portraitIndex)
    
		-- 1. 防火墙：actorID 存在且大于 0
		if actorID and actorID > 0 then
			local share = LZ_EEex_GetActorShare(actorID)
			-- 2. 内存防火墙：确保指针合法，防止闪退
			if share > 0 then
				-- 读取 ScriptName 和 当前血量
				local ScriptName = EEex_ReadLString(share + 0x488, 32)        --EEex自带
				local CurrentHP = LZ_EEex_ReadSignedWord(share + 0x57C, 0x0)  --调用其它lua，改名防冲突
            
				-- 3. 过滤条件：ScriptName 存在、不为空、且不等于字符串 "None"，当前血量大于或等于10
				if ScriptName and ScriptName ~= "" and ScriptName ~= "None" and CurrentHP and CurrentHP >= 10 then
                
					-- 拼接出死亡变量名，转为大写，例如 "SPRITE_IS_DEADKHALID"
					local deathVarName = "SPRITE_IS_DEAD" .. string.upper(ScriptName)
                
					-- 4. 获取全局死亡变量的数值
					local isDeadVal = EEex_GameState_GetGlobalInt(deathVarName)
                
					-- 5. 如果数值 >= 1，说明存在BUG，将其清零重置。活着的时候数值应该为0。
					if isDeadVal and isDeadVal >= 1 then
						EEex_GameState_SetGlobalInt(deathVarName, 0)
                    
						-- 在聊天框打印一条绿色的重置成功提示
						--Infinity_DisplayString("^GReset Death Variable^-: " .. deathVarName .. " GLOBAL set to 0")
						local msg = string.format("^GReset Death Variable^-: ^0xFFFFFFFF%s GLOBAL set to 0^-", deathVarName)
						Infinity_DisplayString(msg)
					end
				end
			end
		end
	end
end