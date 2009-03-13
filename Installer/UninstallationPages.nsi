;--------------------------------
; Welcome page

	!define MUI_WELCOMEPAGE_TEXT "You're using this uninstaller at your own risk. \
							  Hopefully, you have read the installer welcome page and have your 'artwork\' directory backup ready now. ;) \
							  $\r$\n$\r$\n \
							  The uninstaller will remove the CortUI files and restore the replaced UI files as of ${LATEST_ALLEG_INSTALLER_VER} of the Allegiance \
							  installer. It will *not* restore any files you edited before installing CortUI. But there is a backup of all replaced files in the \
							  directory 'artwork\mods\CortUI\backup *\'). \
							  $\r$\n$\r$\n \
							  Please visit http://cortui.rtsquad.org/ for updates, to report problems or to suggest improvements. \
							  $\r$\n$\r$\n \
							  [Uninstaller build: ${INSTALLER_BUILD}]"


;--------------------------------
; Components page

	!define MUI_PAGE_CUSTOMFUNCTION_LEAVE un.checkForAllegProcess
	!insertmacro MUI_UNPAGE_COMPONENTS


;--------------------------------
; Uninstallation page

	!insertmacro MUI_UNPAGE_INSTFILES


;--------------------------------
; Finish page

	!insertmacro MUI_UNPAGE_FINISH
