;/////////////////////////////////////////////////////////////////////////////////
;                 Script du launcher du Nephilim Pack par Melua.
;////////////////////////////////////////////////////////////////////////////////

; ==================================  IMPORTANT  ========================================
!define TYPE "GD2.5"

; ==================================  VARIABLES  ========================================
Var LAST
Var INFO
Var THIS
Var A
Var B
Var l2language
!define SERVEUR "http://svn2.assembla.com/svn/nephilimpack/" ; avec le slash final

; ==============================  CONFIGURATION GENERALE  =============================
Icon np.ico
WindowIcon off
Name "Updater"
Caption "Updater"
SubCaption 3 " "
XPStyle on
SetCompressor /SOLID lzma
OutFile "loaderNP.exe"
RequestExecutionLevel admin
BrandingText "nephilim.melua.fr"
AutoCloseWindow true
ShowInstDetails nevershow
!include sections.nsh
!include logiclib.nsh
!include filefunc.nsh

; ==============================  CONFIGURATION DES PAGES  ==============================
Page custom check
Page instfiles

; ====================================  SECTIONS  ========================================
Section /o "update" update
${GetParent} $EXEDIR $R0
SetOutPath $R0\Patch 
ReadINIStr $A $TEMP\nephilimpack\version.ini nephilimpack setup
ReadINIStr $B $EXEDIR\version.ini nephilimpack setup
; verifie d'abord si l'INP est à jour
${If} $A == $B
IfFileExists $R0\Patch\${TYPE}_NephilimPack_Live.exe +2 0
NSISdl::download ${SERVEUR}${TYPE}/extra/${TYPE}_NephilimPack_Live.exe $R0\Patch\${TYPE}_NephilimPack_Live.exe
Goto Execute
${Else}
NSISdl::download ${SERVEUR}${TYPE}/extra/${TYPE}_NephilimPack_Live.exe $R0\Patch\${TYPE}_NephilimPack_Live.exe
${EndIf}
Execute:
Exec $R0\Patch\${TYPE}_NephilimPack_Live.exe
SectionEnd

Section /o "run" run
HideWindow
SetOutPath $EXEDIR ; important : répertoire d'execution neccessaire
ReadINIStr $l2language $EXEDIR\version.ini options language
${If} $l2language == "french"
File /oname=localization.ini localization.fr
${ElseIf} $l2language == "english"
File /oname=localization.ini localization.en
${ElseIf} $l2language == "default"
File /oname=localization.ini localization.en
${EndIf}
ExecWait l2.exe
nsExec::ExecToStack loaderCT1++.exe
Pop $0 ; return
Pop $1 ; text
StrCmp $0 "0" +2 0 ; pas de flag d'erreur
MessageBox MB_OK|MB_ICONSTOP "Echec du lancement :$1"
SectionEnd

; ====================================  FONCTIONS  ========================================
Function "check"
IfFileExists $TEMP\nephilimpack\version.ini 0 end ; en cas de problème de connectivité avec assembla.com
ReadINIStr $LAST $TEMP\nephilimpack\version.ini nephilimpack revision
ReadINIStr $INFO $TEMP\nephilimpack\version.ini nephilimpack info
ReadINIStr $THIS $EXEDIR\version.ini nephilimpack revision
${If} $LAST == $THIS
!insertmacro SetSectionFlag ${update} ${SECTION_OFF}
${Else}
MessageBox MB_YESNO|MB_ICONINFORMATION $INFO IDYES 0 IDNO end
!insertmacro SetSectionFlag ${update} ${SF_SELECTED}
Goto Skip
${EndIf}
end:
!insertmacro SetSectionFlag ${run} ${SF_SELECTED}
Skip:
FunctionEnd

; ====================================  EVENEMENTS  ========================================
Function .OnGUIInit
CreateDirectory $TEMP\nephilimpack
NSISdl::download ${SERVEUR}${TYPE}/extra/version.ini $TEMP\nephilimpack\version.ini
FunctionEnd

Function .OnGUIEnd
RMDir /r $TEMP\nephilimpack
FunctionEnd