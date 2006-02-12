Section -un.Uninstall

  ReadRegStr $INSTDIR HKLM "Software\CortUI" "InstallDir"
#  ReadRegStr $isSlipstreamInstalled HKLM "Software\CortUI" "isSlipstreamInstalled"
#  ReadRegStr $isCortUIInstalled HKLM "Software\CortUI" "isCortUIInstalled"
#MessageBox MB_ICONEXCLAMATION|MB_OK "INSTDIR: $INSTDIR"
#MessageBox MB_ICONEXCLAMATION|MB_OK "OUTDIR: $OUTDIR"
  StrCpy $OUTDIR $INSTDIR

#  !insertmacro MUI_INSTALLOPTIONS_READ $R0 "UninstallerOptions.ini" "Field 1" "State"
#  !insertmacro MUI_INSTALLOPTIONS_READ $R1 "UninstallerOptions.ini" "Field 2" "State"
#  !insertmacro MUI_INSTALLOPTIONS_READ $R2 "UninstallerOptions.ini" "Field 3" "State"
#  !insertmacro MUI_INSTALLOPTIONS_READ $R3 "UninstallerOptions.ini" "Field 4" "State"

  Call un.backupCoreFiles

#  StrCmp $R0 "1" 0 dontUninstallCortUI
#  dontUninstallCortUI:

#  StrCmp $R1 "1" 0 dontUninstallSlipstream
#  dontUninstallSlipstream:

#  StrCmp $R2 "1" 0 dontRemoveBackups
#  dontRemoveBackups:

#  StrCmp $R3 "1" 0 dontRemoveUninstaller
#  dontRemoveUninstaller:

SectionEnd

Section /o "${SECTIONTITLE_UN_CORTUI}" UN_SECIDX_CORTUI
  	File unCortUI\*
    Delete "$INSTDIR\cortui_*.mdl"
    Delete "$INSTDIR\CortUI\# Release Notes.txt"
SectionEnd

Section /o "${SECTIONTITLE_UN_SLIPSTREAMGUI}" UN_SECIDX_SLIPSTREAMGUI
    !ifdef DEBUG
        File unSlipstream\arrowbmp.mdl
	!else
	  	File unSlipstream\*
	!endif
SectionEnd

Section /o "${SECTIONTITLE_UN_REMOVEBACKUPS}" UN_SECIDX_REMOVEBACKUPS
  	StrCpy $0 "$INSTDIR\CortUI"
	Call un.RemoveBackupDirectories
SectionEnd

Section "${SECTIONTITLE_UN_REMOVEUNINSTALLER}" UN_SECIDX_REMOVEUNINSTALLER
    Delete "$INSTDIR\CortUI\Uninstall.exe"
    DeleteRegKey HKLM "Software\CortUI"
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CortUI"
SectionEnd

Section -un.Uninstall
	!ifdef DEBUG
		MessageBox MB_OK "removing $INSTDIR\CortUI"
	!endif
	SetOutPath $TEMP
	RMDir "$INSTDIR\CortUI"
SectionEnd



Function un.onInit
#MessageBox MB_OK "un.init"

#  InitPluginsDir
#  File ConfigurationScreen.ini
#  File ConfigurationScreen.ini
  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "UninstallerWelcome.ini"
#  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "UninstallerOptions.ini"

	ReadRegStr $isCortUIInstalled HKLM "Software\CortUI" "isCortUIInstalled"
	ReadRegStr $isSlipstreamInstalled HKLM "Software\CortUI" "isSlipstreamInstalled"
	StrCmp $isCortUIInstalled "1" 0 dont
		!insertmacro SetSectionFlag ${UN_SECIDX_CORTUI} ${SF_SELECTED}
	dont:
	StrCmp $isSlipstreamInstalled "1" 0 dont2
		!insertmacro SetSectionFlag ${UN_SECIDX_SLIPSTREAMGUI} ${SF_SELECTED}
	dont2:

  SectionSetSize ${UN_SECIDX_CORTUI} 0
  SectionSetSize ${UN_SECIDX_SLIPSTREAMGUI} 0

FunctionEnd

#Function un.openUninstallerWelcome
#  #MessageBox MB_OK "openUninstallerWelcome"
#
#  !insertmacro MUI_HEADER_TEXT "Uninstaller" "Some general advices and warnings about the CortUI uninstaller."
#  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "UninstallerWelcome.ini"
#
#FunctionEnd

#Function un.openUninstallerOptions
#	#MessageBox MB_OK "openUninstallerOptions"
#	
#	!insertmacro MUI_HEADER_TEXT "Customize Uninstallation" "Select what you want to uninstall."
#	ReadRegStr $isCortUIInstalled HKLM "Software\CortUI" "isCortUIInstalled"
#	ReadRegStr $isSlipstreamInstalled HKLM "Software\CortUI" "isSlipstreamInstalled"
#	MessageBox MB_OK "isCortUIInstalled: $isCortUIInstalled"
#	MessageBox MB_OK "isSlipstreamInstalled: $isSlipstreamInstalled"
#	StrCmp $isCortUIInstalled "1" 0 +2
#		!insertmacro MUI_INSTALLOPTIONS_WRITE "UninstallerOptions.ini" "Field 1" "State" "1"
#	StrCmp $isSlipstreamInstalled "1" 0 +2
#		!insertmacro MUI_INSTALLOPTIONS_WRITE "UninstallerOptions.ini" "Field 2" "State" "1"
#	!insertmacro MUI_INSTALLOPTIONS_DISPLAY "UninstallerOptions.ini"
#
#FunctionEnd
