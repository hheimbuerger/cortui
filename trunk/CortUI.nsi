; CortUI Installer script
;
; Latest NSIS tested with: 2.44 (http://nsis.sourceforge.net/). Modern UI 2 and InstallOption 2 are required.
;
; This installer requires the FindProc plugin. Copy FindProc/FindProcDLL.dll to your /Program Files/NSIS/Plugins/ directory and you're set.



;--------------------------------
; Constants

	!define VER_MAJOR					"1"
	!define VER_MINOR					"7"
	!define VER_BUGFIX					"6"
	!define INSTALLER_BUILD				"0027"
	!define VERSION						"${VER_MAJOR}.${VER_MINOR}${VER_BUGFIX}"
	!define NAME						"CortUI ${VERSION}"
	!define FILENAME					"CortUI-${VERSION}.exe"
	!define CORTUI_SIZE                 1013
	!define LATEST_ALLEG_INSTALLER_VER	"build 210"

	!define REGKEY_ALLEGARTWORK			"SOFTWARE\Microsoft\Microsoft Games\Allegiance\1.0\"
	!define REGNAME_ALLEGARTWORK		"ArtPath"
	!define REGKEY_CORTUI				"SOFTWARE\CortUI"
	!define REGNAME_CORTUI_VERSION		"version"
	!define REGNAME_CORTUI_INSTALLDIR	"installDir"

	!define SECTIONTITLE_CORTUI					"!CortUI v${VERSION}"
	!define SECTIONDESC_CORTUI					"A modification of the look and feel of Allegiance, including various alternative HUDs."
	!define SECTIONTITLE_UN_CORTUI				"un.Uninstall CortUI"
	!define SECTIONDESC_UN_CORTUI				"Uninstall CortUI by restoring the original files of the replaced ones (as of freeallegiance.org-installer ${LATEST_ALLEG_INSTALLER_VER})"
	!define SECTIONTITLE_UN_REMOVEBACKUPS		"un.Remove backups"
	!define SECTIONDESC_UN_REMOVEBACKUPS		"Remove all backups"
	!define SECTIONTITLE_UN_REMOVEUNINSTALLER	"un.Remove uninstaller"
	!define SECTIONDESC_UN_REMOVEUNINSTALLER	"Remove this uninstaller"

	!define CONFIGURATION_PAGE_TITLE "Customize Options"
	!define CONFIGURATION_PAGE_SUBTITLE "Set custom options and choose your HUD."

	!define FIELD_INSTALLLOBBY			"Field 1"
	!define FIELD_INSTALLHANGAR			"Field 2"
	!define FIELD_CHATLINESGLOBAL		"Field 5"
	!define FIELD_CHATLINESLOADOUT		"Field 7"
	!define FIELD_SHOWLOADOUT			"Field 8"
	!define FIELD_SHOWMINIMAP			"Field 9"
	!define FIELD_SHOWORDERS			"Field 10"
	!define FIELD_SHOWSCROLLBAR			"Field 11"
	!define FIELD_NORMALHUDMODE   	    "Field 13"
	!define FIELD_SOFTWAREHUDMODE   	"Field 15"

	!define INSTALLOPTIONS_TEMP_FILE "CortUIConfig.ini"       # the name of the configuration .ini file in the temp directory at installation-time


;--------------------------------
; Variables

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
	Var settingsNormalHUDModeText
	Var settingsNormalHUDMode


;--------------------------------
; General

	# Name and file
	Name "${NAME}"
	OutFile "${FILENAME}"

	# Default installation folder
	InstallDir ""

	# Get installation folder from registry if available
	InstallDirRegKey HKLM "${REGKEY_ALLEGARTWORK}" "${REGNAME_ALLEGARTWORK}"


;--------------------------------
; Includes

	# NSIS components
	!include "MUI2.nsh"
	!include "InstallOptions.nsh"

	# Custom configuration (note: the order of the imports is *very* relevant for ModernUI2/NSIS!)
	!include "Installer\GetLocalTime.nsi"
	!include "Installer\HelperFunctions.nsi"
	!define INSTALLOPTIONS_INI_FILE "Installer\ConfigurationScreen.ini"
	!include "Installer\InstallationPages.nsi"
	!include "Installer\UninstallationPages.nsi"
	!include "Installer\Interface.nsi"
	!include "Installer\InstallationCode.nsi"
	!include "Installer\UninstallationCode.nsi"
