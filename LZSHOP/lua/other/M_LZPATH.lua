--------------------------------------------
-- 补充，以下来自MOD MESpells的M__MEFUN.LUA --
--------------------------------------------
function EEex_ReadByte(address)
	return EEex_ReadU8(address)
end

function EEex_ReadSignedByte(address)
	return EEex_Read8(address)
end

function EEex_ReadWord(address)
	return EEex_ReadU16(address)
end

function EEex_ReadSignedWord(address)
	return EEex_Read16(address)
end

function EEex_ReadDword(address)
	return EEex_Read32(address)
end

function EEex_ReadQword(address)
	return EEex_ReadU64(address)
end

function EEex_ReadSignedQword(address)
	return EEex_Read64(address)
end

function EEex_WriteByte(address, value)
	EEex_Write8(address, value)
end

function EEex_WriteWord(address, value)
	EEex_Write16(address, value)
end

function EEex_WriteDword(address, value)
	EEex_Write32(address, value)
end

function EEex_WriteQword(address, value)
	EEex_Write64(address, value)
end

function ME_UDToPtr(userdata)
	local ptr = EEex_UDToPtr(userdata)
	if ptr then
		return ptr
	else
		return 0
	end
end

function EEex_GetActorIDSelected()
	return EEex_Sprite_GetSelectedID()
end

function EEex_GetActorShare(actorID)
	return ME_UDToPtr(EEex_GameObject_Get(actorID))
end

-- Returns true if the actor is a creature.
-- Returns false if the actor is BALDUR.BCS, an area script, a door, a container, or a region.
-- For example, if you get the sourceID of an effect of a fireball from a trap, and you
-- do EEex_IsSprite(sourceID), it will return false.
-- If the source had been a mage casting a fireball, it would've returned true.
function EEex_IsSprite(actorID, allowDead)
	-- EEex uses 0x0 as an "invalid" actorID return value, but it actually
	-- points to a valid object - (not a sprite, though, so return false).
	if actorID and actorID ~= 0x0 and actorID ~= -0x1 then
		local share = EEex_GetActorShare(actorID)
		if share > 0x0 and EEex_ReadByte(share + 0x8, 0) == 0x31 then
			return allowDead or bit.band(EEex_ReadDword(share + 0x578), 0xFC0) == 0x0
		end
	end
	return false
end

function EEex_IterateActorEffects(actorID, func)
	if not EEex_IsSprite(actorID, true) then return end
	local share = EEex_GetActorShare(actorID)
	local esi = EEex_ReadQword(share + 0x49B8)
	while esi ~= 0x0 do
		local eData = EEex_ReadQword(esi + 0x10)
		if eData > 0x0 then
			func(eData)
		end
		esi = EEex_ReadQword(esi)
	end
	esi = EEex_ReadQword(share + 0x4A08)
	while esi ~= 0x0 do
		local eData = EEex_ReadQword(esi + 0x10)
		if eData > 0x0 then
			func(eData)
		end
		esi = EEex_ReadQword(esi)
	end
end