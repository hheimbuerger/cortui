; CortUI Installer script
;
; Latest NSIS tested with: 2.51 (http://nsis.sourceforge.net/). Modern UI 2 and InstallOptions 2 are required.
;
; This installer requires the FindProc plugin. Copy FindProc/FindProcDLL.dll to your /Program Files/NSIS/Plugins/ directory and you're set.



;--------------------------------
; Constants

	!define VER_MAJOR					"2"
	!define VER_MINOR					"0"
	!define VER_BUGFIX					"alpha1"
	!define INSTALLER_BUILD				"0030"
	!define VERSION_NUMBER				"${VER_MAJOR}.${VER_MINOR}${VER_BUGFIX}"
	!define LATEST_ALLEG_INSTALLER_VER	"build 258"

	!ifdef RELEASE
		!define VERSION		${VERSION_NUMBER}
		!define NAME		"CortUI ${VERSION}"
		!define FILENAME	"CortUI-${VERSION}.exe"
		SetCompressor /solid lzma
	!else
		!ifndef BUILD_ID
			!define /date BUILD_ID "%Y%m%d-%H%M%S"
		!endif
		!define VERSION		"${VERSION_NUMBER}-dev-r${BUILD_ID}"
		!define NAME		"CortUI ${VERSION_NUMBER}-dev-r${BUILD_ID}"
		!define FILENAME	"CortUI-${VERSION_NUMBER}-dev-r${BUILD_ID}.exe"
		SetCompressor zlib
	!endif

	!define REGKEY_ALLEG				"SOFTWARE\Microsoft\Microsoft Games\Allegiance\1.2\"
	!define REGNAME_ALLEG_ARTWORK		"ArtPath"
	!define REGNAME_ALLEG_LOBBYPATH		"Lobby Path"
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

	!define CONFIGURATION_PAGE_TITLE			"Customize Options"
	!define CONFIGURATION_PAGE_SUBTITLE			"Set custom options and choose your HUD."

	!define FIELD_INSTALLLOBBY			"Field 1"
	!define FIELD_INSTALLHANGAR			"Field 2"

	!define INSTALLOPTIONS_TEMP_FILE	"CortUIConfig.ini"       # the name of the configuration .ini file in the temp directory at installation-time


;--------------------------------
; Variables

#	Var isLobbyScreenSelected
	Var settingsFilename
	Var settingsNumChatLinesLobby
	Var settingsNumChatLinesGlobal
	Var settingsShowLastOrders
	Var settingsShowScrollbar
	Var allegiancePath


;--------------------------------
; General

	# Name and file
	Name "${NAME}"
	OutFile "${FILENAME}"

	# Basic configuration
    RequestExecutionLevel user

	# Default installation folder
	InstallDir ""

	# Get installation folder from registry if available
	InstallDirRegKey HKLM "${REGKEY_ALLEG}" "${REGNAME_ALLEG_ARTWORK}"


;--------------------------------
; Includes

	# NSIS components
	!include "MUI2.nsh"														# used for the installer UI
	!include "InstallOptions.nsh"											# used for the controls on the configuration screen

	# Custom configuration (note: the order of the imports is *very* relevant for ModernUI2/NSIS!)
	!include "Installer\Interface.nsi"										# defines general UI options (header, icon, etc.)
	!include "Installer\GetLocalTime.nsi"									# used for creating the backup directories with a timestamp
	!include "Installer\HelperFunctions.nsi"								# various helpers (checking for Alleg process, writing cortui_settings.mdl, backup)
	!include "Installer\InstallationPages.nsi"								# the pages shown during installation
	!include "Installer\UninstallationPages.nsi"							# the code used during installation
	!include "Installer\InstallationCode.nsi"								# the pages shown during uninstallation
	!include "Installer\UninstallationCode.nsi"								# the code used during uninstallation


;--------------------------------
; Languages

	!insertmacro MUI_LANGUAGE "English"
