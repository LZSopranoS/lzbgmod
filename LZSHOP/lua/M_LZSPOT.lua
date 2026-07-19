function LZTSKIL1(add_value)
   local add_value = add_value or 5                                            -- 如果没填参数，默认加 5，填了就加输入值
   --local sprite = EEex_Sprite_GetSelected()
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   C:Eval("ChangeStat(Myself,TRAPS," .. add_value .. ",ADD)", slot)            --陷阱，对应cre里的find traps数值，默认为0，加5就变为5                 
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
end

function LZTSKIL2(add_value)
   local add_value = add_value or 5
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   C:Eval("ChangeStat(Myself,LOCKPICKING," .. add_value .. ",ADD)", slot)      --开锁，对应cre里的open locks数值，默认为0，加5就变为5
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
end

function LZTSKIL3(add_value)
   local add_value = add_value or 5
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   C:Eval("ChangeStat(Myself,PICKPOCKET," .. add_value .. ",ADD)", slot)        --扒窃，对应cre里的pick pockets数值，默认为0，加5就变为5
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
end

function LZTSKIL4(add_value)
   local add_value = add_value or 5
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   C:Eval("ChangeStat(Myself,STEALTH," .. add_value .. ",ADD)", slot)           --潜行，对应cre里的move silently数值，默认为0，加5就变为5
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
end

function LZTSKIL5(add_value)
   local add_value = add_value or 5
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   local spriteID = EEex_Sprite_GetInPortraitID(slot)     
   local creatureData = LZ_EEex_GetActorShare(spriteID)
   local hideinshadows = LZ_EEex_ReadByte(creatureData + 0x59D)                    --根据cre里name的文件偏移是0x8、内存偏移是0x560，计算出内存偏移 = 文件偏移 + 0x558
   local naturalac = LZ_EEex_ReadByte(creatureData + 0x59E)
   local newhideinshadows = (hideinshadows + add_value) % 256                   --限制在0~255，防止溢出回绕，如果数值超过255，只保留余数，不影响相邻的Byte
   local newvalue = newhideinshadows + (naturalac * 256)                        --使下面的WriteWord只修改1个Byte
   LZ_EEex_WriteWord(creatureData + 0x59D,newvalue)
   --LZ_EEex_WriteByte(creatureData + 0x59D,hideinshadows + add_value)             --无符号Byte范围0~255、有符号Byte范围-128~+127，用WriteByte最多加到127点，改用WriteWord能加到最大255，再往上加会从0开始，游戏内加点范围0~255
   --C:Eval("ChangeStat(Myself,HIDEINSHADOWS,5,ADD)", slot)                     --stats.ids里的hideinshadows无效
   --C:Eval("ChangeStat(Myself,HIDEINSHADOWSMTPBONUS,5,ADD)", slot)
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
   C:Eval("SaveGame(0)")                                                        --激活修改显示
end

function LZTSKIL6(add_value)
   local add_value = add_value or 5
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   local spriteID = EEex_Sprite_GetInPortraitID(slot)     
   local creatureData = LZ_EEex_GetActorShare(spriteID)
   local detectillusion = LZ_EEex_ReadByte(creatureData + 0x5BC)                    --根据cre里name的文件偏移是0x8、内存偏移是0x560，计算出内存偏移 = 文件偏移 + 0x558
   local settraps = LZ_EEex_ReadByte(creatureData + 0x5BD)
   local newdetectillusion = (detectillusion + add_value) % 256
   local newvalue = newdetectillusion + (settraps * 256)
   LZ_EEex_WriteWord(creatureData + 0x5BC,newvalue)
   --LZ_EEex_WriteByte(creatureData + 0x5BC,detectillusion + add_value)             --无符号Byte范围0~255、有符号Byte范围-128~+127，用WriteByte最多加到127点，改用WriteWord
   --C:Eval("ChangeStat(Myself,DETECTILLUSIONS,5,ADD)", slot)                    --stats.ids里的detectillusions无效
   --C:Eval("ChangeStat(Myself,DETECTILLUSIONSMTPBONUS,5,ADD)", slot)
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
   C:Eval("SaveGame(0)")
end

function LZCSKILL(add_value)
   local add_value = add_value or 5
   local slot = EEex_Sprite_GetSelected():getPortraitIndex()
   C:Eval("ChangeStat(Myself,TURNUNDEADLEVEL," .. add_value .. ",ADD)", slot)     --有效，对应cre里的turn undead level数值，默认为0，加5就变为5，牧师之类这栏也是0和面板显示超度不死生物等级不同且不影响面板等级
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
end

function LZFSKILL()
   local sprite = EEex_Sprite_GetSelected()
   local slot = sprite:getPortraitIndex()
   local charxp = sprite.m_baseStats.m_xp
   if charxp > 100000 then
   C:Eval("AddXPObject(Myself,-100000)", slot)
   C:Eval("AddSpecialAbility(\"SPDWD02\")", slot)
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
   end
end

function LZPSKILL()
   local sprite = EEex_Sprite_GetSelected()
   local slot = sprite:getPortraitIndex()
   local charxp = sprite.m_baseStats.m_xp
   if charxp > 100000 then
   C:Eval("AddXPObject(Myself,-100000)", slot)
   C:Eval("AddSpecialAbility(\"SPCL231\")", slot)
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
   end
end

function LZSDSKIL()
   local sprite = EEex_Sprite_GetSelected()
   local slot = sprite:getPortraitIndex()
   local charxp = sprite.m_baseStats.m_xp
   if charxp > 100000 then
   C:Eval("AddXPObject(Myself,-100000)", slot)
   C:Eval("AddSpecialAbility(\"SPSD02\")", slot)
   C:Eval("CreateVisualEffectObject(\"ASUMM1X\",Myself)", slot)
   end
end