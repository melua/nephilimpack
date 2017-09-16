OutFile "splash_tester.exe"
AutoCloseWindow true

Function .onGUIInit
advsplash::show 1750 600 400 0xFF00FF $EXEDIR\splash
FunctionEnd

Section
SectionEnd