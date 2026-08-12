-- 输入0代表Player1、1代表Player2，和输入0代表队伍头像1不同
function LZ_GetSpriteByPlayerNum(playerNum)
	local charactersArray = EngineGlobals.g_pBaldurChitin.m_pObjectGame.m_characters
	local spriteID = charactersArray:get(playerNum)
	if not spriteID or spriteID == 0 or spriteID == -1 then return end
	-- 通过 spriteID 获取 sprite 对象
	return EEex_GameObject_Get(spriteID)
end

-- EEex_Sprite_GetInPortrait()改为LZ_GetSpriteByPlayerNum()
function LZXPCHAN(playerNum1,playerNum2) 
   local sprite1 = LZ_GetSpriteByPlayerNum(playerNum1)           --第二种写法
   local currentxp1 = sprite1.m_baseStats.m_xp                   --转职后经验会清0，经验只计算新职业的，非原职业+新职业
   local lzminusxp = math.floor(currentxp1 * 0.1)
   local sprite2 = LZ_GetSpriteByPlayerNum(playerNum2)
   --local portraitNum1 = EEex_Sprite_GetPortraitIndex(sprite1)
   --local portraitNum2 = EEex_Sprite_GetPortraitIndex(sprite2)
   local portraitNum1 = sprite1:getPortraitIndex()
   local portraitNum2 = sprite2:getPortraitIndex()
   C:Eval("AddXPObject(Myself,-"..lzminusxp..")", portraitNum1)
   C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", portraitNum1)
   C:Eval("AddXPObject(Myself,"..lzminusxp..")", portraitNum2)
   C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", portraitNum2)
end

-- EEex_Sprite_GetInPortrait()改为LZ_GetSpriteByPlayerNum()
function LZXPCOP1(playerNum) 
   return LZ_GetSpriteByPlayerNum(playerNum).m_baseStats.m_xp > LZ_GetSpriteByPlayerNum(0).m_baseStats.m_xp
end

function LZXPCOP2(playerNum) 
   return LZ_GetSpriteByPlayerNum(playerNum).m_baseStats.m_xp > LZ_GetSpriteByPlayerNum(1).m_baseStats.m_xp
end

function LZXPCOP3(playerNum) 
   return LZ_GetSpriteByPlayerNum(playerNum).m_baseStats.m_xp > LZ_GetSpriteByPlayerNum(2).m_baseStats.m_xp
end

function LZXPCOP4(playerNum) 
   return LZ_GetSpriteByPlayerNum(playerNum).m_baseStats.m_xp > LZ_GetSpriteByPlayerNum(3).m_baseStats.m_xp
end

function LZXPCOP5(playerNum) 
   return LZ_GetSpriteByPlayerNum(playerNum).m_baseStats.m_xp > LZ_GetSpriteByPlayerNum(4).m_baseStats.m_xp
end

function LZXPCOP6(playerNum) 
   return LZ_GetSpriteByPlayerNum(playerNum).m_baseStats.m_xp > LZ_GetSpriteByPlayerNum(5).m_baseStats.m_xp
end

--XPGT(LastSummonerOf(Myself),50000)判断遇到转职有问题，转职后判断是原职业+新职业经验之和，原职业经验满足条件转职后用卷轴学特殊能力扣经验会使新职业经验变负，故改成用EEex判断。
function LZXPABOVE1() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 50000
end

function LZXPABOVE2() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 100000
end

function LZXPABOVE3() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 150000
end

function LZXPABOVE4() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 200000
end

function LZXPABOVE5() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 70000
end

function LZXPABOVE6() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 1000000
end

function LZXPABOVE7() 
   return EEex_Sprite_GetSelected().m_baseStats.m_xp > 2000000
end