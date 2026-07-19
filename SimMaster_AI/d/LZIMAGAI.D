// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : D:\BGT\Baldur's Gate Enhanced Edition Tetralogy
// resource : LZIMAGAI.dlg
// source   : Override\LZIMAGAI.dlg
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~LZIMAGAI~

IF ~True()~ THEN BEGIN 0 // from:
  SAY @504 /* ~~ */
  IF ~!Global("LZIMAGAI","GLOBAL",1)~ THEN REPLY @505 /* ~为敌人开启拟像AI，且敌对法师、盗贼、诗人会使用拟像术/拟像卷轴。~ */ DO ~SetGlobal("LZIMAGAI","GLOBAL",1)
CreateVisualEffectObject("SPCAUSEW",LastTalkedToBy(Myself))~ EXIT
  IF ~!Global("LZIMAGAI","GLOBAL",2)~ THEN REPLY @506 /* ~为玩家开启拟像AI，同时也为玩家的投影开启AI。~ */ DO ~SetGlobal("LZIMAGAI","GLOBAL",2)
CreateVisualEffectObject("SPBOLTGL",LastTalkedToBy(Myself))~ EXIT
  IF ~!Global("LZIMAGAI","GLOBAL",3)~ THEN REPLY @507 /* ~同时为敌人和玩家开启拟像AI。~ */ DO ~SetGlobal("LZIMAGAI","GLOBAL",3)
CreateVisualEffectObject("SPCAUSEW",LastTalkedToBy(Myself))
Wait(1)
CreateVisualEffectObject("SPBOLTGL",LastTalkedToBy(Myself))~ EXIT
  IF ~!Global("LZIMAGAI","GLOBAL",4)~ THEN REPLY @508 /* ~关闭拟像AI。~ */ DO ~SetGlobal("LZIMAGAI","GLOBAL",4)
CreateVisualEffectObject("OHRMJAR",LastTalkedToBy(Myself))~ EXIT
  IF ~~ THEN REPLY #15417 /* ~退出~ */ EXIT
END
