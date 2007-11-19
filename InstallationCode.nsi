;--------------------------------
;Installer Sections


Section # MainSection

  SetOutPath "$INSTDIR"
  
  ;Store installation folder
  WriteRegStr HKLM "Software\CortUI" "InstallDir" $INSTDIR
  
  ;Create uninstaller
  CreateDirectory "$INSTDIR\mods\CortUI\"
  WriteUninstaller "$INSTDIR\mods\CortUI\Uninstall.exe"

  ;Create uninstaller in Add/Remove Programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "DisplayName" "Allegiance CortUI"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "UninstallString" '"$INSTDIR\mods\CortUI\Uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "NoModify" "1"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "NoRepair" "1"

#  DetailPrint "=== before BackupCoreFiles"
  Call backupCoreFiles
#  DetailPrint "=== after BackupCoreFiles"

SectionEnd

Section "${SECTIONTITLE_CORTUI}" SECIDX_CORTUI

#  DetailPrint "=== starting CortUI Installation"

  Push $OUTDIR
  StrCpy $OUTDIR "$OUTDIR\mods\CortUI"
  File Media\*
  File "# Release Notes.txt"
  Pop $OUTDIR
  File Code\dialog.mdl
  File Code\loadoutpane.mdl
  File Code\missionbrief.mdl
  File Code\partinfo.mdl
  File Code\cortui_settings.mdl

  StrCpy $IsCortuiSelected "true"

  !insertmacro MUI_INSTALLOPTIONS_READ $isLobbyScreenSelected "ConfigurationScreen.ini" "${FIELD_INSTALLLOBBY}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $isHangarScreenSelected "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsNumChatLinesGlobal "ConfigurationScreen.ini" "${FIELD_CHATLINESGLOBAL}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsNumChatLinesLoadout "ConfigurationScreen.ini" "${FIELD_CHATLINESLOADOUT}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsAlwaysShowLoadoutWindow "ConfigurationScreen.ini" "${FIELD_SHOWLOADOUT}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsShowMinimapAtLoadoutScreen "ConfigurationScreen.ini" "${FIELD_SHOWMINIMAP}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsShowLastOrders "ConfigurationScreen.ini" "${FIELD_SHOWORDERS}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsShowScrollbar "ConfigurationScreen.ini" "${FIELD_SHOWSCROLLBAR}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsNormalHUDModeText "ConfigurationScreen.ini" "${FIELD_NORMALHUDMODE}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsSoftwareHUDModeText "ConfigurationScreen.ini" "${FIELD_SOFTWAREHUDMODE}" "State"

  StrCpy $settingsNormalHUDMode "0"
  StrCmp $settingsNormalHUDModeText "Classic CortUI" 0 +2
    StrCpy $settingsNormalHUDMode "0"
  StrCmp $settingsNormalHUDModeText "lessHUD - by FlingPu" 0 +2
    StrCpy $settingsNormalHUDMode "1"
  StrCmp $settingsNormalHUDModeText "JelloShot - by FlingPu" 0 +2
    StrCpy $settingsNormalHUDMode "2"

  StrCpy $settingsSoftwareHUDMode "0"
  StrCmp $settingsSoftwareHUDModeText "Default Software HUD" 0 +2
    StrCpy $settingsSoftwareHUDMode "0"
  StrCmp $settingsSoftwareHUDModeText "Default Software HUD with targeting view" 0 +2
    StrCpy $settingsSoftwareHUDMode "1"
  StrCmp $settingsSoftwareHUDModeText "Modified Software HUD ('Raveen-style')" 0 +2
    StrCpy $settingsSoftwareHUDMode "2"
  StrCmp $settingsSoftwareHUDModeText "Modified Software HUD ('Parci-style')" 0 +2
    StrCpy $settingsSoftwareHUDMode "3"

	!ifdef DEBUG
		MessageBox MB_ICONINFORMATION|MB_OK "isLobbyScreenSelected: $isLobbyScreenSelected"
		MessageBox MB_ICONINFORMATION|MB_OK "isHangarScreenSelected: $isHangarScreenSelected"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsNumChatLinesGlobal: $settingsNumChatLinesGlobal"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsNumChatLinesLoadout: $settingsNumChatLinesLoadout"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsAlwaysShowLoadoutWindow: $settingsAlwaysShowLoadoutWindow"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsShowMinimapAtLoadoutScreen: $settingsShowMinimapAtLoadoutScreen"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsShowLastOrders: $settingsShowLastOrders"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsShowScrollbar: $settingsShowScrollbar"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsSoftwareHUDMode: $settingsSoftwareHUDMode"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsNormalHUDMode: $settingsNormalHUDModeText"
	!endif

  StrCpy $settingsNumChatLinesLobby "6"
  StrCmp $isLobbyScreenSelected "0" dontInstallLobbyScreen 0
    File Code\teamscreen.mdl
    StrCpy $settingsNumChatLinesLobby "10"
  dontInstallLobbyScreen:

  StrCmp $isHangarScreenSelected "0" dontInstallHangarScreen 0
    File Code\hangar.mdl
  dontInstallHangarScreen:

  StrCpy $settingsFilename "$INSTDIR\cortui_settings.mdl"
  Call setSettings

  WriteRegStr HKLM "Software\CortUI" "isCortUIInstalled" "1"

SectionEnd



Function .onInit
#MessageBox MB_OK "init"

#  InitPluginsDir
#  File ConfigurationScreen.ini
#  File ConfigurationScreen.ini
#  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "Welcome.ini"
  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "ConfigurationScreen.ini"

  SectionSetSize ${SECIDX_CORTUI} 2520
#  SectionSetSize ${SECIDX_SLIPSTREAMGUI} 249

FunctionEnd


Function readSectionFlags
	StrCpy $shallInstallCortUI false
	!insertmacro SectionFlagIsSet ${SECIDX_CORTUI} ${SF_SELECTED} 0 dont
		StrCpy $shallInstallCortUI true
	dont:

#	StrCpy $shallInstallSlipstreamGUI false
#	!insertmacro SectionFlagIsSet ${SECIDX_SLIPSTREAMGUI} ${SF_SELECTED} 0 dont2
#		StrCpy $shallInstallSlipstreamGUI true
#	dont2:

#	!ifdef DEBUG
#		MessageBox MB_OK "shallInstallCortUI: $shallInstallCortUI"
#		MessageBox MB_OK "shallInstallSlipstreamGUI: $shallInstallSlipstreamGUI"
#	!endif
FunctionEnd



Function cbLeaveComponentsPage
#  SectionGetFlags SECIDX_SLIPSTREAM $0
#  MessageBox MB_OK "cbLeaveComponentsPage: $0"
#  Abort

	Call readSectionFlags

	StrCmp $shallInstallCortUI true atLeastOneSelected
        MessageBox MB_ICONSTOP|MB_OK "You need to select CortUI to proceed."
        Abort
	atLeastOneSelected:

	tryagainCheckProcess:
		FindProcDLL::FindProc "Allegiance.exe"
		IntCmp $R0 0 endCheckProcess
		IntCmp $R0 1 allegProcessFound allegProcessGeneralError

	allegProcessFound:
		MessageBox MB_ABORTRETRYIGNORE|MB_ICONSTOP|MB_DEFBUTTON2 "Allegiance seems to be running. CortUI can *not* be installed while Allegiance is running! Please close Allegiance and retry."IDIGNORE endCheckProcess IDRETRY tryagainCheckProcess
		Abort

	allegProcessGeneralError:
		MessageBox MB_ABORTRETRYIGNORE|MB_ICONSTOP|MB_DEFBUTTON2 "An error occured while trying to check whether the Allegiance process is running. CortUI can *not* be installed while Allegiance is running!"IDIGNORE endCheckProcess IDRETRY tryagainCheckProcess
		Abort

	endCheckProcess:
FunctionEnd



Function cbPreFinishPage
	StrCmp $shallInstallCortUI true dontSkip
		Abort
	dontSkip:
FunctionEnd



Function openConfigurationScreen
#MessageBox MB_OK "openConfigurationScreen"

	Call readSectionFlags

	StrCmp $shallInstallCortUI true dontSkipConfigurationScreen
		Abort
	dontSkipConfigurationScreen:

	!insertmacro MUI_HEADER_TEXT "Customize Options" "Set custom options for your CortUI."
	!insertmacro MUI_INSTALLOPTIONS_DISPLAY "ConfigurationScreen.ini"

FunctionEnd
