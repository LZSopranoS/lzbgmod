-- 全局快速武器槽切换变量（默认为 false，即关闭状态）
LZ_QWeaponSlotToggle = LZ_QWeaponSlotToggle or false

EEex_Key_AddPressedListener(function(key)
    -- 按下F时为真，再按一次为假
    if key == EEex_Key_GetFromName("F") then
        -- 【核心切换逻辑】：把当前状态取反（true 变 false，false 变 true）
        LZ_QWeaponSlotToggle = not LZ_QWeaponSlotToggle
    end
end)

function SETBTOCH() --Set Button To Character
   local sprite = EEex_Sprite_GetSelected()
    if not sprite then return end
	--if not EEex_GameObject_IsSprite(sprite) then return end
    if EEex_Sprite_GetSpellState(sprite, LZQWBUTTON3) and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
	   if LZ_QWeaponSlotToggle and buttonArray:GetButtonType(1) == 27 and buttonArray:GetButtonType(2) == 28 and buttonArray:GetButtonType(3) == 29 and buttonArray:GetButtonType(4) ~= 30 then
	    EEex_Actionbar_SetButton(3, 30)    --操作栏只有3武器槽（圣武士/游侠/武僧），按下F，装备界面武器槽4替换操作栏武器槽3
       elseif not LZ_QWeaponSlotToggle and buttonArray:GetButtonType(1) == 27 and buttonArray:GetButtonType(2) == 28 and buttonArray:GetButtonType(3) == 30 then
	    EEex_Actionbar_SetButton(3, 29)    --操作栏只有3武器槽，再按下F，恢复
	   end
    end
    if EEex_Sprite_GetSpellState(sprite, LZQWBUTTON2) and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
	   if LZ_QWeaponSlotToggle and buttonArray:GetButtonType(1) == 27 and buttonArray:GetButtonType(2) == 28 and buttonArray:GetButtonType(3) ~= 29 and buttonArray:GetButtonType(4) ~= 30 then
		EEex_Actionbar_SetButton(1, 29)    --操作栏只有2武器槽，按下F，装备界面武器槽3替换操作栏武器槽1，武器槽4替换操作栏武器槽2
		EEex_Actionbar_SetButton(2, 30)
       elseif not LZ_QWeaponSlotToggle and buttonArray:GetButtonType(1) == 29 and buttonArray:GetButtonType(2) == 30 then
		EEex_Actionbar_SetButton(1, 27)    --操作栏只有2武器槽，再按下F，恢复
		EEex_Actionbar_SetButton(2, 28)
	   end
    end
	if EEex_Sprite_GetSpellState(sprite, LZQWBUTTON1) and buttonArray:GetButtonType(3) ~= 29 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
	    EEex_Actionbar_SetButton(3, 29)    --模式1，直接在4号槽位加一个快捷武器槽
    end
    if EEex_Sprite_GetSpellState(sprite, LZFTBUTTON119) and buttonArray:GetButtonType(3) ~= 4 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(3, 4)        --4对应寻找陷阱/侦测幻象按钮，3对应操作栏4号槽位、快捷键F4
    end
    if EEex_Sprite_GetSpellState(sprite, LZSBUTTON127) and buttonArray:GetButtonType(5) ~= 11 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(5, 11)       --11对应潜行按钮，5对应操作栏6号槽位、快捷键F6
    end
    if EEex_Sprite_GetSpellState(sprite, LZTBUTTON128) and buttonArray:GetButtonType(4) ~= 12 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(4, 12)       --12对应开锁/扒窃按钮，4对应操作栏5号槽位、快捷键F5
    end
	if EEex_Sprite_GetSpellState(sprite, LZBSBUTTON129) and buttonArray:GetButtonType(3) ~= 2 and buttonArray:GetButtonType(5) ~= 2 and buttonArray:GetButtonType(6) ~= 2 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
       if buttonArray:GetButtonType(6) == 100 then
		EEex_Actionbar_SetButton(6, 2)        --2对应战歌按钮，6对应操作栏7号槽位、快捷键F7，优先级7号槽位＞6号＞4号，根据不同职业出现在不同槽位
	   elseif buttonArray:GetButtonType(5) == 11 or buttonArray:GetButtonType(5) == 26 then
	    EEex_Actionbar_SetButton(5, 2)
	   else
	    EEex_Actionbar_SetButton(3, 2)
	   end
    end
    --if EEex_Sprite_GetSpellState(sprite, LZCSBUTTON130) and buttonArray:GetButtonType(6) ~= 3 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		--EEex_Actionbar_SetButton(6, 3)        --3对应施法按钮，6对应操作栏7号槽位、快捷键F7
    --end
    if EEex_Sprite_GetSpellState(sprite, LZGBUTTON131) and buttonArray:GetButtonType(5) ~= 7 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(5, 7)        --7对应防御按钮，5对应操作栏6号槽位、快捷键F6
    end
    if EEex_Sprite_GetSpellState(sprite, LZTUBUTTON132) and buttonArray:GetButtonType(3) ~= 13 and buttonArray:GetButtonType(4) ~= 13 and buttonArray:GetButtonType(5) ~= 13 and buttonArray:GetButtonType(6) ~= 13 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
       if buttonArray:GetButtonType(6) == 100 then
		EEex_Actionbar_SetButton(6, 13)       --13对应超度不死生物按钮，6对应操作栏7号槽位、快捷键F7，优先级7号槽位＞6号＞4号，根据不同职业出现在不同槽位
	   --elseif buttonArray:GetButtonType(5) == 11 or buttonArray:GetButtonType(5) == 26 then
	    --EEex_Actionbar_SetButton(5, 13)
	   else
		EEex_Actionbar_SetButton(3, 13)
	   end
    end
end
--EEex_Actionbar_AddListener(SETBTOCH)
EEex_Actionbar_AddButtonsUpdatedListener(SETBTOCH)    --类似EEex_Actionbar_AddListener，只不过第一次更新按钮就能刷新，前者需要切换一次操作栏才刷新。用在QW BUTTON上每次按键切换都能及时刷新，前者按键后需要手动切换操作栏才刷新，缺点是战歌、超度亡灵按钮代码需要加更多限制，否则会多次触发。
--[[
超度不死生物按钮源代码类似战歌按钮，测试发现和施法按钮一样受职业限制，只有牧师/圣武士能用，牧师转职或审判者可以用到。
加入buttonArray:GetButtonType(5) ~= 13保证审判者新TU按钮不激活，
加入buttonArray:GetButtonType(4) ~= 13保证牧师转盗贼转职结束后新TU按钮不再激活，
buttonArray:GetButtonType(6) == 100把牧师转盗贼/战士转职期间新TU按钮放到新位置，转职结束不再激活，
最后牧师转法师/游侠转职期间新TU按钮都和转职前位置相同，转职结束后不再激活。
]]