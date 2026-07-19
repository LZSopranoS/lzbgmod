// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : D:\Baldur's Gate II - Enhanced Edition
// resource : BDSZA.DLG
// source   : Override\BDSZA.DLG
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~BDSZA~

IF ~~ THEN BEGIN 0 // from:
  SAY @301 /* ~等等，他看起来不像普通人……哈！又是一个巴尔之子。~ */
  IF ~~ THEN EXTERN ~BDLAYEN~ 0
END

IF ~~ THEN BEGIN 1 // from:
  SAY @303 /* ~阿弗纳斯传送门已经关闭，外面的人不可能进来，这个巴尔之子看起来有点能耐。~ */
  IF ~~ THEN EXTERN ~BDSHANG~ 1
END

IF ~~ THEN BEGIN 2 // from:
  SAY @308 /* ~哈哈，不说是吧，那你进来的目的是……凯拉·白银？~ */
  IF ~~ THEN REPLY @310 /* ~没错，把凯拉·白银交给我，我马上离开。~ */ EXTERN ~BDSHANG~ 2
  IF ~~ THEN REPLY @311 /* ~废话，不想流血就把凯拉·白银交出来。~ */ EXTERN ~BDSHANG~ 5
END

IF ~~ THEN BEGIN 3 // from:
  SAY @309 /* ~哈哈，你是来找凯拉·白银的？~ */
  IF ~~ THEN REPLY @310 /* ~没错，把凯拉·白银交给我，我马上离开。~ */ EXTERN ~BDSHANG~ 2
  IF ~~ THEN REPLY @311 /* ~废话，不想流血就把凯拉·白银交出来。~ */ EXTERN ~BDSHANG~ 5
END
