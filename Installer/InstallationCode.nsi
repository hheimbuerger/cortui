;--------------------------------
; Main section -- this will be done first

	Section # MainSection
		SetOutPath "$INSTDIR"

		# Store installation folder
		WriteRegStr HKLM "${REGKEY_CORTUI}" "${REGNAME_CORTUI_INSTALLDIR}" "$INSTDIR"

		# Create directories
		CreateDirectory "$INSTDIR\mods\CortUI"
		CreateDirectory "$INSTDIR\mods\CortUI\media"

		# Create uninstaller
		WriteUninstaller "$INSTDIR\mods\CortUI\Uninstall.exe"

		# Create uninstaller in Add/Remove Programs
		WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "DisplayName" "Free Allegiance CortUI"
		WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "DisplayIcon" '"$INSTDIR\mods\CortUI\Uninstall.exe"'
		WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "UninstallString" '"$INSTDIR\mods\CortUI\Uninstall.exe"'
		WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "NoModify" "1"
		WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "NoRepair" "1"

		# Trigger a backup of the files we're going to overwrite
		Call backupCoreFiles

		# Determine the Allegiance directory so we can offer the user to start Allegiance automatically at the end of the installation
		ReadRegStr $allegiancePath HKLM "${REGKEY_ALLEG}" "${REGNAME_ALLEG_LOBBYPATH}"
	SectionEnd


;--------------------------------
; CortUI section -- this will be done next

	Section "${SECTIONTITLE_CORTUI}" SECIDX_CORTUI
		# Make this section mandatory
		SectionIn RO

		# Install all the CortUI core files
		Push $OUTDIR
		StrCpy $OUTDIR "$OUTDIR\mods\CortUI"
		File "# Release Notes.txt"            ; is going to $INSTDIR\mods\CortUI
		StrCpy $OUTDIR "$OUTDIR\media"
		File /r /x .git Media\*                          ; is going to $INSTDIR\mods\CortUI\media
		Pop $OUTDIR
		File /x teamscreen.mdl /x hangar.mdl Code\*.mdl

        # For now, we no longer allow configuration of these files and just assume defaults
		StrCpy $settingsNumChatLinesGlobal "10"
		StrCpy $settingsNumChatLinesLobby "6"
		StrCpy $settingsShowLastOrders "1"
		StrCpy $settingsShowScrollbar "1"

#		# Install the lobby modification if it was requested
#		StrCpy $settingsNumChatLinesLobby "6"
#		StrCmp $isLobbyScreenSelected "0" dontInstallLobbyScreen 0
#		File Code\teamscreen.mdl
#		StrCpy $settingsNumChatLinesLobby "10"
#		Goto endInstallLobbyScreen
#		dontInstallLobbyScreen:
#		File unCode\teamscreen.mdl
#		endInstallLobbyScreen:

		# Copy the cortui_settings.mdl template and set the other settings in there
		StrCpy $settingsFilename "$INSTDIR\cortui_settings.mdl"
		Call setSettings

		# Take note of the installation in the registry
		WriteRegStr HKLM "${REGKEY_CORTUI}" "${REGNAME_CORTUI_VERSION}" "${VERSION}"
	SectionEnd


;--------------------------------
; Descriptions

	# Assign language strings to sections
	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SECIDX_CORTUI} "${SECTIONDESC_CORTUI}"
	!insertmacro MUI_FUNCTION_DESCRIPTION_END
