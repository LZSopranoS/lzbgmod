function LZXPCHAN(slot1,slot2) 
   local sprite1 = EEex_Sprite_GetInPortrait(slot1)           --第二种写法
   local currentxp1 = sprite1.m_baseStats.m_xp                --转职后经验会清0，经验只计算新职业的，非原职业+新职业
   local lzminusxp = math.floor(currentxp1 * 0.1) 
   C:Eval("AddXPObject(Myself,-"..lzminusxp..")", slot1)
   C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", slot1)
   C:Eval("AddXPObject(Myself,"..lzminusxp..")", slot2)
   C:Eval("CreateVisualEffectObject(\"BDSHSUM\",Myself)", slot2)
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