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

me_multiclass_classes = {
[7] = {2, 1},
[8] = {2, 3},
[9] = {2, 4},
[10] = {2, 1, 4},
[13] = {1, 4},
[14] = {3, 1},
[15] = {3, 4},
[16] = {2, 11},
[17] = {2, 1, 3},
[18] = {3, 12}
}
me_multiclass_dual = {
[7] = {8, 16},
[8] = {8, 32},
[9] = {8, 64},
[10] = {8, 16, 64},
[13] = {16, 64},
[14] = {32, 16},
[15] = {32, 64},
[16] = {8, 128},
[17] = {8, 16, 32},
[18] = {32, 256}
}

function ME_IsDualClassed(actorID)
	return (bit.band(EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568), 504) > 0)
end

function ME_IsMultiClassed(actorID)
	local me_class = EEex_GetActorClass(actorID)
	return (((me_class >= 7 and me_class <= 9) or (me_class >= 13 and me_class <= 16) or (me_class == 18)) and (bit.band(EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568), 504) == 0))
end

function METEST(effectData, creatureData)
	local targetID = EEex_ReadDword(creatureData + 0x34)
	Infinity_DisplayString("Stat 633: " .. EEex_GetActorStat(targetID, 633) .. "; Stat 634: " .. EEex_GetActorStat(targetID, 634))
	Infinity_DisplayString("New iteration...")
	EEex_ApplyEffectToActor(targetID, {
["opcode"] = 402,
["target"] = 2,
["timing"] = 3,
["resource"] = "METEST",
["source_target"] = targetID,
["source_id"] = targetID
})
end

function METEST(effectData, creatureData)
	local targetID = EEex_ReadDword(creatureData + 0x34)
	EEex_WriteDword(effectData + 0x110, 0x1)
-- An effect I use to set the creature's acceleration
	EEex_ApplyEffectToActor(targetID, {
["opcode"] = 401,
["target"] = 2,
["timing"] = 9,
["parameter1"] = 3,
["parameter2"] = 1,
["special"] = 643,
["parent_resource"] = "METEST",
["source_target"] = targetID,
["source_id"] = sourceID
})
-- This effect calls the looping function
	EEex_ApplyEffectToActor(targetID, {
["opcode"] = 402,
["target"] = 2,
["timing"] = 3,
["resource"] = "MEHGTMOD",
["parent_resource"] = "METEST",
["source_target"] = targetID,
["source_id"] = targetID
})
end

function METEST(effectData, creatureData)

    local targetID = EEex_ReadDword(creatureData + 0x34)
    EEex_WriteDword(effectData + 0x110, 0x1)

    local currentTick = EEex_GetGameTick()
    local targetTick = currentTick + 1

    Infinity_DisplayString("Tick: "..currentTick)

    EEex_ApplyEffectToActor(targetID, {
        ["opcode"] = 402,
        ["target"] = 2,
        ["timing"] = 6,
        ["duration"] = targetTick,
        ["resource"] = "METEST",
        ["parent_resource"] = "METEST",
        ["source_target"] = targetID,
        ["source_id"] = targetID
    })

end


EEex_Resource.lua

function LZDualClassButtonChange(config, state)
   local sprite = EEex_GameObject_Get(B3EffectMenu_Private_CurrentActorID)
   if state == 15 then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.THIEVING)
   end
   if state == 5 then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.FIND_TRAPS)
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.THIEVING)
   end
   if state == 12 or state == 18 then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.FIND_TRAPS)
   end
   if state == 20 then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.FIND_TRAPS)
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.THIEVING)
   end
   function MoBarbarianThievingActionbarListener(config, state)
   if 
      state == 2 
      and EEex_GameObject_GetSelected():getActiveStats().m_nKit == 0x40000000
      then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.FIND_TRAPS)
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.STEALTH)
   end
   function MoWizSlayerThievingActionbarListener(config, state)
   if 
      EEex_GameObject_GetSelected():getActiveStats().m_nKit == 0x4002 then
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.FIND_TRAPS)
   end
end
function MoWizSlayerThievingActionbarListener(config, state)
   if 
      (state == 2 or state == 8 or state == 16)
      and EEex_GameObject_GetSelected():getActiveStats().m_nKit == 0x4002
      then
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.FIND_TRAPS)
   end
   function MoInquisitorThievingActionbarListener(config, state)
   if 
      state == 6 
      and EEex_GameObject_GetSelected():getActiveStats().m_nKit == 0x4005
      then
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.FIND_TRAPS)
   end
   function MoClericMageThiefActionbarListener(config, state)
   if 
      state == 6 
      and EEex_GameObject_GetSelected():getActiveStats().m_nKit == 0x4005
      then
      EEex_Actionbar_SetButton(3, EEex_Actionbar_ButtonType.FIND_TRAPS)
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.THIEVING)
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.STEALTH)
   end
   function MoRemoveTurnUndeadPaladinActionbarListener(config, state)
   if  
      state == 6 
      and EEex_GameObject_GetSelected():getActiveStats().m_nKit ~= 0x4005
      then
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.QUICK_SPELL_1)
   end
   function MoRemoveTurnUndeadPaladinActionbarListener(config, state)
   if  
      state == 6 
      then
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.QUICK_SPELL_1)
   end
   function MoRemoveTurnUndeadClericActionbarListener(config, state)
   if state == 3 or state == 8 or state == 14 or state == 17 then
      EEex_Actionbar_SetButton(3, EEex_Actionbar_ButtonType.QUICK_SPELL_3)
   end
   function MoRemoveTurnUndeadActionbarListener(config, state)
   if 
      state == 3 or 
      state == 6 or 
      state == 8 or 
      state == 14 or 
      state == 15 or 
      state == 17 or
      state == 18
      and not EEex_GameObject_GetSelected():getActiveStats().m_nKit == 0x4005
      then
      EEex_Actionbar_SetButton(5, EEex_Actionbar_ButtonType.QUICK_SPELL_1)
   end
end
EEex_Actionbar_AddListener(LZDualClassButtonChange)

function MeIsDualClassed(actorID)
	return (bit.band(EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568), 504) > 0)
end

function LZDualClassButtonChange(config, state)
   local meisdual = MeIsDualClassed(actorID)
   local meisdual = EEex_Flags
   local meisdual = EEex_GameObject_GetSelected():getActiveStats().m_nFlags == 6
   local sprite = EEex_GameObject_Get(B3EffectMenu_Private_CurrentActorID)
   if state == 15 then
      EEex_Actionbar_SetButton(4, EEex_Actionbar_ButtonType.THIEVING)
   end
end
EEex_Actionbar_AddListener(LZDualClassButtonChange)
