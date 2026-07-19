// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : D:\Baldur's Gate II - Enhanced Edition
// resource : BDSHANG.DLG
// source   : Override\BDSHANG.DLG
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~BDSHANG~

IF ~True()~ THEN BEGIN 0 // from:
  SAY @300 /* ~该死的，什么情况？一个陌生人突然出现在这里。是谁把他放进来的？~ */
  IF ~~ THEN EXTERN ~BDSZA~ 0
END

IF ~~ THEN BEGIN 1 // from:
  SAY @304 /* ~喂，巴尔之子，你是怎么进来的？~ */
  IF ~~ THEN REPLY @305 /* ~保密。~ */ EXTERN ~BDSZA~ 2
  IF ~~ THEN REPLY @306 /* ~区区异界之门，几滴巴尔之血就能打开。~ */ EXTERN ~BDSZA~ 3
  IF ~~ THEN REPLY @307 /* ~废话少说，开战吧。~ */ GOTO 5
END

IF ~~ THEN BEGIN 2 // from:
  SAY @312 /* ~想要凯拉·白银，你打算付多少……50000，啊不，100000金币，先付100000金币，我们会考虑考虑把她交给你。~ */
  IF ~PartyGoldGT(99999)~ THEN REPLY @313 /* ~好，这里是100000金币。~ */ DO ~TakePartyGold(100000)~ GOTO 3
  IF ~~ THEN REPLY @314 /* ~门都没有，别想叫我付钱。~ */ GOTO 4
  IF ~~ THEN REPLY @315 /* ~少打嘴炮，今天就是你们的死期。~ */ GOTO 5
END

IF ~~ THEN BEGIN 3 // from: 2.0
  SAY @316 /* ~哈哈哈，看来你真的很有钱，杀了你应该能从尸体上找到更多。~ */
  IF ~~ THEN DO ~ActionOverride("BDSZA",Enemy())
ActionOverride("BDLAYEN",Enemy())
Enemy()~ EXIT
END

IF ~~ THEN BEGIN 4 // from: 2.1
  SAY @317 /* ~那你就留下吧，兄弟们，看来今天有些娱乐活动。~ */
  IF ~~ THEN DO ~ActionOverride("BDSZA",Enemy())
ActionOverride("BDLAYEN",Enemy())
Enemy()~ EXIT
END

IF ~~ THEN BEGIN 5 // from: 1.2 2.2
  SAY @318 /* ~哈哈，那你只有死路一条。~ */
  IF ~~ THEN DO ~ActionOverride("BDSZA",Enemy())
ActionOverride("BDLAYEN",Enemy())
Enemy()~ EXIT
END
