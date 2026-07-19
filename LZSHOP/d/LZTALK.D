// creator  : G:\NearInfinity20250611\NearInfinity\app\NearInfinity.jar (v2.4-20250611)
// game     : F:\Baldur's Gate II - Enhanced Edition
// resource : LZTALK.DLG
// source   : Override\LZTALK.DLG
// dialog   : lang\zh_CN\dialog.tlk
// dialogF  : (none)

BEGIN ~LZTALK~

IF ~True()~ THEN BEGIN 0 // from:
  SAY @101 /* ~本店提供各种职业技能：寻找陷阱、侦测幻象、潜行、吟唱歌曲...，特殊能力：暗影步、解除魔法...，高阶技能：万能巧手、强力战歌...。SOLO用了一人能顶一队，转职用了过程更加安逸，组队用更是方便搭配不同队友，实乃旅行费伦必备良品，怎么样有没有兴趣？~ */
  IF ~~ THEN REPLY #19986 /* ~哈！说得好，让我看看你有什么。~ */ DO ~StartStore("LZSHOP",LastTalkedToBy)~ EXIT
  IF ~~ THEN REPLY #61551 /* ~不用了，谢谢。~ */ EXIT
END
