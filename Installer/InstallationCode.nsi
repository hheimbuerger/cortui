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

		# Read the options the user selected on the Configuration page
		!insertmacro INSTALLOPTIONS_READ $isLobbyScreenSelected ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_INSTALLLOBBY}" "State"
		!insertmacro INSTALLOPTIONS_READ $isHangarScreenSelected ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_INSTALLHANGAR}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsNumChatLinesGlobal ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_CHATLINESGLOBAL}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsNumChatLinesLoadout ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_CHATLINESLOADOUT}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsAlwaysShowLoadoutWindow ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_SHOWLOADOUT}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsShowMinimapAtLoadoutScreen ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_SHOWMINIMAP}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsShowLastOrders ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_SHOWORDERS}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsShowScrollbar ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_SHOWSCROLLBAR}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsNormalHUDModeText ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_NORMALHUDMODE}" "State"
		!insertmacro INSTALLOPTIONS_READ $settingsSoftwareHUDModeText ${INSTALLOPTIONS_TEMP_FILE} "${FIELD_SOFTWAREHUDMODE}" "State"

		# Determine which normal HUD to use and set settingsNormalHUDMode accordingly
		StrCpy $settingsNormalHUDMode "0"
		StrCmp $settingsNormalHUDModeText "Classic CortUI" 0 +2
		StrCpy $settingsNormalHUDMode "0"
		StrCmp $settingsNormalHUDModeText "lessHUD (by FlingPu)" 0 +2
		StrCpy $settingsNormalHUDMode "1"
		StrCmp $settingsNormalHUDModeText "JelloShot (by FlingPu)" 0 +2
		StrCpy $settingsNormalHUDMode "2"
		StrCmp $settingsNormalHUDModeText "GlassHUD (by Bunnywabbit)" 0 +2
		StrCpy $settingsNormalHUDMode "3"

		# Determine which software HUD to use and set settingsNormalHUDMode accordingly
		StrCpy $settingsSoftwareHUDMode "0"
		StrCmp $settingsSoftwareHUDModeText "Default Software HUD" 0 +2
		StrCpy $settingsSoftwareHUDMode "0"
		StrCmp $settingsSoftwareHUDModeText "Default Software HUD with targeting view" 0 +2
		StrCpy $settingsSoftwareHUDMode "1"
		StrCmp $settingsSoftwareHUDModeText "Modified Software HUD ('Raveen-style')" 0 +2
		StrCpy $settingsSoftwareHUDMode "2"
		StrCmp $settingsSoftwareHUDModeText "Modified Software HUD ('Parci-style')" 0 +2
		StrCpy $settingsSoftwareHUDMode "3"

		# When in DEBUG mode, show some message boxes about which settings were read
		;;; !ifdef DEBUG
		;;; MessageBox MB_ICONINFORMATION|MB_OK "isLobbyScreenSelected: $isLobbyScreenSelected"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "isHangarScreenSelected: $isHangarScreenSelected"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsNumChatLinesGlobal: $settingsNumChatLinesGlobal"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsNumChatLinesLoadout: $settingsNumChatLinesLoadout"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsAlwaysShowLoadoutWindow: $settingsAlwaysShowLoadoutWindow"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsShowMinimapAtLoadoutScreen: $settingsShowMinimapAtLoadoutScreen"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsShowLastOrders: $settingsShowLastOrders"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsShowScrollbar: $settingsShowScrollbar"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsSoftwareHUDMode: $settingsSoftwareHUDMode"
		;;; MessageBox MB_ICONINFORMATION|MB_OK "settingsNormalHUDMode: $settingsNormalHUDModeText"
		;;; !endif

		# Install the lobby modification if it was requested
		StrCpy $settingsNumChatLinesLobby "6"
		StrCmp $isLobbyScreenSelected "0" dontInstallLobbyScreen 0
		File Code\teamscreen.mdl
		StrCpy $settingsNumChatLinesLobby "10"
		Goto endInstallLobbyScreen
		dontInstallLobbyScreen:
		File unCode\teamscreen.mdl
		endInstallLobbyScreen:

		# Install the hangar modification if it was requested
		StrCmp $isHangarScreenSelected "0" dontInstallHangarScreen 0
		File Code\hangar.mdl
		Goto endInstallHangarScreen
		dontInstallHangarScreen:
		File unCode\hangar.mdl
		endInstallHangarScreen:

		# Copy the cortui_settings.mdl template and set the other settings in there
		StrCpy $settingsFilename "$INSTDIR\cortui_settings.mdl"
		Call setSettings

		# Take note of the installation in the registry
		WriteRegStr HKLM "${REGKEY_CORTUI}" "${REGNAME_CORTUI_VERSION}" "${VERSION}"
	SectionEnd


;--------------------------------
; Prepare the configuration page

	Function .onInit
		!insertmacro INSTALLOPTIONS_EXTRACT_AS ${INSTALLOPTIONS_INI_FILE} ${INSTALLOPTIONS_TEMP_FILE}
	FunctionEnd


;--------------------------------
; Event handler for opening the configuration page

	Function openConfigurationScreen
		# Set the title and subtitle of the configuration page
		!insertmacro MUI_HEADER_TEXT "${CONFIGURATION_PAGE_TITLE}" "${CONFIGURATION_PAGE_SUBTITLE}"
		
		# Show the configuration page
		!insertmacro INSTALLOPTIONS_DISPLAY "${INSTALLOPTIONS_TEMP_FILE}"
	FunctionEnd


;--------------------------------
; Descriptions

	# Assign language strings to sections
	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SECIDX_CORTUI} "${SECTIONDESC_CORTUI}"
	!insertmacro MUI_FUNCTION_DESCRIPTION_END
