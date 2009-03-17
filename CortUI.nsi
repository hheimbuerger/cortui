;NSIS Modern User Interface
;Basic Example Script
;Written by Joost Verburg



#!define DEBUG

!ifdef DEBUG
	SetCompressor bzip2
!else
	SetCompressor /SOLID lzma
!endif



;--------------------------------
;Includes

  !include "MUI.nsh"
!include "Sections.nsh"

;--------------------------------


!define NAME						"CortUI 1.70"
!define INSTALLER_BUILD				"0020"
!define FILENAME					"CortUI-1.70-final.exe"
!define REGKEY_ALLEGARTWORK			"SOFTWARE\Microsoft\Microsoft Games\Allegiance\1.0\"
!define REGNAME_ALLEGARTWORK		"ArtPath"

!define SECTIONTITLE_CORTUI					"!CortUI v1.70"
!define SECTIONDESC_CORTUI					"A modification of the look and feel of Allegiance."
!define SECTIONTITLE_SLIPSTREAMGUI			"Slipstream GUI v0.2"
!define SECTIONDESC_SLIPSTREAMGUI			"Newtype's famous new Allegiance skin."
!define SECTIONTITLE_UN_CORTUI				"un.Uninstall CortUI"
!define SECTIONDESC_UN_CORTUI				"Uninstall CortUI by restoring the original files of the replaced ones (as of freeallegiance.org-installer 1.31)"
!define SECTIONTITLE_UN_SLIPSTREAMGUI		"un.Uninstall Slipstream GUI"
!define SECTIONDESC_UN_SLIPSTREAMGUI		"Uninstall Slipstream GUI by restoring the original files of the replaced ones (as of freeallegiance.org-installer 1.31)"
!define SECTIONTITLE_UN_REMOVEBACKUPS		"un.Remove backups"
!define SECTIONDESC_UN_REMOVEBACKUPS		"Remove all backups"
!define SECTIONTITLE_UN_REMOVEUNINSTALLER	"un.Remove uninstaller"
!define SECTIONDESC_UN_REMOVEUNINSTALLER	"Remove this uninstaller"

!define FIELD_INSTALLLOBBY			"Field 1"
!define FIELD_INSTALLHANGAR			"Field 2"
!define FIELD_CHATLINESGLOBAL		"Field 4"
!define FIELD_CHATLINESLOADOUT		"Field 6"
!define FIELD_SHOWLOADOUT			"Field 7"
!define FIELD_SHOWMINIMAP			"Field 8"
!define FIELD_SHOWORDERS			"Field 9"
!define FIELD_SHOWSCROLLBAR			"Field 10"
!define FIELD_SOFTWAREHUDMODE   	"Field 12"

#Var test
Var IsSlipstreamSelected
Var IsCortuiSelected
Var isLobbyScreenSelected
Var isHangarScreenSelected
Var settingsFilename
Var settingsNumChatLinesLobby
Var settingsNumChatLinesGlobal
Var settingsNumChatLinesLoadout
Var settingsAlwaysShowLoadoutWindow
Var settingsShowMinimapAtLoadoutScreen
Var settingsShowLastOrders
Var settingsShowScrollbar
Var settingsSoftwareHUDModeText
Var settingsSoftwareHUDMode
Var isSlipstreamInstalled
Var isCortUIInstalled
Var shallInstallCortUI
Var shallInstallSlipstreamGUI
#Var allegiancePath


  !include "GetLocalTime.nsi"
  !include "HelperFunctions.nsi"
  !include "InstallationCode.nsi"
  !include "UninstallationCode.nsi"
  !include "Pages.nsi"

#	SectionSetSize SECIDX_SLIPSTREAM 99999


;--------------------------------
;General
  ;Name and file
  Name "${NAME}"
  OutFile "${FILENAME}"

  ;Get installation folder
#  Call CheckRegPath

  ;Default installation folder
  InstallDir ""
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "${REGKEY_ALLEGARTWORK}" "${REGNAME_ALLEGARTWORK}"
#  InstallDir "f:\temp2"


;--------------------------------
;Pages

 
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Descriptions

	;Language strings
#	LangString DESC_SectionCortUI ${LANG_ENGLISH} 
#	LangString DESC_SectionSlipstreamGUI ${LANG_ENGLISH} 

	;Assign language strings to sections
	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
#	  !insertmacro MUI_DESCRIPTION_TEXT ${SECIDX_CORTUI} $(DESC_SectionCortUI)
#	  !insertmacro MUI_DESCRIPTION_TEXT ${SECIDX_SLIPSTREAMGUI} $(DESC_SectionSlipstreamGUI)
	  !insertmacro MUI_DESCRIPTION_TEXT ${SECIDX_CORTUI} "${SECTIONDESC_CORTUI}"
	  !insertmacro MUI_DESCRIPTION_TEXT ${SECIDX_SLIPSTREAMGUI} "${SECTIONDESC_SLIPSTREAMGUI}"
	!insertmacro MUI_FUNCTION_DESCRIPTION_END

	!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
	  !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_CORTUI} "${SECTIONDESC_UN_CORTUI}"
	  !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_SLIPSTREAMGUI} "${SECTIONDESC_UN_SLIPSTREAMGUI}"
	  !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_REMOVEBACKUPS} "${SECTIONDESC_UN_REMOVEBACKUPS}"
	  !insertmacro MUI_DESCRIPTION_TEXT ${UN_SECIDX_REMOVEUNINSTALLER} "${SECTIONDESC_UN_REMOVEUNINSTALLER}"
	!insertmacro MUI_UNFUNCTION_DESCRIPTION_END



