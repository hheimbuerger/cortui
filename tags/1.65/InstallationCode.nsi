;--------------------------------
;Installer Sections


Section # MainSection

  SetOutPath "$INSTDIR"
  
  ;Store installation folder
  WriteRegStr HKLM "Software\CortUI" "InstallDir" $INSTDIR
  
  ;Create uninstaller
  CreateDirectory "$INSTDIR\CortUI\"
  WriteUninstaller "$INSTDIR\CortUI\Uninstall.exe"

  ;Create uninstaller in Add/Remove Programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "DisplayName" "Allegiance CortUI"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "UninstallString" '"$INSTDIR\CortUI\Uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "NoModify" "1"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CortUI" "NoRepair" "1"

#  DetailPrint "=== before BackupCoreFiles"
  Call backupCoreFiles
#  DetailPrint "=== after BackupCoreFiles"

SectionEnd

Section "${SECTIONTITLE_CORTUI}" SECIDX_CORTUI

#  DetailPrint "=== starting CortUI Installation"

  File CortUI_common\*
  Push $OUTDIR
  StrCpy $OUTDIR "$OUTDIR\CortUI"
  File "CortUI_main\# Release Notes.txt"
  Pop $OUTDIR
  File CortUI_main\dialog.mdl
  File CortUI_main\cortui_settings.mdl
  StrCpy $IsCortuiSelected "true"

  !insertmacro MUI_INSTALLOPTIONS_READ $isLobbyScreenSelected "ConfigurationScreen.ini" "${FIELD_INSTALLLOBBY}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $isHangarScreenSelected "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsNumChatLinesGlobal "ConfigurationScreen.ini" "${FIELD_CHATLINESGLOBAL}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsNumChatLinesLoadout "ConfigurationScreen.ini" "${FIELD_CHATLINESLOADOUT}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsAlwaysShowLoadoutWindow "ConfigurationScreen.ini" "${FIELD_SHOWLOADOUT}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsShowMinimapAtLoadoutScreen "ConfigurationScreen.ini" "${FIELD_SHOWMINIMAP}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsShowLastOrders "ConfigurationScreen.ini" "${FIELD_SHOWORDERS}" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $settingsShowScrollbar "ConfigurationScreen.ini" "${FIELD_SHOWSCROLLBAR}" "State"

	!ifdef DEBUG
		MessageBox MB_ICONINFORMATION|MB_OK "isLobbyScreenSelected: $isLobbyScreenSelected"
		MessageBox MB_ICONINFORMATION|MB_OK "isHangarScreenSelected: $isHangarScreenSelected"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsNumChatLinesGlobal: $settingsNumChatLinesGlobal"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsNumChatLinesLoadout: $settingsNumChatLinesLoadout"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsAlwaysShowLoadoutWindow: $settingsAlwaysShowLoadoutWindow"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsShowMinimapAtLoadoutScreen: $settingsShowMinimapAtLoadoutScreen"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsShowLastOrders: $settingsShowLastOrders"
		MessageBox MB_ICONINFORMATION|MB_OK "settingsShowScrollbar: $settingsShowScrollbar"
	!endif

  StrCpy $settingsNumChatLinesLobby "6"
  StrCmp $isLobbyScreenSelected "0" dontInstallLobbyScreen 0
    File CortUI_main\teamscreen.mdl
    StrCpy $settingsNumChatLinesLobby "10"
  dontInstallLobbyScreen:

  StrCmp $isHangarScreenSelected "0" dontInstallHangarScreen 0
    File CortUI_main\hangar.mdl
  dontInstallHangarScreen:

  StrCpy $settingsFilename "$INSTDIR\cortui_settings.mdl"
  Call setSettings

  WriteRegStr HKLM "Software\CortUI" "isCortUIInstalled" "1"

SectionEnd

Section /o "${SECTIONTITLE_SLIPSTREAMGUI}" SECIDX_SLIPSTREAMGUI

    !ifdef DEBUG
		File Slipstream\arrowbmp.mdl
	!else
    	File Slipstream\*
	!endif

	StrCpy $IsSlipstreamSelected "true"
	WriteRegStr HKLM "Software\CortUI" "isSlipstreamInstalled" "1"

SectionEnd

Section # Slipstream modified CortUI files

  StrCmp $IsCortuiSelected "true" 0 endoffunc
  StrCmp $IsSlipstreamSelected "true" yesSlipstream noSlipstream

  yesSlipstream:
    File CortUI_slipstream\*
    Goto endoffunc

  noSlipstream:
    File CortUI_only\*
    Goto endoffunc

  endoffunc:

SectionEnd



Function .onInit
#MessageBox MB_OK "init"

#  InitPluginsDir
#  File ConfigurationScreen.ini
#  File ConfigurationScreen.ini
  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "Welcome.ini"
  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "ConfigurationScreen.ini"

  SectionSetSize ${SECIDX_CORTUI} 2520
  SectionSetSize ${SECIDX_SLIPSTREAMGUI} 249

FunctionEnd


Function readSectionFlags
	StrCpy $shallInstallCortUI false
	!insertmacro SectionFlagIsSet ${SECIDX_CORTUI} ${SF_SELECTED} 0 dont
		StrCpy $shallInstallCortUI true
	dont:

	StrCpy $shallInstallSlipstreamGUI false
	!insertmacro SectionFlagIsSet ${SECIDX_SLIPSTREAMGUI} ${SF_SELECTED} 0 dont2
		StrCpy $shallInstallSlipstreamGUI true
	dont2:

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
		StrCmp $shallInstallSlipstreamGUI true atLeastOneSelected
			MessageBox MB_ICONSTOP|MB_OK "You need to select at least one of the following to proceed: CortUI or Slipstream GUI."
			Abort
	atLeastOneSelected:

	tryagainCheckProcess:
		FindProcDLL::FindProc "Allegiance.exe"
		IntCmp $R0 0 endCheckProcess
		IntCmp $R0 1 allegProcessFound allegProcessGeneralError

	allegProcessFound:
		MessageBox MB_ABORTRETRYIGNORE|MB_ICONSTOP|MB_DEFBUTTON2 "Allegiance seems to be running. CortUI / Slipstream GUI can *not* be installed while Allegiance is running! Please close Allegiance and retry."IDIGNORE endCheckProcess IDRETRY tryagainCheckProcess
		Abort

	allegProcessGeneralError:
		MessageBox MB_ABORTRETRYIGNORE|MB_ICONSTOP|MB_DEFBUTTON2 "An error occured while trying to check whether the Allegiance process is running. CortUI / Slipstream GUI can *not* be installed while Allegiance is running!"IDIGNORE endCheckProcess IDRETRY tryagainCheckProcess
		Abort

	endCheckProcess:
FunctionEnd


Function cbPreFinishPage
	StrCmp $shallInstallCortUI true dontSkip
		Abort
	dontSkip:
FunctionEnd


#Function openWelcome
#  #MessageBox MB_OK "openWelcome"
#
#  !insertmacro MUI_HEADER_TEXT "Welcome" "Some general advices and warnings about CortUI and its installer."
#  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "Welcome.ini"
#
#FunctionEnd

Function openConfigurationScreen
#MessageBox MB_OK "openConfigurationScreen"

	Call readSectionFlags

	StrCmp $shallInstallCortUI true dontSkipConfigurationScreen
		Abort
	dontSkipConfigurationScreen:

	StrCmp $shallInstallSlipstreamGUI true deactivateHangarModification
#MessageBox MB_OK "activatingCheckbox"
		!insertmacro MUI_INSTALLOPTIONS_WRITE "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "Flags" ""
		!insertmacro MUI_INSTALLOPTIONS_WRITE "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "Text" "Install modified hangar screen (up to ten lines of chat on black background)"
		Goto end
	deactivateHangarModification:
#MessageBox MB_OK "deactivatingCheckbox"
		!insertmacro MUI_INSTALLOPTIONS_WRITE "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "Flags" "DISABLED"
		!insertmacro MUI_INSTALLOPTIONS_WRITE "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "State" "0"
		!insertmacro MUI_INSTALLOPTIONS_WRITE "ConfigurationScreen.ini" "${FIELD_INSTALLHANGAR}" "Text" "[Hangar screen modification unavailable with CortUI *and* Slipstream GUI!]"
		Goto end
	end:

	!insertmacro MUI_HEADER_TEXT "Customize Options" "Set custom options for your CortUI."
	!insertmacro MUI_INSTALLOPTIONS_DISPLAY "ConfigurationScreen.ini"

FunctionEnd

#Function ValidateCustom
#  ReadINIStr $R0 "ConfigurationScreen.ini" "Field 1" "State"
#  StrCmp $R0 "" 0 +3
#    MessageBox MB_ICONEXCLAMATION|MB_OK "Please enter your name."
#    Abort
#FunctionEnd
