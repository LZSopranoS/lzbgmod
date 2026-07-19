--[[
lzminusxp = nil
function LZXPCHAN(slot1,slot2) 

   if slot1 ~= nil and lzminusxp == nil  then
   --local spriteID = EEex_Sprite_GetInPortraitID(slot1)     --第一种写法，portraitIndex = slot1，两次传入要保证队员是活的dlg里inparty()
   --local creatureData = EEex_GetActorShare(spriteID) 
   --local currentxp = EEex_ReadDword(creatureData + 0x570)  --根据cre里name的文件偏移是0x8、内存偏移是0x560，计算出内存偏移 = 文件偏移 + 0x558，XP/Power level的文件偏移是0x18
   local sprite = EEex_Sprite_GetInPortrait(slot1)           --第二种写法
   local currentxp = sprite.m_baseStats.m_xp 
         lzminusxp = math.floor(currentxp * 0.1)
   --local newxp = currentxp - lzminusxp 
   --EEex_WriteDword(creatureData + 0x570,newxp)              --第一种写法
       --sprite.m_baseStats.m_xp = newxp                      --第二种写法
	   
         C:Eval("AddXPObject(Myself,-"..lzminusxp..")", slot1)

   EEex_DS(currentxp)
   EEex_DS(lzminusxp)
   EEex_DS(newxp)

   EEex_DS(EEex_ReadDword(creatureData + 0x570))
   --doRefresh = true
   --e:GetActiveEngine()
   --sprite:virtual_RecalculateStats(true)
   --EEex_RefreshPortraitUI(sprite.m_id)
   --EEex_PlayerParty_UpdateMember(sprite.m_id)
   --ToggleAI()
   --e:GetActiveEngine():SelectAll()
   --GetActiveEngine()
   
   end
   
   if slot2 ~= nil and lzminusxp ~= nil then   
   --local spriteID = EEex_Sprite_GetInPortraitID(slot2)      --portraitIndex = slot2
   --local creatureData = EEex_GetActorShare(spriteID)
   --local currentxp = EEex_ReadDword(creatureData + 0x570)
   local sprite = EEex_Sprite_GetInPortrait(slot2)
   local currentxp = sprite.m_baseStats.m_xp 
   local newxp = currentxp + lzminusxp
   --EEex_WriteDword(creatureData + 0x570,newxp)
       --sprite.m_baseStats.m_xp = newxp
	   C:Eval("AddXPObject(Myself,"..lzminusxp..")", slot2)
   lzminusxp = nil
   end
end
]]

function LZXPCHAN(slot1,slot2) 
   --local spriteID = EEex_Sprite_GetInPortraitID(slot1)      --第一种写法，portraitIndex = slot1，两次传入要保证队员是活的dlg里inparty()
   --local creatureData = EEex_GetActorShare(spriteID) 
   --local currentxp = EEex_ReadDword(creatureData + 0x570)   --根据cre里name的文件偏移是0x8、内存偏移是0x560，计算出内存偏移 = 文件偏移 + 0x558，XP/Power level的文件偏移是0x18
   local sprite1 = EEex_Sprite_GetInPortrait(slot1)           --第二种写法
   local currentxp1 = sprite1.m_baseStats.m_xp                --转职后经验会清0，经验只计算新职业的，非原职业+新职业
   local lzminusxp = math.floor(currentxp1 * 0.1)
   --local newxp = currentxp - lzminusxp 
   --EEex_WriteDword(creatureData + 0x570,newxp)              --第一种写法
       --sprite1.m_baseStats.m_xp = currentxp1 - lzminusxp    --第二种写法
 
   --local spriteID = EEex_Sprite_GetInPortraitID(slot2)      --portraitIndex = slot2
   --local creatureData = EEex_GetActorShare(spriteID)
   --local currentxp = EEex_ReadDword(creatureData + 0x570)
   --local sprite2 = EEex_Sprite_GetInPortrait(slot2)
   --local currentxp2 = sprite2.m_baseStats.m_xp 
   --local newxp = currentxp + lzminusxp
   --EEex_WriteDword(creatureData + 0x570,newxp)
       --sprite2.m_baseStats.m_xp = currentxp2 + lzminusxp
		 
		 C:Eval("AddXPObject(Myself,-"..lzminusxp..")", slot1)
         C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", slot1)
		 --Infinity_DisplayString(EEex_Sprite_GetName(sprite1) .. " 经验值 -" .. lzminusxp)
	     C:Eval("AddXPObject(Myself,"..lzminusxp..")", slot2)
		 C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", slot2)
		 --Infinity_DisplayString(EEex_Sprite_GetName(sprite2) .. " 经验值 +" .. lzminusxp)
		 --C:Eval("SaveGame(0)")                                --激活更新，否则得用AddXPObject
end

function LZXPCOP1(slot) 
   return EEex_Sprite_GetInPortrait(slot).m_baseStats.m_xp > EEex_Sprite_GetInPortrait(0).m_baseStats.m_xp
end

function LZXPCOP2(slot) 
   return EEex_Sprite_GetInPortrait(slot).m_baseStats.m_xp > EEex_Sprite_GetInPortrait(1).m_baseStats.m_xp
end

function LZXPCOP3(slot) 
   return EEex_Sprite_GetInPortrait(slot).m_baseStats.m_xp > EEex_Sprite_GetInPortrait(2).m_baseStats.m_xp
end

function LZXPCOP4(slot) 
   return EEex_Sprite_GetInPortrait(slot).m_baseStats.m_xp > EEex_Sprite_GetInPortrait(3).m_baseStats.m_xp
end

function LZXPCOP5(slot) 
   return EEex_Sprite_GetInPortrait(slot).m_baseStats.m_xp > EEex_Sprite_GetInPortrait(4).m_baseStats.m_xp
end

function LZXPCOP6(slot) 
   return EEex_Sprite_GetInPortrait(slot).m_baseStats.m_xp > EEex_Sprite_GetInPortrait(5).m_baseStats.m_xp
end

--[[
local pos = sprite.m_pos
local sourceType = effect.m_sourceType
local sourceResref = effect.m_sourceRes:get()
local m_durationType = effect.m_durationType
  if m_durationType == 9 then return end
local casterLevel = effect.m_casterLevel
local memberList = game.m_group.m_memberList
  if memberList.m_nCount == 1 and memberList.m_pNodeHead.data == spriteID then
	 game:OnPortraitLDblClick(portraitNum)
	 doSelect = false
  end
if sprite:getActiveStats().m_bSeeInvisible ~= 0 then
local lastActionReturnCopy = pGameAIBase.m_nLastActionReturn
local targetIdCopy = isSprite and pGameAIBase.m_targetId
local action = sprite.m_curAction
local actionID = aiBase.m_curAction.m_actionID
[0] = aiBase.m_overrideScript
print(string.format("%s  m_EnemyAlly: %d", indent, aiType.m_EnemyAlly)) --AI 类型 → 敌人 / 盟友 识别
function EEex_Sprite_ForAllOfTypeInRange
function EEex_Sprite_ForAllOfTypeStringInRange
local spriteID = sprite.m_id
function EEex_Sprite_GetName
function EEex_Sprite_GetPersonalSpace(sprite)
  local animation = sprite.m_animation
function EEex_Sprite_DisplayTextRef(sprite, text, optionalArgs)
targetSprite.m_baseStats.m_hitPoints


]]

--[[
function LZXPCHAN(slot1,slot2)
   local SO = EEex_Sprite_GetSelected() -- 选择的角色
   --local SOClass = EEex_GameObject_GetClass(SO) -- 转职后的职业
   local actorID = EEex_GetActorIDSelected(SO)  --等价于原EEex_Sprite_GetSelectedID()
   --local name = EEex_ReadDword(creatureData + 0x560)
   --local actor = EEex_ReadDword(EEex_GetActorShare(actorID) + 0x568)
   --local DCCheck = ME_IsDualClassed(actorID) -- 判断转职
   --local Flag = EEex_GetActorShare(actorID)

   --local creatureData = EEex_GetActorShare(actorID)
   --local OC = EEex_ReadByte(creatureData + 0x568) --Original class
   --local animationData = EEex_ReadDword(EEex_GetActorShare(actorID) + 0x580)
   --local partyMember = EEex_Sprite_GetInPortrait(i)
   --local sprite1 = EEex_Sprite_GetInPortrait(i)
   --local sprite2 = EEex_Sprite_GetInPortrait(i)
   --local actorID = EEex_Sprite_GetSelectedID(sprite)
   
   if slot1 ~= nil then
   
   local portraitIndex = slot1
   local spriteID = EEex_Sprite_GetInPortraitID(portraitIndex)
   local creatureData = EEex_GetActorShare(spriteID) 
   local currentxp = EEex_ReadDword(creatureData + 0x570)  --根据cre里name的文件偏移是0x8、内存偏移是0x560，计算出内存偏移 = 文件偏移 + 0x558，XP/Power level的文件偏移是0x18
   local lzminusxp = math.floor(currentxp * 0.1)
   local newxp = currentxp - minusxp
   EEex_WriteDword(creatureData + 0x570,newxp)
   
   end
   
   if slot2 ~= nil then
   
   local portraitIndex = slot2
   local spriteID = EEex_Sprite_GetInPortraitID(portraitIndex)
   local creatureData = EEex_GetActorShare(spriteID)
   local currentxp = EEex_ReadDword(creatureData + 0x570)
   local newxp = currentxp + minusxp
   EEex_WriteDword(creatureData + 0x570,newxp)
   
   
   Infinity_DisplayString(actorID)
   EEex_DS(creatureData)
   EEex_DS(currentxp1)
   EEex_DS(currentxp2)
   
   
   end
end
]]