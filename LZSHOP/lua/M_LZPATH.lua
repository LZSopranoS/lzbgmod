-- ============================================================================
-- 1. EEex 基础内存读写函数 - 专属全局自适应兼容层 (带 LZ_ 前缀，防冲突)(address, value)
-- ============================================================================
LZ_EEex_ReadByte        = EEex_ReadByte        or function(addr) return EEex_ReadU8(addr) end
LZ_EEex_ReadSignedByte  = EEex_ReadSignedByte  or function(addr) return EEex_Read8(addr) end
LZ_EEex_ReadWord        = EEex_ReadWord        or function(addr) return EEex_ReadU16(addr) end
LZ_EEex_ReadSignedWord  = EEex_ReadSignedWord  or function(addr) return EEex_Read16(addr) end
LZ_EEex_ReadDword       = EEex_ReadDword       or function(addr) return EEex_Read32(addr) end
LZ_EEex_ReadQword       = EEex_ReadQword       or function(addr) return EEex_ReadU64(addr) end
LZ_EEex_ReadSignedQword = EEex_ReadSignedQword or function(addr) return EEex_Read64(addr) end

LZ_EEex_WriteByte       = EEex_WriteByte       or function(addr, val) EEex_Write8(addr, val) end
LZ_EEex_WriteWord       = EEex_WriteWord       or function(addr, val) EEex_Write16(addr, val) end
LZ_EEex_WriteDword      = EEex_WriteDword      or function(addr, val) EEex_Write32(addr, val) end
LZ_EEex_WriteQword      = EEex_WriteQword      or function(addr, val) EEex_Write64(addr, val) end

-- ============================================================================
-- 2. 高级对象与指针转换工具函数
-- ============================================================================
LZ_ME_UDToPtr = ME_UDToPtr or function(userdata)
    local ptr = EEex_UDToPtr(userdata)
    return ptr or 0
end

LZ_EEex_GetActorIDSelected = EEex_GetActorIDSelected or function()
    return EEex_Sprite_GetSelectedID()
end

LZ_EEex_GetActorShare = EEex_GetActorShare or function(actorID)
    return LZ_ME_UDToPtr(EEex_GameObject_Get(actorID))
end

-- ============================================================================
-- 3. 对象识别与遍历函数 (内部调用全部改为LZ_ )
-- ============================================================================
LZ_EEex_IsSprite = EEex_IsSprite or function(actorID, allowDead)
    if actorID and actorID ~= 0x0 and actorID ~= -0x1 then
        local share = LZ_EEex_GetActorShare(actorID)
        if share > 0x0 and LZ_EEex_ReadByte(share + 0x8) == 0x31 then
            return allowDead or bit.band(LZ_EEex_ReadDword(share + 0x578), 0xFC0) == 0x0
        end
    end
    return false
end

LZ_EEex_IterateActorEffects = EEex_IterateActorEffects or function(actorID, func)
    if not LZ_EEex_IsSprite(actorID, true) then return end
    local share = LZ_EEex_GetActorShare(actorID)
    
    local esi = LZ_EEex_ReadQword(share + 0x49B8)
    while esi ~= 0x0 do
        local eData = LZ_EEex_ReadQword(esi + 0x10)
        if eData > 0x0 then func(eData) end
        esi = LZ_EEex_ReadQword(esi)
    end
    
    esi = LZ_EEex_ReadQword(share + 0x4A08)
    while esi ~= 0x0 do
        local eData = LZ_EEex_ReadQword(esi + 0x10)
        if eData > 0x0 then func(eData) end
        esi = LZ_EEex_ReadQword(esi)
    end
end
