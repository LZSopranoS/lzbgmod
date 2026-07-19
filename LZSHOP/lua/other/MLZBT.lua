function SETBTOCH() --Set Button To Character
   
   --function EEex_Sprite_GetPortraitIndex(sprite)
   --local sprite = EEex_Sprite_GetInPortrait(portraitIndex)
   --local spriteID = EEex_Sprite_GetInPortraitID(portraitNum)
   --local sprite = EEex_GameObject_Get(spriteID)
   --local player1ID = EEex_GetActorIDPortrait(0)
   --local player2ID = EEex_GetActorIDPortrait(1)
   --local player3ID = EEex_GetActorIDPortrait(2)
   --local player4ID = EEex_GetActorIDPortrait(3)
   --local player5ID = EEex_GetActorIDPortrait(4)
   --local player6ID = EEex_GetActorIDPortrait(5)

   local sprite = EEex_Sprite_GetSelected()
   local actorID = EEex_GetActorIDSelected(sprite)

   local FTBUTTON = EEex_Sprite_GetSpellState(sprite, 119)
   local SBUTTON = EEex_Sprite_GetSpellState(sprite, 127)
   local TBUTTON = EEex_Sprite_GetSpellState(sprite, 128)
   local BSBUTTON = EEex_Sprite_GetSpellState(sprite, 129)
   local CSBUTTON = EEex_Sprite_GetSpellState(sprite, 130)
   local GBUTTON = EEex_Sprite_GetSpellState(sprite, 131)
   local TUBUTTON = EEex_Sprite_GetSpellState(sprite, 132)
   EEex_DS(FTBUTTON)
   EEex_DS(SBUTTON)
   EEex_DS(TBUTTON)
   EEex_DS(BSBUTTON)
   EEex_DS(CSBUTTON)
   EEex_DS(GBUTTON)
   EEex_DS(TUBUTTON)
   --选中的sprite在队伍里且操作栏符合条件
    if EEex_Sprite_GetSpellState(sprite, 119) and buttonArray:GetButtonType(3) ~= 4 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(3, 4)        --4对应寻找陷阱/侦测幻象按钮，3对应操作栏4号槽位、快捷键F4
    end
    if EEex_Sprite_GetSpellState(sprite, 127) and buttonArray:GetButtonType(5) ~= 11 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(5, 11)       --11对应潜行按钮，5对应操作栏6号槽位、快捷键F6
    end
    if EEex_Sprite_GetSpellState(sprite, 128) and buttonArray:GetButtonType(4) ~= 12 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(4, 12)       --12对应开锁/扒窃按钮，4对应操作栏5号槽位、快捷键F5
    end
	if EEex_Sprite_GetSpellState(sprite, 129) and buttonArray:GetButtonType(3) ~= 2 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
       if buttonArray:GetButtonType(6) == 100 then
		EEex_Actionbar_SetButton(6, 2)        --2对应战歌按钮，6对应操作栏7号槽位、快捷键F7，优先级7号槽位＞6号＞4号，根据不同职业出现在不同槽位
	   elseif buttonArray:GetButtonType(5) == 11 or buttonArray:GetButtonType(5) == 26 then
	    EEex_Actionbar_SetButton(5, 2)
	   else
	    EEex_Actionbar_SetButton(3, 2)
	   end
    end
    --if EEex_Sprite_GetSpellState(sprite, 130) and buttonArray:GetButtonType(6) ~= 3 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		--EEex_Actionbar_SetButton(6, 3)        --3对应施法按钮，6对应操作栏7号槽位、快捷键F7
    --end
    if EEex_Sprite_GetSpellState(sprite, 131) and buttonArray:GetButtonType(5) ~= 7 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
		EEex_Actionbar_SetButton(5, 7)        --7对应防御按钮，5对应操作栏6号槽位、快捷键F6
    end
    if EEex_Sprite_GetSpellState(sprite, 132) and buttonArray:GetButtonType(3) ~= 13 and buttonArray:GetButtonType(7) == 14 and buttonArray:GetButtonType(11) == 10 then
       if buttonArray:GetButtonType(6) == 100 then
		EEex_Actionbar_SetButton(6, 13)       --13对应超度不死生物按钮，6对应操作栏7号槽位、快捷键F7，优先级7号槽位＞6号＞4号，根据不同职业出现在不同槽位
	   elseif buttonArray:GetButtonType(5) == 11 or buttonArray:GetButtonType(5) == 26 then
	    EEex_Actionbar_SetButton(5, 13)
	   else
		EEex_Actionbar_SetButton(3, 13)
	   end
    end
end
EEex_Actionbar_AddListener(SETBTOCH)
--EEex_Actionbar_AddButtonsUpdatedListener(SETBTOCH)--快捷栏按钮刷新完运行,按钮更新监听器