;/////////////////////////////////////////////////////////////////////////////////
;      Script d'installation du Nephilim Pack version 3 (UMUIb2) par Melua.
;////////////////////////////////////////////////////////////////////////////////

; =======================  CONFIGURATION GENERALE  ==========================
; Lettre de version
!define Setup "M"

; client Lineage II
!define CLIENT "GD2.5"

; URL du serveur
!define SERVEUR "http://svn2.assembla.com/svn/nephilimpack/"

; Algo de compression
SetCompressor /SOLID lzma

; Inclure la Modern User Interface et la bibliothèque logique
!include "umui.nsh"
!include "logiclib.nsh"
!include "filefunc.nsh"

; Nom de l'installateur
Name "Nephilim Pack"
Caption "Nephilim Pack Live Setup ${Setup}"

; Texte de marque
BrandingText "Partenaire de Gowonda.com"

; Variables globales
;Var hmci
Var /GLOBAL ConnectedState
Var /GLOBAL UPGRADE
Var /GLOBAL RestoreConfig
Var /GLOBAL REV

; Options (INI)
Var Damages
Var l2language
Var proposal
Var isDev

; Version du Client
Var Bg
Var Text

; splash screen
!define splashimage "splash.bmp"

; General Interface Settings
!insertmacro MUI_DEFAULT UMUI_TEXT_COLOR "B4D3EA"
!insertmacro MUI_DEFAULT MUI_BGCOLOR "3B3B3B"
!insertmacro MUI_DEFAULT UMUI_TEXT_LIGHTCOLOR "FFFFFF"
!insertmacro MUI_DEFAULT UMUI_HEADERTEXT_COLOR "B4D3EA"
!insertmacro MUI_DEFAULT UMUI_BRANDINGTEXTFRONTCOLOR "B4D3EA"
!insertmacro MUI_DEFAULT UMUI_BRANDINGTEXTBACKCOLOR "6D7381"
!insertmacro MUI_DEFAULT UMUI_DISABLED_BUTTON_TEXT_COLOR "808080"
!insertmacro MUI_DEFAULT UMUI_SELECTED_BUTTON_TEXT_COLOR "B4D3EA"
!insertmacro MUI_DEFAULT UMUI_BUTTON_TEXT_COLOR "B4D3EA"
!insertmacro MUI_DEFAULT UMUI_LEFTIMAGE_BMP "left.bmp"
!insertmacro MUI_DEFAULT UMUI_HEADERBGIMAGE_BMP "header.bmp"
!insertmacro MUI_DEFAULT UMUI_BOTTOMIMAGE_BMP "bottom.bmp"
!insertmacro MUI_DEFAULT UMUI_BUTTONIMAGE_BMP "button.bmp"
;!insertmacro MUI_DEFAULT UMUI_PAGEBGIMAGE_BMP "${NSISDIR}\Contrib\UltraModernUI\Skins\gray\PageBG.bmp"
!insertmacro MUI_DEFAULT UMUI_SCROLLBARIMAGE_BMP "scrollbar.bmp"
;!insertmacro MUI_DEFAULT MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\UltraModernUI\Skins\gray\Wizard.bmp"
!insertmacro MUI_DEFAULT MUI_ICON "np.ico"

; fichier compile
OutFile "${CLIENT}_NephilimPack_Live.exe"

; Privilèges recquis pour Windows Vista
RequestExecutionLevel admin

; Confirmer l'abandon de l'utilisateur
!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_CANCEL_DEFAULT

; =======================  CONFIGURATION INTERFACE  ==========================
!define UMUI_USE_ALTERNATE_PAGE
; Page d'accueil
!define MUI_WELCOMEPAGE_TITLE "Nephilim Pack 3"
!define MUI_WELCOMEPAGE_TEXT "Cet installeur va vous permettre de traduire en français votre client Lineage II grâce au travail de l'équipe du projet Nephilim Pack. L'installeur intègre également une multitude d'options grâce en partie aux travaux de Soltys et de Fyyre. Vous pouvez intégrer cet installeur dans un autre installeur, pack, patch ou projet. La traduction seule ne compromet pas la compatibilité avec les serveurs ni avec les autres patchs.\r\n\r\nL'installeur détecte automatiquement s'il s'agit d'une première installation ou d'une mise à jour et si le client est original ou déjà patché. Vous devez disposer d'une connexion active à Internet pour installer la plupart des options. Sauf mention contraire de votre serveur, il est vivement conseillé d'avoir fait deux Full Check de votre client Lineage II avant de procéder à cette installation."

; Page Licence
!define MUI_LICENSEPAGE_BGCOLOR "6D7381"
!define MUI_LICENSEPAGE_BUTTON "Confirmer"
!define MUI_LICENSEPAGE_CHECKBOX
!define MUI_LICENSEPAGE_CHECKBOX_TEXT "J'ai lu ces informations essentielles avant d'installer et si je mens j'irai en enfer."

; Page de confirmation
!define UMUI_CONFIRMPAGE_TEXTBOX recapitulatif

; Page des composants
!define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO " "

; Page d'installation
ShowInstDetails show
CompletedText "Craft terminé !"

; Page de fin
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_TITLE "Nephilim Pack 3"
!define MUI_FINISHPAGE_TITLE_3LINES
!define MUI_FINISHPAGE_TEXT "L'installation est maintenant terminée. Vous pouvez profiter de votre client Lineage II en français. Si ce projet vous plaît n'hésitez pas à en faire la promotion et à pourquoi pas nous rejoindre. Vous participeriez à une traduction sérieuse et indépendante en mettant le fruit de votre travail à disposition de toute la communauté L2 et il n'est pas néccessaire de connaître des langages informatiques."
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_RUN "$INSTDIR\system\loaderNP.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Lancer Lineage II patché"
;!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION "Statistics"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Comptabiliser mon installation"
;!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_LINK "En cas de problèmes n'hésitez pas à contacter le forum officiel"
!define MUI_FINISHPAGE_LINK_LOCATION "http://nephilim.melua.fr"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT

; =============================  CONFIGURATION DES PAGES  =============================

; Pages
Page custom Background
!insertmacro MUI_PAGE_WELCOME
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW "LicenseScroll"
!insertmacro MUI_PAGE_LICENSE "apropos.txt"
!insertmacro MUI_PAGE_DIRECTORY
Page custom Options
Page custom Connectivite
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro UMUI_PAGE_CONFIRM
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro UMUI_PAGE_ABORT

; Types d'installation
InstType "Désinstallation partielle"
InstType "Désinstallation complète"
InstType /CUSTOMSTRING=Installation
InstType /COMPONENTSONLYONCUSTOM


; Inclure la langue francaise
!insertmacro MUI_LANGUAGE "French"

; ====================================  SECTIONS  ========================================

Section "-Pebkac" Pebkac
  IfFileExists $INSTDIR\install.log end 0
  Call GetLocalTime
  Pop $0 ;Variable (for day)
  Pop $1 ;Variable (for month)
  Pop $2 ;Variable (for year)
  Pop $3 ;Variable (for day of week name)
  Pop $4 ;Variable (for hour)
  Pop $5 ;Variable (for minute)
  Pop $6 ;Variable (for second)
  MessageBox MB_YESNO|MB_ICONINFORMATION|MB_DEFBUTTON2 "Malgré tous les efforts portés sur la réversibilité de cet installeur, nous ne pouvons résoudre les éventuels problèmes liés à l'utilisateur mais nous pouvons faire une sauvegarde complète du dossier system immédiatemment, notez que cette sauvegarde est facultative et inutile dans la plupart des cas et que cet installeur ne l'utilisera pas par la suite.$\n$\nSauvegarder vers$\n$INSTDIR\Sauvegarde $0-$1-$2 $4-$5-$6 ?" IDYES pebkac IDNO end
  pebkac:
  DetailPrint "=== Sauvegarde ==="
  CopyFiles /SILENT $INSTDIR\system\*.* "$INSTDIR\Sauvegarde $0-$1-$2 $4-$5-$6"
  end: ;rien
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section "-Upgrade" Upgrade
  Call GetLocalTime
  Pop $0 ;Variable (for day)
  Pop $1 ;Variable (for month)
  Pop $2 ;Variable (for year)
  Pop $3 ;Variable (for day of week name)
  Pop $4 ;Variable (for hour)
  Pop $5 ;Variable (for minute)
  Pop $6 ;Variable (for second)
  MessageBox MB_YESNOCANCEL|MB_ICONEXCLAMATION|MB_DEFBUTTON3 "Hmmm, si vous pensez que votre client est assez vieux (si votre dernier Full Check date un peu) nous vous proposons de mettre à jour Lineage II pour être sur que le Nephilim Pack fonctionne, vos configurations et vos captures d'écran seront conservées, le reste sera sauvegardé vers $INSTDIR\Ancien system $0-$1-$2 $4-$5-$6$\n$\nSouhaitez-vous mettre à jour Lineage II ? Si vous cliquez sur Annuler, le Nephilim Pack ne vous le proposera plus à nouveau." IDYES upgrade IDNO end
  WriteINIStr $INSTDIR\system\version.ini options proposal false
  Goto end
  upgrade:
  DetailPrint "=== Upgrade du client ==="
  SetOutPath $INSTDIR
  CreateDirectory $TEMP\nephilimpack\local ; pour éviter les conflits avec les deux version.ini
  ; sauvegarde des config et des images
  CopyFiles /SILENT $INSTDIR\system\*.ini $TEMP\nephilimpack\local
  CopyFiles /SILENT $INSTDIR\system\*.jpg $TEMP\nephilimpack\local
  CopyFiles /SILENT $INSTDIR\system\*.bmp $TEMP\nephilimpack\local
  ; download
  DetailPrint "Téléchargement de la mise à jour du client"
  ReadINIStr $UPGRADE $TEMP\nephilimpack\version.ini nephilimpack upgrade
  NSISdl::download $UPGRADE upgrade.7z
  ; quand faudra-t-il restaurer la config ?
  IfFileExists $INSTDIR\system\loader.exe patched 0
  IfFileExists $INSTDIR\system\loaderCT1++.exe patched 0
  IfFileExists $INSTDIR\system\loaderCT2.exe patched 0
  StrCpy $RestoreConfig "before" ; non patché
  Goto ancient
  patched:
  StrCpy $RestoreConfig "after" ; patché
  ancient:
  ; sauvegarde le system actuel
  Rename $INSTDIR\system "$INSTDIR\Ancien system $0-$1-$2 $4-$5-$6"
  ; extrait
  SetOutPath $INSTDIR\system
  Rename $INSTDIR\upgrade.7z upgrade.7z
  Nsis7z::ExtractWithDetails "upgrade.7z" "Installing package %s..."
  Delete upgrade.7z
  ; restauration des configs et des images
  ${If} $RestoreConfig == "before"
  DetailPrint "Restauration des configs et des images"
  CopyFiles /SILENT $TEMP\nephilimpack\local\*.ini $INSTDIR\system
  CopyFiles /SILENT $TEMP\nephilimpack\local\*.jpg $INSTDIR\system
  CopyFiles /SILENT $TEMP\nephilimpack\local\*.bmp $INSTDIR\system
  ${EndIf}
  end: ;rien
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section "Patchage" Patchage
    
  LogSet on
  ;SectionIn RO

  ;############# TYPE D'INSTALLATION ##########
  ; vérifie si c'est la première installation ou une mise à jour
  IfFileExists $INSTDIR\system\enc-english\*.* end install
  
   ;############# DETECTION DU PATCH #################
  install:
  ; Détection du pach
  IfFileExists $INSTDIR\system\loader.exe patched 0
  IfFileExists $INSTDIR\system\loaderCT1++.exe patched 0
  IfFileExists $INSTDIR\system\loaderCT2.exe patched nonpatched
  patched:
  DetailPrint "=== Déjà patché ==="
  DetailPrint "Le client est visiblement déjà patché. L'installation continue..."
  Goto end
  
  ;############## PATCHAGE DU SYSTEME ################
  nonpatched:
  DetailPrint "=== Patchage ==="
  DetailPrint "Le client va être patché incessamment sous peu..."
  ; On vérifie qu'il n'y a pas déjà de dossier backup pour ne pas faire avorter patcher
  IfFileExists $INSTDIR\system\backup\*.* 0 +2
  MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION "Votre répertoire d'installation contient déjà un dossier backup.$\nSupprimez backup ou renommez-le." IDRETRY -1 IDCANCEL echec
  ; Fichiers temporaires
  SetOutPath $INSTDIR\system
  File l2encdec.exe
  File libgmp-10.dll
  File libz-1.dll
  File patcher.exe
  ; nsExec va exécuter le programme en ligne de commande et capturer la sortie sans ouvrir de fenetre.
  DetailPrint "Patchage en cours..."
  nsExec::ExecToLog patcher.exe
  ; on vérifie si le patchage a bien fonctionné
  Pop $0 # return value/error/timeout
  StrCmp $0 "0" +12 0 ; vérifie si il n'y a pas eu de return value avec un flag d'erreur, si oui (0) saute de douze lignes, si erreur alors Abort.
  DetailPrint "Le patchage a rencontré une erreur et a du s'arrêter."
  SetDetailsPrint none
  CopyFiles /SILENT $INSTDIR\system\backup\*.* $INSTDIR\system ; restaure le backup du patcher
  RMDir /r $INSTDIR\system\backup
  Delete l2encdec.exe
  Delete libgmp-10.dll
  Delete libz-1.dll
  Delete patcher.exe
  SetDetailsPrint both
  DetailPrint "Client restauré dans son état précédent"
  Abort "Echec de l'installation."
  ; Suppression des fichiers temporaires
  Delete l2encdec.exe
  Delete libgmp-10.dll
  Delete libz-1.dll
  Delete patcher.exe
  ; restauration des configs et des images
  ${If} $RestoreConfig == "after"
  DetailPrint "Restauration des configs et des images"
  CopyFiles /SILENT $TEMP\nephilimpack\local\*.ini $INSTDIR\system
  CopyFiles /SILENT $TEMP\nephilimpack\local\*.jpg $INSTDIR\system
  CopyFiles /SILENT $TEMP\nephilimpack\local\*.bmp $INSTDIR\system
  ${EndIf}
  
  ; Rename du bin et ticker
  Rename l2.bin l2.exe ; CT2.3
  ;File gg-bps.dll ; UTILITE ? => later C2
  File loaderCT1++.exe
  Goto end
  
  ; en cas d'annulation du patcher
  echec:
  SetDetailsPrint none
  Delete l2encdec.exe
  Delete libgmp-10.dll
  Delete libz-1.dll
  Delete patcher.exe
  SetDetailsPrint both
  DetailPrint "Vous ne voulez donc vraiment pas supprimer le dossier backup ?"
  Abort "Patchage annulé par l'utilisateur."
  
  end: ;rien
  
  SectionEnd
  
;//////////////////////////////////////////////////////////////////////////////
  
Section "Traduction colorée" Traduction
    
  LogSet on
  ;SectionIn RO

  ;############# TYPE D'INSTALLATION (BIS) ##########
  ; vérifie si c'est la première installation ou une mise à jour
  IfFileExists $INSTDIR\system\enc-english\*.dat update install
  
  ;############## INSTALLATION DU NEPHILIMPACK ################
  install:
  DetailPrint "=== Première installation du pack ==="
  DetailPrint "Sauvegarde et installation à proprement parlé."
  SetOutPath $INSTDIR\system
  ; CreateDirectory : Vous devez toujours spécifier un répertoire absolu.
  CreateDirectory $INSTDIR\system\enc-english ; contiendra les fichiers patchés (enc) anglais (english) ce qui donne enc-english !
  ; Sauvegarde : Vous devez toujours spécifier une destination absolue.
  CopyFiles /SILENT actionname-e.dat $INSTDIR\system\enc-english
  CopyFiles /SILENT classinfo-e.dat $INSTDIR\system\enc-english
  CopyFiles /SILENT gametip-e.dat $INSTDIR\system\enc-english
  ;CopyFiles /SILENT skillname-e.dat $INSTDIR\system\enc-english
  CopyFiles /SILENT sysstring-e.dat $INSTDIR\system\enc-english
  CopyFiles /SILENT systemmsg-e.dat $INSTDIR\system\enc-english
  CopyFiles /SILENT zonename-e.dat $INSTDIR\system\enc-english
  ; Téléchargement et installation
  SetOutPath $TEMP\nephilimpack ; repertoire tampon car risque d'absence des fichiers dans le dépot officiel !!
  DetailPrint "Traduction des actions"
  NSISdl::download ${SERVEUR}${CLIENT}/system/actionname-e.dat actionname-e.dat
  CopyFiles /SILENT actionname-e.dat $INSTDIR\system
  DetailPrint "Traduction de la création de personnage"
  NSISdl::download ${SERVEUR}${CLIENT}/system/classinfo-e.dat classinfo-e.dat
  CopyFiles /SILENT classinfo-e.dat $INSTDIR\system
  DetailPrint "Traduction des astuces"
  NSISdl::download ${SERVEUR}${CLIENT}/system/gametip-e.dat gametip-e.dat
  CopyFiles /SILENT gametip-e.dat $INSTDIR\system
  ;DetailPrint "Traduction des compétences"
  ;NSISdl::download ${SERVEUR}${CLIENT}/system/skillname-e.dat skillname-e.dat
  ;CopyFiles /SILENT skillname-e.dat $INSTDIR\system
  DetailPrint "Traduction de l'interface"
  NSISdl::download ${SERVEUR}${CLIENT}/system/sysstring-e.dat sysstring-e.dat
  CopyFiles /SILENT sysstring-e.dat $INSTDIR\system
  DetailPrint "Traduction des messages"
  NSISdl::download ${SERVEUR}${CLIENT}/system/systemmsg-e.dat systemmsg-e.dat
  CopyFiles /SILENT systemmsg-e.dat $INSTDIR\system
  DetailPrint "Traduction des régions"
  NSISdl::download ${SERVEUR}${CLIENT}/system/zonename-e.dat zonename-e.dat
  CopyFiles /SILENT zonename-e.dat $INSTDIR\system
  DetailPrint "Téléchargement des informations de version"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/version.ini version.ini
  ReadINIStr $REV $TEMP\nephilimpack\version.ini nephilimpack revision
  ; Fichiers necessaires
  SetOutPath $INSTDIR\system
  Rename l2.bin l2.exe ; CT2.3
  ;File gg-bps.dll ; UTILITE ? => later C2
  File loaderCT1++.exe
  File loaderNP.exe
  ; Clonage & version
  DetailPrint "=== Clonage ==="
  SetOutPath $INSTDIR\Patch
  ${GetExeName} $R0 ; nom de l'executable
  DetailPrint "Possible échec de copie"
  CopyFiles /SILENT $R0 $OUTDIR ; se copie soi-même
  DetailPrint "=== Versioning ==="
  WriteINIStr $INSTDIR\system\version.ini nephilimpack revision $REV
  WriteINIStr $INSTDIR\system\version.ini nephilimpack setup ${Setup}
  DetailPrint "Revision: $REV"
  DetailPrint "Setup: ${Setup}"
  Goto link
  
  ;############# MISE A JOUR DU NEPHILIM PACK ################
  update:
  DetailPrint "=== Mise à jour du pack ==="
  DetailPrint "Le Nephilim Pack est visiblement déjà installé. Mise à jour..."
  ; Téléchargement et installation
  SetOutPath $TEMP\nephilimpack ; repertoire tampon car risque d'absence des fichiers dans le dépot officiel !!
    DetailPrint "Traduction des actions"
  NSISdl::download ${SERVEUR}${CLIENT}/system/actionname-e.dat actionname-e.dat
  CopyFiles /SILENT actionname-e.dat $INSTDIR\system
  DetailPrint "Traduction de la création de personnage"
  NSISdl::download ${SERVEUR}${CLIENT}/system/classinfo-e.dat classinfo-e.dat
  CopyFiles /SILENT classinfo-e.dat $INSTDIR\system
  DetailPrint "Traduction des astuces"
  NSISdl::download ${SERVEUR}${CLIENT}/system/gametip-e.dat gametip-e.dat
  CopyFiles /SILENT gametip-e.dat $INSTDIR\system
  ;DetailPrint "Traduction des compétences"
  ;NSISdl::download ${SERVEUR}${CLIENT}/system/skillname-e.dat skillname-e.dat
  ;CopyFiles /SILENT skillname-e.dat $INSTDIR\system
  DetailPrint "Traduction de l'interface"
  NSISdl::download ${SERVEUR}${CLIENT}/system/sysstring-e.dat sysstring-e.dat
  CopyFiles /SILENT sysstring-e.dat $INSTDIR\system
  DetailPrint "Traduction des messages"
  NSISdl::download ${SERVEUR}${CLIENT}/system/systemmsg-e.dat systemmsg-e.dat
  CopyFiles /SILENT systemmsg-e.dat $INSTDIR\system
  DetailPrint "Traduction des régions"
  NSISdl::download ${SERVEUR}${CLIENT}/system/zonename-e.dat zonename-e.dat
  CopyFiles /SILENT zonename-e.dat $INSTDIR\system
  DetailPrint "Téléchargement des informations de version"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/version.ini version.ini
  ReadINIStr $REV $TEMP\nephilimpack\version.ini nephilimpack revision
  ; Fichiers necessaires
  SetOutPath $INSTDIR\system
  File loaderNP.exe
  ; Clonage & version
  DetailPrint "=== Clonage ==="
  SetOutPath $INSTDIR\Patch
  ${GetExeName} $R0 ; nom de l'executable
  DetailPrint "Possible échec de copie"
  CopyFiles /SILENT $R0 $OUTDIR ; se copie soi-même
  DetailPrint "=== Versioning ==="
  WriteINIStr $INSTDIR\system\version.ini nephilimpack revision $REV
  WriteINIStr $INSTDIR\system\version.ini nephilimpack setup ${Setup}
  DetailPrint "Revision: $REV"
  DetailPrint "Setup: ${Setup}"

  
  ;############## RACCOURCI #################
  link:
  ; Question à l'utilisateur
  ;IfFileExists "$DESKTOP\Lineage 2.lnk" 0 +2
  ;Goto end
  ;MessageBox MB_YESNO|MB_ICONQUESTION "Souhaitez-vous un raccourci sur le bureau ?" IDYES 0 IDNO end
  DetailPrint "=== Création du raccourci ==="
  SetOutPath $INSTDIR\system ; attention cela configure le répertoire d'exécution du raccourci !!!
  ; Création d'un raccourci sur le bureau : raccourci / cible /commandes /fichier icone / icone / affichage /raccourci clavier / description
  CreateShortCut "$DESKTOP\Lineage 2.lnk" "$INSTDIR\system\loaderNP.exe" "" "$INSTDIR\system\l2.exe" \
  "0" "SW_SHOWNORMAL" "" "Lancer Lineage II patché"
  
  ;end: ;rien
  
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section "Nudité non modifiée" Naked0

  ; rien du tout
  ; typiquement pour résoudre un problème de radiobutton à la con

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section "Inactiver GameGuard" Wildcard ; coché par défaut

  LogSet on
  AddSize 9 ;ko
  DetailPrint "=== Désactiver GameGuard ==="
  SetOutPath $INSTDIR\system
  IfFileExists $INSTDIR\system\dsetup.bak +2 0
  CopyFiles /SILENT dsetup.dll $INSTDIR\system\dsetup.bak
  
  DetailPrint "Téléchargement : dsetup.dll"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/dsetup.dll $OUTDIR\dsetup.dll

  SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "-Dégats plein écran" Damages ; ne fonctionne plus !

  LogSet on
  DetailPrint "=== Dégats plein écran ==="
  SetOutPath $INSTDIR\system
  
  DetailPrint "Téléchargement : systemmsg-e.dat"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/damages.dat $OUTDIR\systemmsg-e.dat
  WriteINIStr $INSTDIR\system\version.ini options damages true

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Support Accents" Accents

  LogSet on
  AddSize 172 ;ko
  DetailPrint "=== Installation des accents ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\fire.dll +2 0
  Rename fire.dll $INSTDIR\system\enc-english\fire.dll ; fire.dll n'est pas dans backup il n'est PAS patche
  
  DetailPrint "Téléchargement : fire.dll"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/fire.dll $OUTDIR\fire.dll
  
  DetailPrint "Téléchargement : unichat.dll"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/unichat.dll $OUTDIR\unichat.dll ; attention nouveau fichier


SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Dezoom maximum" Dezoom
    
  LogSet on
  AddSize 5 ;ko
  DetailPrint "=== Installation du dezoom max ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\user.ini +2 0
  Rename user.ini $INSTDIR\system\enc-english\user.ini
  
  DetailPrint "Téléchargement : user.ini"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/user.ini $OUTDIR\user.ini

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Level des monstres" ShowLevel
    
  LogSet on
  AddSize 75 ;ko
  DetailPrint "=== Voir le level des monstres ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\npcname-e.dat +2 0
  Rename npcname-e.dat $INSTDIR\system\enc-english\npcname-e.dat
  
  DetailPrint "Téléchargement : npcname-e.dat"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/npcname-e.dat $OUTDIR\npcname-e.dat

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Nudité totale" NakedA1

  LogSet on
  AddSize 7751 ;ko
  DetailPrint "=== Nu total ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\chargrp.dat +2 0
  Rename chargrp.dat $INSTDIR\system\enc-english\chargrp.dat
  
  DetailPrint "Téléchargement : chargrp.dat"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/chargrp_NakedA1.dat $OUTDIR\chargrp.dat
  
  SetOutPath $INSTDIR\systextures
  IfFileExists $INSTDIR\systextures\NakedA.utx 0 +3
  DetailPrint "Déjà présent : NakedA.utx"
  Goto end
  DetailPrint "Téléchargement : NakedA.utx"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/NakedA.utx $OUTDIR\NakedA.utx
  end:
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Nudité accessoires" NakedA2

  LogSet on
  AddSize 7751 ;ko
  DetailPrint "=== Nu accessoires ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\chargrp.dat +2 0
  Rename chargrp.dat $INSTDIR\system\enc-english\chargrp.dat
  
  DetailPrint "Téléchargement : chargrp.dat"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/chargrp_NakedA2.dat $OUTDIR\chargrp.dat
  
  SetOutPath $INSTDIR\systextures
  IfFileExists $INSTDIR\systextures\NakedA.utx 0 +3
  DetailPrint "Déjà présent : NakedA.utx"
  Goto end
  DetailPrint "Téléchargement : NakedA.utx"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/NakedA.utx $OUTDIR\NakedA.utx
  end:
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Nudité bikini" NakedU

  LogSet on
  AddSize 7751 ;ko
  DetailPrint "=== Nu sous-vêtements ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\chargrp.dat +2 0
  Rename chargrp.dat $INSTDIR\system\enc-english\chargrp.dat
  
  DetailPrint "Téléchargement : chargrp.dat"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/chargrp_NakedU.dat $OUTDIR\chargrp.dat
  
  ;Unfortunately, since CT2.3 requires NakedA utx pack.
  SetOutPath $INSTDIR\systextures
  IfFileExists $INSTDIR\systextures\NakedA.utx 0 +3
  DetailPrint "Déjà présent : NakedA.utx"
  Goto end
  DetailPrint "Téléchargement : NakedA.utx"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/NakedA.utx $OUTDIR\NakedA.utx
  end:
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Tenues sexy" NakedB

  LogSet on
  AddSize 10473 ;ko
  DetailPrint "=== Tenues sexy ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\armorgrp.dat +2 0
  Rename armorgrp.dat $INSTDIR\system\enc-english\armorgrp.dat
  
  DetailPrint "Téléchargement : armorgrp.dat"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/armorgrp_NakedB.dat $OUTDIR\armorgrp.dat
  
  SetOutPath $INSTDIR\systextures
  IfFileExists $INSTDIR\systextures\NBNoS.utx 0 +3
  DetailPrint "Déjà présent : NBNoS.utx"
  Goto end1
  DetailPrint "Téléchargement : NBNoS.utx"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/NBNoS.utx $OUTDIR\NBNoS.utx
  end1:

  IfFileExists $INSTDIR\systextures\NBShd.utx 0 +3
  DetailPrint "Déjà présent : NBShd.utx"
  Goto end2
  DetailPrint "Téléchargement : NBShd.utx"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/NBShd.utx $OUTDIR\NBShd.utx
  end2:
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "HDR Glow" HdrGlow

  LogSet on
  AddSize 6 ;ko
  DetailPrint "=== HDR Glow ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\Env.int +2 0
  Rename Env.int $INSTDIR\system\enc-english\Env.int
  
  DetailPrint "Téléchargement : Env.int"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/Env.int $OUTDIR\Env.int

  SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Décoder la musique" Oggpatcher

  LogSet on
  DetailPrint "=== Décoder la musique ==="
  SetOutPath $INSTDIR\music
  
  DetailPrint "Téléchargement : oggpatcher.exe"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/oggpatcher.exe $OUTDIR\oggpatcher.exe
  nsExec::ExecToLog oggpatcher.exe  
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "-Choix de la langue" Localization

  LogSet on
  DetailPrint "=== Choix de la langue ==="
  SetOutPath $INSTDIR\system
  ; crée les fichiers francais
  CopyFiles actionname-e.dat actionname-fr.dat
  CopyFiles castlename-e.dat castlename-fr.dat
  CopyFiles classinfo-e.dat classinfo-fr.dat
  CopyFiles commandname-e.dat commandname-fr.dat
  CopyFiles creditgrp-e.dat creditgrp-fr.dat
  CopyFiles eula-e.dat eula-fr.dat
  CopyFiles gametip-e.dat gametip-fr.dat
  CopyFiles hennagrp-e.dat hennagrp-fr.dat
  CopyFiles huntingzone-e.dat huntingzone-fr.dat
  CopyFiles instantzonedata-e.dat instantzonedata-fr.dat
  CopyFiles itemname-e.dat itemname-fr.dat
  CopyFiles npcname-e.dat npcname-fr.dat
  CopyFiles obscene-e.dat obscene-fr.dat
  CopyFiles optiondata_client-e.dat optiondata_client-fr.dat
  CopyFiles productname-e.dat productname-fr.dat
  CopyFiles questname-e.dat questname-fr.dat
  CopyFiles raiddata-e.dat raiddata-fr.dat
  CopyFiles servername-e.dat servername-fr.dat
  ;CopyFiles skillname-e.dat skillname-fr.dat
  CopyFiles staticobject-e.dat staticobject-fr.dat
  CopyFiles symbolname-e.dat symbolname-fr.dat
  CopyFiles sysstring-e.dat sysstring-fr.dat
  CopyFiles systemmsg-e.dat systemmsg-fr.dat
  CopyFiles variationeffectgrp-e.dat variationeffectgrp-fr.dat
  CopyFiles zonename-e.dat zonename-fr.dat
  ; restaure les fichiers anglais
  CopyFiles $OUTDIR\enc-english\*-e.dat $OUTDIR
  ;WriteINIStr $OUTDIR\version.ini options language french ; à faire manuellement
  ;File /oname=localization.ini localization.fr
SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Désactiver censure" Censure
    
  LogSet on
  DetailPrint "=== Retrait de la censure ==="
  SetOutPath $INSTDIR\system
  CreateDirectory $INSTDIR\system\enc-english
  IfFileExists $INSTDIR\system\enc-english\obscene-e.dat +2 0
  CopyFiles /SILENT obscene-e.dat $INSTDIR\system\enc-english
  Delete obscene-e.dat
  Delete obscene-fr.dat ; EnableFrench

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Outils Développeur" Dev

  LogSet on
  DetailPrint "=== Console développeur ==="
  SetOutPath $INSTDIR\system
  ReadINIStr $isDev $INSTDIR\nephilimpack\version.ini options devtools
  ${If} $isDev != true
  CreateDirectory $INSTDIR\system\enc-english
  CopyFiles l2.ini $INSTDIR\system\enc-english\l2.bak
  
  DetailPrint "Téléchargement : l2.ini"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/devtools.ini $OUTDIR\l2.ini
  WriteINIStr $INSTDIR\system\version.ini options devtools true
  ${EndIf}

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Visualiseur de modèle" Umodel

  LogSet on
  DetailPrint "=== Visualiseur UE ==="
  SetOutPath "$INSTDIR\UE Viewer"
  DetailPrint "Téléchargement : UmodelGUI.exe"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/UmodelGUI.exe $OUTDIR\UmodelGUI.exe
  FileOpen $9 my.pref w
  FileWrite $9 $INSTDIR
  FileClose $9
  CreateShortCut "$DESKTOP\UmodelGUI.lnk" "$INSTDIR\UE Viewer\UmodelGUI.exe" "" "$INSTDIR\UE Viewer\UmodelGUI.exe" "0" "SW_SHOWNORMAL" "" "Visualisation Unreal Engine"


SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "Modifier LSA" LSA

  LogSet on
  DetailPrint "=== Login Server Authentification ==="
  SetOutPath $INSTDIR\system
  IfFileExists $INSTDIR\system\engine.bak +2 0
  CopyFiles /SILENT engine.dll $INSTDIR\system\engine.bak
  DetailPrint "Téléchargement : chg_auth.exe"
  NSISdl::download ${SERVEUR}${CLIENT}/extra/chg_auth.exe $OUTDIR\chg_auth.exe
  ExecWait chg_auth.exe
  Delete chg_auth.exe

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "-Désinstaller" Desinstaller

  LogSet on
  SectionIn 1

  ;############# CONFIRMATION ############
  DetailPrint "=== Désinstallation partielle ==="
  MessageBox MB_YESNO "Ceci désinstallera le Nephilim Pack et toutes ses options.$\n$\nEtes-vous sûr de vouloir continuer ?" IDYES +2 IDNO 0
  Abort "Désinstallation partielle annulée par l'utilisateur."
  ;############## STAYPATCH ################
  ; Vérification de l'existence du répertoire enc-english
  IfFileExists $INSTDIR\system\enc-english\*.* +3 0
  MessageBox MB_OK|MB_ICONSTOP "Sauvegarde introuvable. Impossible de désinstaller."
  Abort "La désinstallation a échoué."
  DetailPrint "Le client sera encore patché."
  ; Déplacer : Vous devez toujours spécifier une destination absolue.
  CopyFiles /SILENT $INSTDIR\system\enc-english\*.* $INSTDIR\system ;restaure la sauvegarde du Nephilim Pack
  ; RMDir : chemin complet sans joker
  RMDir /r $INSTDIR\system\enc-english
  Delete unichat.dll ; fichier ajoute apres patcher
  Delete $INSTDIR\systextures\NakedA.utx ; texture pack
  Delete $INSTDIR\systextures\NBNoS.utx ; texture pack
  Delete $INSTDIR\systextures\NBShd.utx ; texture pack
  Delete $INSTDIR\system\loaderNP.exe ; loader Nephilim Pack
  IfFileExists $INSTDIR\system\engine.bak 0 +3
  Delete $INSTDIR\system\engine.dll
  Rename $INSTDIR\system\engine.bak $INSTDIR\system\engine.dll
  IfFileExists $INSTDIR\system\dsetup.bak 0 +3
  Delete $INSTDIR\system\dsetup.dll
  Rename $INSTDIR\system\dsetup.bak $INSTDIR\system\dsetup.dll
  ; Supression du versionning
  Delete $INSTDIR\system\version.ini
  ; Suppression du EnableFrench
  Delete *-fr.dat
  File /oname=$INSTDIR\system\localization.ini localization.en
  ; Reencodage musique
  IfFileExists $INSTDIR\music\oggpatcher.exe 0 +4
  SetOutPath $INSTDIR\music
  nsExec::ExecToLog '"oggpatcher.exe" -r'
  Delete oggpatcher.exe

SectionEnd

;//////////////////////////////////////////////////////////////////////////////

Section /o "-Dépatcher" Depatcher

  LogSet on
  SectionIn 2

  ;############# CONFIRMATION ############
  DetailPrint "=== Désinstallation complète ==="
  MessageBox MB_YESNO "Ceci restaurera votre client dans son état original.$\n$\nEtes-vous sûr de vouloir continuer ?" IDYES +2 IDNO 0
  Abort "Désinstallation complète annulée par l'utilisateur."
  ;############## UNPATCH #################
  ; Vérification de l'existence du répertoire backup
  IfFileExists $INSTDIR\system\backup\*.* +3 0
  MessageBox MB_OK|MB_ICONSTOP "Sauvegarde introuvable. Impossible de dépatcher."
  Abort "Le dépatchage a echoué."
  DetailPrint "Le client ne sera plus patché."
  ; Déplacer : Vous devez toujours spécifier une destination absolue.
  CopyFiles /SILENT $INSTDIR\system\backup\*.* $INSTDIR\system ; restaure le backup du patcher
  IfFileExists $INSTDIR\system\enc-english\fire.dll 0 +2
  CopyFiles /SILENT $INSTDIR\system\enc-english\fire.dll $INSTDIR\system ; en effet fire.dll n'est pas patché & n'est pas dans backup !
  ; RMDir : chemin complet sans joker
  RMDir /r $INSTDIR\system\backup
  RMDir /r $INSTDIR\system\enc-english
  Delete $INSTDIR\system\gg-bps.dll
  Delete $INSTDIR\system\loaderCT1++.exe
  Delete $INSTDIR\system\loaderNP.exe ; loader Nephilim Pack
  Delete $INSTDIR\system\unichat.dll ; fichier ajouté
  Delete $INSTDIR\systextures\NakedA.utx ; texture pack
  Delete $INSTDIR\systextures\NBNoS.utx ; texture pack
  Delete $INSTDIR\systextures\NBShd.utx ; texture pack
  IfFileExists $INSTDIR\system\engine.bak 0 +3
  Delete $INSTDIR\system\engine.dll
  Rename $INSTDIR\system\engine.bak $INSTDIR\system\engine.dll
  IfFileExists $INSTDIR\system\dsetup.bak 0 +3
  Delete $INSTDIR\system\dsetup.dll
  Rename $INSTDIR\system\dsetup.bak $INSTDIR\system\dsetup.dll
  ; Supression du versionning
  Delete $INSTDIR\system\version.ini
  ; Suppression du EnableFrench
  Delete *-fr.dat
  File /oname=$INSTDIR\system\localization.ini localization.en
  ; Suppression du raccourci
  Delete "$DESKTOP\Lineage 2.lnk"
  ; Reencodage musique
  IfFileExists $INSTDIR\music\oggpatcher.exe 0 +4
  SetOutPath $INSTDIR\music
  nsExec::ExecToLog '"oggpatcher.exe" -r'
  Delete oggpatcher.exe
  ; Rename du bin
  SetOutPath $INSTDIR\system
  Rename l2.exe l2.bin

SectionEnd

; ===============================  FONCTIONS  ===============================

Function .onInit
  ; splash screen
  SetOutPath $TEMP\nephilimpack
  File /oname=spltmp.bmp ${splashimage}
  ;advsplash::show Delay FadeIn FadeOut KeyColor (ex:0xFF00FF or -1) FileName
  advsplash::show 1750 600 400 0x3B3B3B $TEMP\nephilimpack\spltmp
  Delete $TEMP\nephilimpack\spltmp.bmp
  ; Composantes par defaut
  StrCpy $1 ${Naked0}
  ; InstallDir
  ${GetParent} $EXEDIR $R0
  IfFileExists $R0\system\l2.ini yes no
  yes:
  StrCpy $INSTDIR $R0
  Goto end
  no:
  StrCpy $INSTDIR "$PROGRAMFILES\Lineage II"
  end:
FunctionEnd

Function Background
  SetOutPath $TEMP\nephilimpack
  File glorydays.bmp
  StrCpy $Bg glorydays.bmp
  StrCpy $Text "Glory Days"
  CreateFont $R0 "Verdana" 30 650 /ITALIC
  BgImage::SetBg /NOUNLOAD /FILLSCREEN $Bg
  BgImage::AddText /NOUNLOAD $Text $R0 255 255 255 48 48 798 198
  BgImage::Redraw /NOUNLOAD
FunctionEnd


Function .onInstFailed
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "Le Nephilim Pack a rencontré un problème. Voulez-vous consulter l'aide en ligne pour trouver une solution ?" IDYES 0 IDNO +2
  ExecShell "open" "http://nephilim.melua.fr/Support"
  RMDir /r /REBOOTOK $TEMP\nephilimpack
FunctionEnd

Function .onInstSuccess
 SectionGetFlags ${Damages} $R0
 ${If} $R0 != ${SF_SELECTED}
 WriteINIStr $INSTDIR\system\version.ini options damages false
 ${EndIf}
 SectionGetFlags ${Localization} $R1
 ${If} $R1 != ${SF_SELECTED}
 WriteINIStr $INSTDIR\system\version.ini options language default
 ${EndIf}
 SectionGetFlags ${Dev} $R2
 ${If} $R2 != ${SF_SELECTED}
 CopyFiles $INSTDIR\system\enc-english\l2.bak $INSTDIR\system\l2.ini
 WriteINIStr $INSTDIR\system\version.ini options devtools false
 ${EndIf}
 RMDir /r /REBOOTOK $TEMP\nephilimpack
FunctionEnd

; Vérification de l'existence de Lineage II
Function .onVerifyInstDir
  IfFileExists $INSTDIR\system\l2.ini PathGood
  Abort ; si $INSTDIR n'est pas un répertoire Lineage II, ne laissez rien installer dedans
  PathGood:
FunctionEnd

; Vérification de la connexion
Function Connectivite
  Push $R0
  Dialer::GetConnectedState
  Pop $R0
  StrCpy $ConnectedState $R0
  StrCmp $ConnectedState "online" 0 +3
  NSISdl::download ${SERVEUR}${CLIENT}/extra/version.ini $TEMP\nephilimpack\version.ini
  Goto end
  MessageBox MB_OK|MB_ICONINFORMATION "Vous n'êtes pas connecté à internet !$\nCertaines options ne seront pas disponibles."
  !insertmacro UnselectSection ${Traduction}
  !insertmacro SetSectionFlag ${Traduction} ${SF_RO}
  !insertmacro SetSectionFlag ${Accents} ${SF_RO}
  !insertmacro SetSectionFlag ${NakedA1} ${SF_RO}
  !insertmacro SetSectionFlag ${NakedA2} ${SF_RO}
  !insertmacro SetSectionFlag ${NakedU} ${SF_RO}
  !insertmacro SetSectionFlag ${Dezoom} ${SF_RO}
  !insertmacro SetSectionFlag ${NakedB} ${SF_RO}
  !insertmacro SetSectionFlag ${Oggpatcher} ${SF_RO}
  !insertmacro SetSectionFlag ${WildCard} ${SF_RO}
  !insertmacro SetSectionFlag ${ShowLevel} ${SF_RO}
  !insertmacro SetSectionFlag ${HdrGlow} ${SF_RO}
  !insertmacro UnselectSection ${Damages}
  !insertmacro SetSectionFlag ${Damages} ${SF_RO}
  !insertmacro UnselectSection ${Dev}
  !insertmacro SetSectionFlag ${Dev} ${SF_RO}
  !insertmacro UnselectSection ${umodel}
  !insertmacro SetSectionFlag ${umodel} ${SF_RO}
  !insertmacro UnselectSection ${lsa}
  !insertmacro SetSectionFlag ${lsa} ${SF_RO}
  end:
FunctionEnd

Function Options
  ReadINIStr $Damages $INSTDIR\system\version.ini options damages
  ${If} $Damages == true
  !insertmacro SelectSection ${Damages}
  ${EndIf}
  ReadINIStr $l2language $INSTDIR\system\version.ini options language
  ${If} $l2language == "english"
  !insertmacro SelectSection ${Localization}
  ${ElseIf} $l2language == "french"
  !insertmacro SelectSection ${Localization}
  ${EndIf}
  ReadINIStr $isDev $INSTDIR\system\version.ini options devtools
  ${If} $isDev == true
  !insertmacro SelectSection ${Dev}
  ${EndIf}
  ReadINIStr $proposal $INSTDIR\system\version.ini options proposal
  ${If} $proposal == false
  !insertmacro UnselectSection ${upgrade}
  ${EndIf}
  ${If} ${CLIENT} == "GD2.5"
  !insertmacro SetSectionFlag ${Accents} ${SF_RO} ; accents ne fonctionnent plus
  !insertmacro SetSectionFlag ${Dezoom} ${SF_RO} ; dezoom ne fonctionne pas
  !insertmacro SetSectionFlag ${NakedA1} ${SF_RO} ; nudite totale ne fonctionne pas
  !insertmacro SetSectionFlag ${NakedA2} ${SF_RO} ; nudite accessoire ne fonctionne pas
  !insertmacro SetSectionFlag ${NakedU} ${SF_RO} ; nudite bikini ne fonctionne pas
  !insertmacro SetSectionFlag ${Naked0} ${SF_RO} ; nudite non modifiee
  !insertmacro SetSectionFlag ${NakedB} ${SF_RO} ; armures sexy ne fonctionne pas
  !insertmacro SetSectionFlag ${ShowLevel} ${SF_RO} ; level des monstres ne fonctionne pas
  !insertmacro SetSectionFlag ${HdrGlow} ${SF_RO} ; hdr glow ne fonctionne pas
  !insertmacro UnselectSection ${Wildcard}
  !insertmacro SetSectionFlag ${Wildcard} ${SF_RO} ; wildcard ne fonctionne pas
  ${EndIf}
FunctionEnd

; récupérer la date
Function GetLocalTime
  Push $0
  Push $1
  Push $2
  Push $3
  Push $4
  Push $5
  Push $6
  System::Call '*(&i2, &i2, &i2, &i2, &i2, &i2, &i2, &i2) i .r0'
  System::Call 'kernel32::GetLocalTime(i) i(r0)'
  System::Call '*$0(&i2, &i2, &i2, &i2, &i2, &i2, &i2, &i2)i \
  (.r4, .r5, .r3, .r6, .r2, .r1, .r0,)'
  StrCmp $3 0 0 +3
  StrCpy $3 Dimanche
  Goto WeekNameEnd
  StrCmp $3 1 0 +3
  StrCpy $3 Lundi
  Goto WeekNameEnd
  StrCmp $3 2 0 +3
  StrCpy $3 Mardi
  Goto WeekNameEnd
  StrCmp $3 3 0 +3
  StrCpy $3 Mercredi
  Goto WeekNameEnd
  StrCmp $3 4 0 +3
  StrCpy $3 Jeudi
  Goto WeekNameEnd
  StrCmp $3 5 0 +3
  StrCpy $3 Vendredi
  Goto WeekNameEnd
  StrCmp $3 6 0 +2
  StrCpy $3 Samedi
  WeekNameEnd:
  IntCmp $1 9 0 0 +2
  StrCpy $1 '0$1'
  IntCmp $0 9 0 0 +2
  StrCpy $0 '0$0'
  Exch $6
  Exch
  Exch $5
  Exch
  Exch 2
  Exch $4
  Exch 2
  Exch 3
  Exch $3
  Exch 3
  Exch 4
  Exch $2
  Exch 4
  Exch 5
  Exch $1
  Exch 5
  Exch 6
  Exch $0
  Exch 6
FunctionEnd

Function "Statistics"
  IfFileExists $INSTDIR\system\enc-english\*.* 0 +2
  ExecShell "open" "http://nephilim.melua.fr/compteur.php"
FunctionEnd

Function "recapitulatif"
; répertoire
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "Répertoire de Lineage II :"
IfFileExists $INSTDIR\system\loader.exe patched 0
IfFileExists $INSTDIR\system\loaderCT1++.exe patched 0
IfFileExists $INSTDIR\system\loaderCT2.exe patched nonpatched
nonpatched:
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " $INSTDIR (client original)"
Goto end1
patched:
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " $INSTDIR (client déjà patché)"
end1:

; dépot & revision
ReadINIStr $REV $TEMP\nephilimpack\version.ini nephilimpack revision
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "Dépôt du Nephilim Pack :"
IfFileExists $INSTDIR\system\enc-english\*.dat update install
install:
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " ${SERVEUR}${CLIENT} (première installation revision $REV)"
Goto end2
update:
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " ${SERVEUR}${CLIENT} (mise à jour vers la revision $REV)"
end2:

; avertissements
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "Avertissements :"
SectionGetFlags ${Traduction} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " Utilisez le raccourci Lineage 2 sur le Bureau pour vérifier les mises à jour et lancer le jeu."
SectionGetFlags ${Patchage} $R0
${ElseIf} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " Utilisez le fichier $INSTDIR\system\loaderCT1++.exe pour lancer le jeu."
${EndIf}
SectionGetFlags ${Accents} $R0
${If} $R0 == ${SF_SELECTED}
var /GLOBAL MajorVersion
var /GLOBAL MinorVersion
var /GLOBAL BuildNumber
var /GLOBAL PlatformID ; needed
var /GLOBAL CSDVersion  
Version::GetWindowsVersion ; MS Windows version $MajorVersion.$MinorVersion (build $BuildNumber) $CSDVersion
Pop $MajorVersion
Pop $MinorVersion
Pop $BuildNumber
Pop $PlatformID ; needed
Pop $CSDVersion
IntCmp $BuildNumber "6000" 0 end3 0 ; val1 val2 saut_si_egal [saut_si_val1_inf] [saut_si_val1_sup]
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " Vous utilisez Vista/Seven, dans de rares cas les accents peuvent ne pas fonctionner,"
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " si votre client ne démarre plus, utilisez la désinstallation partielle puis réinstallez."
end3:
${EndIf}

; composants
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "Composants choisis :"
SectionGetFlags ${Desinstaller} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " DESINSTALLATION PARTIELLE (le client reste patché)"
${EndIf}
SectionGetFlags ${Depatcher} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " DESINSTALLATION COMPLETE (le client sera dépatché)"
${EndIf}
SectionGetFlags ${Patchage} $R0
${If} $R0 == ${SF_SELECTED}
IfFileExists $INSTDIR\system\loader.exe already 0
IfFileExists $INSTDIR\system\loaderCT1++.exe already 0
IfFileExists $INSTDIR\system\loaderCT2.exe already 0
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Patchage"
already:
${EndIf}
SectionGetFlags ${Traduction} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Traduction colorée"
${EndIf}
SectionGetFlags ${Accents} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Support Accents"
${EndIf}
SectionGetFlags ${NakedA1} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Nudité totale"
${EndIf}
SectionGetFlags ${NakedA2} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Nudité accessoires"
${EndIf}
SectionGetFlags ${NakedU} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Nudité bikini"
${EndIf}
SectionGetFlags ${Dezoom} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Dezoom maximum"
${EndIf}
SectionGetFlags ${Censure} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Désactiver censure"
${EndIf}
SectionGetFlags ${NakedB} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Tenues sexy"
${EndIf}
SectionGetFlags ${Oggpatcher} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Décoder la musique"
${EndIf}
SectionGetFlags ${Wildcard} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Inactiver GameGuard"
${EndIf}
SectionGetFlags ${ShowLevel} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Level des monstres"
${EndIf}
SectionGetFlags ${HdrGlow} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - HDR Glow"
${EndIf}
SectionGetFlags ${Damages} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Dégats plein écran"
${EndIf}
SectionGetFlags ${Localization} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Choix de la langue"
${EndIf}
SectionGetFlags ${Dev} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Console développeur"
${EndIf}
SectionGetFlags ${Umodel} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Unreal Model Viewer"
${EndIf}
SectionGetFlags ${LSA} $R0
${If} $R0 == ${SF_SELECTED}
!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE " - Changer le port LSA"
${EndIf}

FunctionEnd

; #################### DEPENDANCES ET CONFLITS #####################

Function .onSelChange
  ; Nudité 1 seul choix possible
  !insertmacro StartRadioButtons $1
  !insertmacro RadioButton ${Naked0}
  !insertmacro RadioButton ${NakedA1}
  !insertmacro RadioButton ${NakedA2}
  !insertmacro RadioButton ${NakedU}
  !insertmacro RadioButton ${Desinstaller}
  !insertmacro RadioButton ${Depatcher}
  !insertmacro EndRadioButtons
  
  ; Dépendance avec Patchage
  SectionGetFlags ${Traduction} $R0
  ${If} $R0 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${Accents} $R1
  ${If} $R1 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${NakedA1} $R2
  ${If} $R2 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${NakedA2} $R3
  ${If} $R3 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${NakedU} $R4
  ${If} $R4 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${Dezoom} $R5
  ${If} $R5 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${NakedB} $R6
  ${If} $R6 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${ShowLevel} $R8
  ${If} $R8 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${Damages} $R9
  ${If} $R9 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  ${EndIf}
  SectionGetFlags ${Depatcher} $R0
  ${If} $R0 == ${SF_SELECTED}
  !insertmacro UnselectSection ${Upgrade}
  !insertmacro UnselectSection ${Localization}
  ${EndIf}
  SectionGetFlags ${Desinstaller} $R1
  ${If} $R1 == ${SF_SELECTED}
  !insertmacro UnselectSection ${Upgrade}
  !insertmacro UnselectSection ${Localization}
  ${EndIf}
  SectionGetFlags ${Localization} $R2
  ${If} $R2 == ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Patchage} ${SF_SELECTED}
  !insertmacro SetSectionFlag ${Traduction} ${SF_SELECTED}
  ${EndIf}
FunctionEnd

; ===============================  DESCRIPTIONS  ===============================

; Textes
LangString DESC_Patchage ${LANG_ENGLISH} "Le patcheur élaboré par Soltys de dstuff.luftbrandzlung.org permet décoder les fichiers system de Lineage II."
LangString DESC_Traduction ${LANG_ENGLISH} "La traduction effectuée par l'équipe du projet Nephilim Pack. Certains messages importants sont mis en valeur par la couleur."
LangString DESC_Accents ${LANG_ENGLISH} "Cette modificaton élaborée par Fyyre de fyyre.ivory-tower.de vous permet d'utiliser les accents dans Lineage II."
LangString DESC_Naked0 ${LANG_ENGLISH} "Si vous ne souhaitez pas modifier la nudité actuelle, cochez impérativement ce choix."
LangString DESC_NakedA1 ${LANG_ENGLISH} "Les personnages féminins sans équipement apparaissent totalement nus. Les personnages masculins sans équipement apparaissent torse nu. La nudité n'est visible que sur votre client."
LangString DESC_NakedA2 ${LANG_ENGLISH} "Les personnages féminins sans équipement apparaissent vêtus de lingerie sexy. Les personnages masculins sans équipement apparaissent torse nu. La nudité n'est visible que sur votre client."
LangString DESC_NakedU ${LANG_ENGLISH} "Les personnages féminins sans équipement apparaissent en bikini. Les personnages masculins sans équipement apparaissent torse nu. La nudité n'est visible que sur votre client."
LangString DESC_Dezoom ${LANG_ENGLISH} "Cette modification élaborée par Soltys de dstuff.luftbrandzlung.org augmente le recul et l'avancée de la caméra."
LangString DESC_Censure ${LANG_ENGLISH} "Retire la censure officielle dans les channels."
LangString DESC_NakedB ${LANG_ENGLISH} "Certaines tenues dévoilent les atouts féminins."
LangString DESC_Oggpatcher ${LANG_ENGLISH} "Ce décodeur élaboré par Soltys de dstuff.luftbrandzlung.org rend possible la lecture des musiques au format OGG de Lineage II dans un lecteur adéquat comme VLC."
LangString DESC_Wildcard ${LANG_ENGLISH} "Cette modification élaborée par Fyyre de fyyre.ivory-tower.de désactive le rootkit nProtect GameGuard. Attention certains serveurs ne permettent pas de jouer sans. Informez-vous auprès de votre serveur."
LangString DESC_ShowLevel ${LANG_ENGLISH} "Permet d'afficher le niveau et l'aggressivité de la plupart des NPCs lorsque le serveur ne le fait pas. Données basées sur l2jdb.l2jdp.com des NPCs peuvent ne pas être encore répertoriés."
LangString DESC_HdrGlow ${LANG_ENGLISH} "Cette exclusivité du Nephilim Pack permet d'ajouter l'effet Glow aux rendus HDR B et HDR C."
LangString DESC_Damages ${LANG_ENGLISH} "Cette exclusivité du Nephilim Pack permet d'afficher en plein écran les dégâts infligés par votre personnage et votre monstre invoqué."
LangString DESC_Localization ${LANG_ENGLISH} "Cette option offre la possibilité de mettre Lineage II en anglais ou en francais via le fichier version.ini ; vous devez utiliser le loaderNP à chaque changement pour rendre effectif la modification de ce paramètre."
LangString DESC_Dev ${LANG_ENGLISH} "Toogle de la console développeur. Cochez pour activer, décochez pour désactiver. Des tutoriels sur son utilisation sont disponibles sur internet."
LangString DESC_Umodel ${LANG_ENGLISH} "Une interface graphique simplifiée pour le Unreal Model Viewer de www.gildor.com"
LangString DESC_LSA ${LANG_ENGLISH} "Ce programme élaboré par GoldFinch permet de modifier le port d'authentification de Lineage II. Ne pas utiliser si vous ne savez pas ce que vous faites."

; Liaison vers les textes
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Patchage} $(DESC_Patchage)
  !insertmacro MUI_DESCRIPTION_TEXT ${Traduction} $(DESC_Traduction)
  !insertmacro MUI_DESCRIPTION_TEXT ${Accents} $(DESC_Accents)
  !insertmacro MUI_DESCRIPTION_TEXT ${Naked0} $(DESC_Naked0)
  !insertmacro MUI_DESCRIPTION_TEXT ${NakedA1} $(DESC_NakedA1)
  !insertmacro MUI_DESCRIPTION_TEXT ${NakedA2} $(DESC_NakedA2)
  !insertmacro MUI_DESCRIPTION_TEXT ${NakedU} $(DESC_NakedU)
  !insertmacro MUI_DESCRIPTION_TEXT ${Dezoom} $(DESC_Dezoom)
  !insertmacro MUI_DESCRIPTION_TEXT ${Censure} $(DESC_Censure)
  !insertmacro MUI_DESCRIPTION_TEXT ${NakedB} $(DESC_NakedB)
  !insertmacro MUI_DESCRIPTION_TEXT ${Oggpatcher} $(DESC_Oggpatcher)
  !insertmacro MUI_DESCRIPTION_TEXT ${Wildcard} $(DESC_Wildcard)
  !insertmacro MUI_DESCRIPTION_TEXT ${ShowLevel} $(DESC_ShowLevel)
  !insertmacro MUI_DESCRIPTION_TEXT ${HdrGlow} $(DESC_HdrGlow)
  !insertmacro MUI_DESCRIPTION_TEXT ${Damages} $(DESC_Damages)
  !insertmacro MUI_DESCRIPTION_TEXT ${Localization} $(DESC_Localization)
  !insertmacro MUI_DESCRIPTION_TEXT ${Dev} $(DESC_Dev)
  !insertmacro MUI_DESCRIPTION_TEXT ${Umodel} $(DESC_Umodel)
  !insertmacro MUI_DESCRIPTION_TEXT ${LSA} $(DESC_LSA)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; THAT'S ALL FOLKS !!!