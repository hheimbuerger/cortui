;--------------------------------
; Welcome page

	!define MUI_WELCOMEPAGE_TEXT "You're using this installer at your own risk. You might want to backup your complete 'artwork\' directory before using it. \
								 $\r$\n$\r$\n \
								 The uninstaller will remove the CortUI files and restore the replaced UI files as of ${LATEST_ALLEG_INSTALLER_VER} of the Allegiance installer. \
								 It will *not* restore any files you edited before installing CortUI. But it will backup all replaced files before installing and before \
								 uninstalling (in the directory 'artwork\mods\CortUI\backup *\'). \
								 $\r$\n$\r$\n \
								 Please visit http://cortui.rtsquad.org/ for updates, to report problems or to suggest improvements. \
								 $\r$\n$\r$\n \
								 [Installer build: ${INSTALLER_BUILD}]"
	!insertmacro MUI_PAGE_WELCOME


;--------------------------------
; Components page

	# Check whether Allegiance is currently running
	!define MUI_PAGE_CUSTOMFUNCTION_LEAVE checkForAllegProcess
	
	# Show the components page
	!insertmacro MUI_PAGE_COMPONENTS


;--------------------------------
; Configuration page

	Page custom openConfigurationScreen


;--------------------------------
; Directory page

	!insertmacro MUI_PAGE_DIRECTORY


;--------------------------------
; Installation page

	!insertmacro MUI_PAGE_INSTFILES


;--------------------------------
; Finish page

	#!define MUI_FINISHPAGE_RUN_TEXT "Run Allegiance"
	#!define MUI_FINISHPAGE_RUN "$allegiancePath\ASGSClient.exe"
	#!define MUI_FINISHPAGE_RUN_NOTCHECKED
	;!define MUI_PAGE_CUSTOMFUNCTION_PRE cbPreFinishPage
	!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show Release Notes"
	!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\mods\CortUI\# Release Notes.txt"
	!define MUI_FINISHPAGE_SHOWREADME_CHECKED
	!insertmacro MUI_PAGE_FINISH
