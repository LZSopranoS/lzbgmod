// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : D:\Baldur's Gate II - Enhanced Edition
// resource : BDPGOOD.DLG
// source   : Override\BDPGOOD.DLG
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~BDPGOOD~

IF ~InParty("BDCAELAR")
InMyArea("BDCAELAR")
!Alignment(Player1,MASK_EVIL)
PartyHasItem("XARING22")~ THEN BEGIN 0 // from:
  SAY @319 /* ~<CHARNAME>恭喜你击败了强大的三体恶魔，解救了凯拉·白银和那些在阿弗纳斯与恶魔战斗英勇牺牲的战士灵魂。你身上的征服之戒，和凯拉的武器、盔甲都曾属于某位天使，如果你愿意，我可以用征服之戒进一步强化凯拉的武器和盔甲，怎么样？~ */
  IF ~PartyHasItem("BDHELMCA")
PartyHasItem("BDSHLDCA")
PartyHasItem("BDSW1HCA")~ THEN REPLY @320 /* ~好，帮我强化吧。~ */ DO ~TakePartyItem ("XARING22")
DestroyItem("XARING22") 
TakePartyItem ("BDSHLDCA") 
DestroyItem("BDSHLDCA")
TakePartyItem ("BDSW1HCA") 
DestroyItem("BDSW1HCA")
ReallyForceSpell(Myself,CLERIC_RIGHTEOUS_MAGIC)
Wait(3)
GiveItemCreate("BDSHLD2",Player1,1,1,1)
GiveItemCreate("BDSW1H2",Player1,1,1,1)
TakeItemReplace("BDHELM2","BDHELMCA","BDCAELAR")
DestroySelf()~ EXIT
  IF ~~ THEN REPLY @321 /* ~算了，戒指我想留着。~ */ DO ~DestroySelf()~ EXIT
END
