LZTEMP = nil
function LZPROFIC(p1,p2)
    if p1 ~= nil then
        LZTEMP = p1            --第一次读原武器类型，bcs里的变量存起来
    end
    if p2 ~= nil then
	    proficiency1 = LZTEMP  --原武器类型
        proficiency2 = p2      --第二次读新武器类型
		LZTEMP = nil           --两次变量值得到后清空第一次存起来的变量值

	local sprite = EEex_Sprite_GetSelected()
    local actorID = LZ_EEex_GetActorIDSelected(sprite)

    LZ_EEex_IterateActorEffects(actorID, function(eData)      --遍历所有effect
        local theopcode = LZ_EEex_ReadDword(eData + 0x10)
		--要求timingmode是9的proficiency2不存在，点数为0或nil或小于8则移除，防止转职覆盖
		local theparameter2 = LZ_EEex_ReadDword(eData + 0x20)   --proficiency
		local thetiming = LZ_EEex_ReadDword(eData + 0x24)       --timing mode
        local theparent_resource = LZ_EEex_ReadDword(eData + 0x94)
        if theopcode == 233 and theparameter2 == proficiency1 and thetiming == 9 and theparent_resource == 0 then
			LZ_EEex_WriteDword(eData + 0x20, proficiency2)
        end
    end)
end	
end


function LZPCHECK(p, step)
    local result = false
    local sprite = EEex_Sprite_GetSelected()
    local actorID = LZ_EEex_GetActorIDSelected(sprite)
    
    -- 提前准备字典，用于 step 为 2 时的逻辑
    local found_dict = {}

    LZ_EEex_IterateActorEffects(actorID, function(eData)
        -- step 为 1 的逻辑：只要找到符合条件的，就立刻结束遍历
        if step == 1 and result then return true end

        local theopcode = LZ_EEex_ReadDword(eData + 0x10)
        if theopcode ~= 233 then return end -- 提前过滤，节省性能
        
        local theparameter1 = LZ_EEex_ReadDword(eData + 0x1C)
        local theparameter2 = LZ_EEex_ReadDword(eData + 0x20)
        
        if step == 1 then
            -- 对应原来的第一个函数逻辑 (传入 p1)
            local thetiming = LZ_EEex_ReadDword(eData + 0x24)
            local theparent_resource = LZ_EEex_ReadDword(eData + 0x94)
            if theparameter2 == p and thetiming == 9 and theparent_resource == 0 then
                result = true
            end
            
        elseif step == 2 then
            -- 对应原来的第二个函数逻辑 (传入 p2)
            if (theparameter1 == 8 or theparameter1 == 16 or theparameter1 == 24 or theparameter1 == 32 or theparameter1 == 40) then
                found_dict[theparameter2] = true
            end
        end
    end)

    -- 根据 step 返回对应的结果
    if step == 1 then
        return result
    elseif step == 2 then
        -- 如果 p2 在字典里，返回 false；否则返回 true
        if found_dict[p] then
            return false
        else
            return true
        end
    end
end

function LZDCPACT()
    local sprite = EEex_Sprite_GetSelected()
    local actorID = LZ_EEex_GetActorIDSelected(sprite)
	--local slot = EEex_Sprite_GetPortraitIndex(sprite)
	local slot = sprite:getPortraitIndex()
	local hasTriggered = false
    LZ_EEex_IterateActorEffects(actorID, function(eData)           --遍历所有effect
        local theopcode = LZ_EEex_ReadDword(eData + 0x10)
        local theparameter1 = LZ_EEex_ReadDword(eData + 0x1C)      --233号effect武器熟练度	
		local theparameter1_L = theparameter1 % 8               -- 取余数，得到active class value
		local theparameter1_R = math.floor(theparameter1 / 8)   -- 除以8取整，得到original calss value
		local thetiming = LZ_EEex_ReadDword(eData + 0x24)
        local theparent_resource = LZ_EEex_ReadDword(eData + 0x94)
		if theopcode == 233 and theparameter1_R > theparameter1_L  and thetiming == 9 and theparent_resource == 0 then
           local newparameter1 = theparameter1 + theparameter1_R - theparameter1_L
		   LZ_EEex_WriteDword(eData + 0x1C,newparameter1)
		   hasTriggered = true
        end
    end)
	    -- 遍历完全结束后，判断开关状态。如果有过修改，则统一执行一次特效和休息
    if hasTriggered then
        C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", slot)
		C:Eval("SaveGame(0)")
    end
end

--[[
转职后原职业未激活状态：
1、原职业某项武器熟练度1星，LZ_EEex_ReadDword(eData + 0x1C)读出来数据=8，转职后在该武器类型再加1点读数=9、加2点=10、加3点=11、加4点=12、加5点=13
2、原职业某项武器熟练度2星，LZ_EEex_ReadDword(eData + 0x1C)读出来数据=16，转职后在该武器类型再加1点读数=17、加2点=18、加3点=19、加4点=20、加5点=21
3、原职业某项武器熟练度3星，LZ_EEex_ReadDword(eData + 0x1C)读出来数据=24，转职后在该武器类型再加1点读数=25、加2点=26、加3点=27、加4点=28、加5点=29
4、原职业某项武器熟练度4星，LZ_EEex_ReadDword(eData + 0x1C)读出来数据=32，转职后在该武器类型再加1点读数=33、加2点=34、加3点=35、加4点=36、加5点=37
5、原职业某项武器熟练度5星，LZ_EEex_ReadDword(eData + 0x1C)读出来数据=40，转职后在该武器类型再加1点读数=41、加2点=42、加3点=43、加4点=44、加5点=45
转职完成后，如果该武器原职业熟练度＞新职业熟练度，原熟练度会覆盖新熟练度(新熟练度没有也会覆盖)，比如原职业2星、新职业1星最终该武器熟练度=2星、读数为16+2=18，不再是原职业未激活时的17；如果原职业1星、新职业2星最终该武器熟练度=2星、读数为8+2=10同未激活。
]]