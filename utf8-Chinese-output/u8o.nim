import winim

proc initEnv()=
  var
    consoleHandle= GetStdHandle(STD_OUTPUT_HANDLE)
    fontInfo : CONSOLE_FONT_INFOEX
  # utf-8
  discard SetConsoleCP(65001)
  fontInfo.cbSize = cast[UINT](sizeof(CONSOLE_FONT_INFOEX))
  fontInfo.nFont = 11
  fontInfo.dwFontSize.X = 8
  fontInfo.dwFontSize.Y = 14
  fontInfo.FontFamily = 54
  fontInfo.FontWeight = 400
  var
    #fontname = +$"宋体"  
    #fontname = +$"Consolas"
    fontname = +$"Lucida Console"

  moveMem(addr fontInfo.FaceName, &fontname, 63)
  SetCurrentConsoleFontEx(consoleHandle, FALSE, &fontInfo)
  
initEnv()
echo "中文"
echo "Chinese 中文"