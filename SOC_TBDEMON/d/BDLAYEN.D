// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : D:\Baldur's Gate II - Enhanced Edition
// resource : BDLAYEN.DLG
// source   : Override\BDLAYEN.DLG
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~BDLAYEN~

IF ~~ THEN BEGIN 0 // from:
  SAY @302 /* ~巴尔之子？凯拉·白银也是巴尔之子。~ */
  IF ~~ THEN EXTERN ~BDSZA~ 1
END
