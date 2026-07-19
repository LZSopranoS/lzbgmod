// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : F:\Baldur's Gate II - Enhanced Edition
// resource : LZXPSHAR.DLG
// source   : Override\LZXPSHAR.DLG
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~LZXPSHAR~

IF ~True()
~ THEN BEGIN 0 // from:
  SAY @112 /* ~经验分享，把自己的经验分享给经验少的队友，转职分享无效，选择：~ */
  IF ~IsGabber(Player1)
OR(5)
Global("LZXPCOP2_0","LOCALS",1)
Global("LZXPCOP3_0","LOCALS",1)
Global("LZXPCOP4_0","LOCALS",1)
Global("LZXPCOP5_0","LOCALS",1)
Global("LZXPCOP6_0","LOCALS",1)~ THEN REPLY @113 /* ~拿出10%的经验分享~ */ GOTO 1
  IF ~IsGabber(Player2)
OR(5)
Global("LZXPCOP1_1","LOCALS",1)
Global("LZXPCOP3_1","LOCALS",1)
Global("LZXPCOP4_1","LOCALS",1)
Global("LZXPCOP5_1","LOCALS",1)
Global("LZXPCOP6_1","LOCALS",1)
~ THEN REPLY @113 /* ~拿出10%的经验分享~ */ GOTO 2
  IF ~IsGabber(Player3)
OR(5)
Global("LZXPCOP1_2","LOCALS",1)
Global("LZXPCOP2_2","LOCALS",1)
Global("LZXPCOP4_2","LOCALS",1)
Global("LZXPCOP5_2","LOCALS",1)
Global("LZXPCOP6_2","LOCALS",1)
~ THEN REPLY @113 /* ~拿出10%的经验分享~ */ GOTO 3
  IF ~IsGabber(Player4)
OR(5)
Global("LZXPCOP1_3","LOCALS",1)
Global("LZXPCOP2_3","LOCALS",1)
Global("LZXPCOP3_3","LOCALS",1)
Global("LZXPCOP5_3","LOCALS",1)
Global("LZXPCOP6_3","LOCALS",1)~ THEN REPLY @113 /* ~拿出10%的经验分享~ */ GOTO 4
  IF ~IsGabber(Player5)
OR(5)
Global("LZXPCOP1_4","LOCALS",1)
Global("LZXPCOP2_4","LOCALS",1)
Global("LZXPCOP3_4","LOCALS",1)
Global("LZXPCOP4_4","LOCALS",1)
Global("LZXPCOP6_4","LOCALS",1)~ THEN REPLY @113 /* ~拿出10%的经验分享~ */ GOTO 5
  IF ~IsGabber(Player6)
OR(5)
Global("LZXPCOP1_5","LOCALS",1)
Global("LZXPCOP2_5","LOCALS",1)
Global("LZXPCOP3_5","LOCALS",1)
Global("LZXPCOP4_5","LOCALS",1)
Global("LZXPCOP5_5","LOCALS",1)~ THEN REPLY @113 /* ~拿出10%的经验分享~ */ GOTO 6
  IF ~~ THEN REPLY #15417 /* ~退出~ */ DO ~SetGlobal("LZXPSHARETALK","LOCALS",0)
DestroySelf()~ EXIT
END

IF ~IsGabber(Player1)~ THEN BEGIN 1 // from: 0.0
  SAY @114 /* ~选择需要分享的队友：~ */
  IF ~InParty(Player2)
Global("LZXPCOP2_0","LOCALS",1)~ THEN REPLY @116 /* ~<PLAYER2>~ */ DO ~SetGlobal("LZXPP1SHARE","LOCALS",1)~ EXIT
  IF ~InParty(Player3)
Global("LZXPCOP3_0","LOCALS",1)~ THEN REPLY @117 /* ~<PLAYER3>~ */ DO ~SetGlobal("LZXPP1SHARE","LOCALS",2)~ EXIT
  IF ~InParty(Player4)
Global("LZXPCOP4_0","LOCALS",1)~ THEN REPLY @118 /* ~<PLAYER4>~ */ DO ~SetGlobal("LZXPP1SHARE","LOCALS",3)~ EXIT
  IF ~InParty(Player5)
Global("LZXPCOP5_0","LOCALS",1)~ THEN REPLY @119 /* ~<PLAYER5>~ */ DO ~SetGlobal("LZXPP1SHARE","LOCALS",4)~ EXIT
  IF ~InParty(Player6)
Global("LZXPCOP6_0","LOCALS",1)~ THEN REPLY @120 /* ~<PLAYER6>~ */ DO ~SetGlobal("LZXPP1SHARE","LOCALS",5)~ EXIT
END

IF ~IsGabber(Player2)~ THEN BEGIN 2 // from: 0.1
  SAY @114 /* ~选择需要分享的队友：~ */
  IF ~InParty(Player1)
Global("LZXPCOP1_1","LOCALS",1)~ THEN REPLY @115 /* ~<CHARNAME>~ */ DO ~SetGlobal("LZXPP2SHARE","LOCALS",1)~ EXIT
  IF ~InParty(Player3)
Global("LZXPCOP3_1","LOCALS",1)~ THEN REPLY @117 /* ~<PLAYER3>~ */ DO ~SetGlobal("LZXPP2SHARE","LOCALS",2)~ EXIT
  IF ~InParty(Player4)
Global("LZXPCOP4_1","LOCALS",1)~ THEN REPLY @118 /* ~<PLAYER4>~ */ DO ~SetGlobal("LZXPP2SHARE","LOCALS",3)~ EXIT
  IF ~InParty(Player5)
Global("LZXPCOP5_1","LOCALS",1)~ THEN REPLY @119 /* ~<PLAYER5>~ */ DO ~SetGlobal("LZXPP2SHARE","LOCALS",4)~ EXIT
  IF ~InParty(Player6)
Global("LZXPCOP6_1","LOCALS",1)~ THEN REPLY @120 /* ~<PLAYER6>~ */ DO ~SetGlobal("LZXPP2SHARE","LOCALS",5)~ EXIT
END

IF ~IsGabber(Player3)~ THEN BEGIN 3 // from: 0.2
  SAY @114 /* ~选择需要分享的队友：~ */
  IF ~InParty(Player1)
Global("LZXPCOP1_2","LOCALS",1)~ THEN REPLY @115 /* ~<CHARNAME>~ */ DO ~SetGlobal("LZXPP3SHARE","LOCALS",1)~ EXIT
  IF ~InParty(Player2)
Global("LZXPCOP2_2","LOCALS",1)~ THEN REPLY @116 /* ~<PLAYER2>~ */ DO ~SetGlobal("LZXPP3SHARE","LOCALS",2)~ EXIT
  IF ~InParty(Player4)
Global("LZXPCOP4_2","LOCALS",1)~ THEN REPLY @118 /* ~<PLAYER4>~ */ DO ~SetGlobal("LZXPP3SHARE","LOCALS",3)~ EXIT
  IF ~InParty(Player5)
Global("LZXPCOP5_2","LOCALS",1)~ THEN REPLY @119 /* ~<PLAYER5>~ */ DO ~SetGlobal("LZXPP3SHARE","LOCALS",4)~ EXIT
  IF ~InParty(Player6)
Global("LZXPCOP6_2","LOCALS",1)~ THEN REPLY @120 /* ~<PLAYER6>~ */ DO ~SetGlobal("LZXPP3SHARE","LOCALS",5)~ EXIT
END

IF ~IsGabber(Player4)~ THEN BEGIN 4 // from: 0.3
  SAY @114 /* ~选择需要分享的队友：~ */
  IF ~InParty(Player1)
Global("LZXPCOP1_3","LOCALS",1)~ THEN REPLY @115 /* ~<CHARNAME>~ */ DO ~SetGlobal("LZXPP4SHARE","LOCALS",1)~ EXIT
  IF ~InParty(Player2)
Global("LZXPCOP2_3","LOCALS",1)~ THEN REPLY @116 /* ~<PLAYER2>~ */ DO ~SetGlobal("LZXPP4SHARE","LOCALS",2)~ EXIT
  IF ~InParty(Player3)
Global("LZXPCOP3_3","LOCALS",1)~ THEN REPLY @117 /* ~<PLAYER3>~ */ DO ~SetGlobal("LZXPP4SHARE","LOCALS",3)~ EXIT
  IF ~InParty(Player5)
Global("LZXPCOP5_3","LOCALS",1)~ THEN REPLY @119 /* ~<PLAYER5>~ */ DO ~SetGlobal("LZXPP4SHARE","LOCALS",4)~ EXIT
  IF ~InParty(Player6)
Global("LZXPCOP6_3","LOCALS",1)~ THEN REPLY @120 /* ~<PLAYER6>~ */ DO ~SetGlobal("LZXPP4SHARE","LOCALS",5)~ EXIT
END

IF ~IsGabber(Player5)~ THEN BEGIN 5 // from: 0.4
  SAY @114 /* ~选择需要分享的队友：~ */
  IF ~InParty(Player1)
Global("LZXPCOP1_4","LOCALS",1)~ THEN REPLY @115 /* ~<CHARNAME>~ */ DO ~SetGlobal("LZXPP5SHARE","LOCALS",1)~ EXIT
  IF ~InParty(Player2)
Global("LZXPCOP2_4","LOCALS",1)~ THEN REPLY @116 /* ~<PLAYER2>~ */ DO ~SetGlobal("LZXPP5SHARE","LOCALS",2)~ EXIT
  IF ~InParty(Player3)
Global("LZXPCOP3_4","LOCALS",1)~ THEN REPLY @117 /* ~<PLAYER3>~ */ DO ~SetGlobal("LZXPP5SHARE","LOCALS",3)~ EXIT
  IF ~InParty(Player4)
Global("LZXPCOP4_4","LOCALS",1)~ THEN REPLY @118 /* ~<PLAYER4>~ */ DO ~SetGlobal("LZXPP5SHARE","LOCALS",4)~ EXIT
  IF ~InParty(Player6)
Global("LZXPCOP6_4","LOCALS",1)~ THEN REPLY @120 /* ~<PLAYER6>~ */ DO ~SetGlobal("LZXPP5SHARE","LOCALS",5)~ EXIT
END

IF ~IsGabber(Player6)~ THEN BEGIN 6 // from: 0.5
  SAY @114 /* ~选择需要分享的队友：~ */
  IF ~InParty(Player1)
Global("LZXPCOP1_5","LOCALS",1)~ THEN REPLY @115 /* ~<CHARNAME>~ */ DO ~SetGlobal("LZXPP6SHARE","LOCALS",1)~ EXIT
  IF ~InParty(Player2)
Global("LZXPCOP2_5","LOCALS",1)~ THEN REPLY @116 /* ~<PLAYER2>~ */ DO ~SetGlobal("LZXPP6SHARE","LOCALS",2)~ EXIT
  IF ~InParty(Player3)
Global("LZXPCOP3_5","LOCALS",1)~ THEN REPLY @117 /* ~<PLAYER3>~ */ DO ~SetGlobal("LZXPP6SHARE","LOCALS",3)~ EXIT
  IF ~InParty(Player4)
Global("LZXPCOP4_5","LOCALS",1)~ THEN REPLY @118 /* ~<PLAYER4>~ */ DO ~SetGlobal("LZXPP6SHARE","LOCALS",4)~ EXIT
  IF ~InParty(Player5)
Global("LZXPCOP5_5","LOCALS",1)~ THEN REPLY @119 /* ~<PLAYER5>~ */ DO ~SetGlobal("LZXPP6SHARE","LOCALS",5)~ EXIT
END
