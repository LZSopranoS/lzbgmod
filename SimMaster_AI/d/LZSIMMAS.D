// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : D:\BGT\Baldur's Gate Enhanced Edition Tetralogy
// resource : LZSIMMAS.dlg
// source   : Override\LZSIMMAS.dlg
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~LZSIMMAS~

IF ~True()~ THEN BEGIN 0 // from:
  SAY @510 /* ~哎呀呀，<CHARNAME>，大名鼎鼎的冒险者，终于见面了。这一路走来真是辛苦你了，替我省去了许多收集神器的麻烦。不过嘛，幸运女神的眷顾到此为止了，今天你遇到可是传说中的拟像大师、伟大的收藏家，（咳咳）也就是本人。识相的话，乖乖把身上的神器交出来，我可能会考虑留你一命，否则你今天失去的可不只是宝贵的物品。怎么样，这笔买卖很划算吧？~ */
  IF ~~ THEN REPLY @511 /* ~哪里来的老登，也敢觊觎我的装备？再往前一步，我就让你后悔刚才说的话。~ */ GOTO 1
  IF ~~ THEN REPLY @512 /* ~拟像大师，巴尔之子也不是好惹的，真动起手来对谁都没好处，不如各退一步，就此离开。~ */ GOTO 2
  IF ~~ THEN REPLY @513 /* ~我可以把神器给你，但你必须保证让我安全离开。~ */ GOTO 3
END

IF ~~ THEN BEGIN 1 // from: 0.0
  SAY @514 /* ~哈哈！那你死定了！不过我保证给你留个全尸，顺便……在你的墓碑上刻上“<CHARNAME>”几个字。~ */
  IF ~~ THEN DO ~SetGlobalTimer("LZ_it_Rest","LOCALS",SIX_HOURS)
ReallyForceSpell(Myself,WIZARD_STONE_SKIN)
ReallyForceSpell(Myself,WIZARD_FIRE_SHIELD_RED)
ReallyForceSpell(Myself,WIZARD_FIRE_SHIELD_BLUE)
ReallyForceSpell(Myself,WIZARD_PROTECTION_FROM_ENERGY)
ReallyForceSpell(Myself,WIZARD_PROTECTION_FROM_MAGIC_WEAPONS)
ReallyForceSpell(Myself,WIZARD_SPELL_TURNING)
ReallyForceSpell(Myself,WIZARD_SPELL_IMMUNITY_ABJURATION)
Enemy()~ EXIT
END

IF ~~ THEN BEGIN 2 // from: 0.1
  SAY @515 /* ~不合作，那你只有死路一条。不过我保证给你留个全尸，顺便……在你的墓碑上刻上“<CHARNAME>”几个字。~ */
  IF ~~ THEN DO ~SetGlobalTimer("LZ_it_Rest","LOCALS",SIX_HOURS)
ReallyForceSpell(Myself,WIZARD_STONE_SKIN)
ReallyForceSpell(Myself,WIZARD_FIRE_SHIELD_RED)
ReallyForceSpell(Myself,WIZARD_FIRE_SHIELD_BLUE)
ReallyForceSpell(Myself,WIZARD_PROTECTION_FROM_ENERGY)
ReallyForceSpell(Myself,WIZARD_PROTECTION_FROM_MAGIC_WEAPONS)
ReallyForceSpell(Myself,WIZARD_SPELL_TURNING)
ReallyForceSpell(Myself,WIZARD_SPELL_IMMUNITY_ABJURATION)
Enemy()~ EXIT
END

IF ~~ THEN BEGIN 3 // from: 0.2
  SAY @516 /* ~识时务者为俊杰，既然东西已经到手，那更不能留下活口。不过我保证给你留个全尸，顺便……在你的墓碑上刻上“识时务者<CHARNAME>”几个字。~ */
  IF ~~ THEN DO ~SetGlobalTimer("LZ_it_Rest","LOCALS",SIX_HOURS)
ReallyForceSpell(Myself,WIZARD_STONE_SKIN)
ReallyForceSpell(Myself,WIZARD_FIRE_SHIELD_RED)
ReallyForceSpell(Myself,WIZARD_FIRE_SHIELD_BLUE)
ReallyForceSpell(Myself,WIZARD_PROTECTION_FROM_ENERGY)
ReallyForceSpell(Myself,WIZARD_PROTECTION_FROM_MAGIC_WEAPONS)
ReallyForceSpell(Myself,WIZARD_SPELL_TURNING)
ReallyForceSpell(Myself,WIZARD_SPELL_IMMUNITY_ABJURATION)
Enemy()~ EXIT
END
