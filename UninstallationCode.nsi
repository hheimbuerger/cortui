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
  	File unCode\*
    Delete "$INSTDIR\cortui_settings.mdl"
    Delete "$INSTDIR\mods\CortUI\# Release Notes.txt"
SectionEnd

Section /o "${SECTIONTITLE_UN_REMOVEBACKUPS}" UN_SECIDX_REMOVEBACKUPS
  	StrCpy $0 "$INSTDIR\mods"
	Call un.RemoveBackupDirectories
SectionEnd

Section "${SECTIONTITLE_UN_REMOVEUNINSTALLER}" UN_SECIDX_REMOVEUNINSTALLER
    Delete "$INSTDIR\mods\CortUI\Uninstall.exe"
    DeleteRegKey HKLM "Software\CortUI"
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CortUI"
SectionEnd

Section -un.Uninstall
	!ifdef DEBUG
		MessageBox MB_OK "removing $INSTDIR\mods\CortUI"
	!endif
	SetOutPath $TEMP
	RMDir "$INSTDIR\mods\CortUI"
SectionEnd



Function un.onInit
	ReadRegStr $isCortUIInstalled HKLM "Software\CortUI" "isCortUIInstalled"
	StrCmp $isCortUIInstalled "1" 0 dont
		!insertmacro SetSectionFlag ${UN_SECIDX_CORTUI} ${SF_SELECTED}
	dont:

  SectionSetSize ${UN_SECIDX_CORTUI} 0

FunctionEnd
