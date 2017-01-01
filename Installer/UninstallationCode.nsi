;--------------------------------
; General section -- this will be done first

Section -un.Uninstall
	# Make this section mandatory
	SectionIn RO

	ReadRegStr $INSTDIR HKLM "Software\CortUI" "InstallDir"
	StrCpy $OUTDIR $INSTDIR
SectionEnd


;--------------------------------
; Remove CortUI -- this will be done if the user has selected that option

Section /o "${SECTIONTITLE_UN_CORTUI}" UN_SECIDX_CORTUI
  	File unCode\*
  	Delete "$INSTDIR\gh_*.mdl"
    Delete "$INSTDIR\cortui_settings.mdl"
    RMDir /r "$INSTDIR\mods\CortUI\media"
    Delete "$INSTDIR\mods\CortUI\# Release Notes.txt"
SectionEnd


;--------------------------------
; Remove backups -- this will be done if the user has selected that option

Section /o "${SECTIONTITLE_UN_REMOVEBACKUPS}" UN_SECIDX_REMOVEBACKUPS
  	StrCpy $0 "$INSTDIR\mods\CortUI"
	Call un.RemoveBackupDirectories
SectionEnd


;--------------------------------
; Remove uninstaller -- this will be done if the user has selected that option

Section "${SECTIONTITLE_UN_REMOVEUNINSTALLER}" UN_SECIDX_REMOVEUNINSTALLER
    Delete "$INSTDIR\mods\CortUI\Uninstall.exe"
    DeleteRegKey HKLM "${REGKEY_CORTUI}"
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CortUI"
SectionEnd


;--------------------------------
; General section -- this will be done last

Section -un.Uninstall
	RMDir "$INSTDIR\mods\CortUI"
SectionEnd


;--------------------------------
; Initialization function -- checks whether CortUI is really installed

Function un.onInit
	Var /GLOBAL isCortUIInstalled
	ReadRegStr $isCortUIInstalled HKLM "${REGKEY_CORTUI}" "${REGNAME_CORTUI_VERSION}"
	StrCmp $isCortUIInstalled "" dont 0
		!insertmacro SetSectionFlag ${UN_SECIDX_CORTUI} ${SF_SELECTED}
	dont:
FunctionEnd


;--------------------------------
; Descriptions

  !insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_CORTUI} "${SECTIONDESC_UN_CORTUI}"
    !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_REMOVEBACKUPS} "${SECTIONDESC_UN_REMOVEBACKUPS}"
    !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_REMOVEUNINSTALLER} "${SECTIONDESC_UN_REMOVEUNINSTALLER}"
  !insertmacro MUI_UNFUNCTION_DESCRIPTION_END
