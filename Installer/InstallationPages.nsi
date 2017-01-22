;--------------------------------
; Welcome page

	!define MUI_WELCOMEPAGE_TEXT "CortUI is a UI modification for Allegiance that aims to improve your access to information in the heat of the battle. It comes with multiple alternative HUDs, which can be switched mid-flight in the 'Graphics' -> 'Style' menu.$\r$\n$\r$\nPlease close Allegiance before installing. When asked for a destination folder, select Allegiance's artwork folder (the production folder is automatically detected and recommended).$\r$\n$\r$\nVisit http://cortui.rtsquad.org/ for updates, to report problems or to suggest improvements.$\r$\n$\r$\n[Installer build: ${INSTALLER_BUILD}]"
	!insertmacro MUI_PAGE_WELCOME


;--------------------------------
; Components page

	# Check whether Allegiance is currently running
	!define MUI_PAGE_CUSTOMFUNCTION_LEAVE checkForAllegProcess

	# Show the components page
	# !insertmacro MUI_PAGE_COMPONENTS


;--------------------------------
; Directory page

	!insertmacro MUI_PAGE_DIRECTORY


;--------------------------------
; Installation page

	!insertmacro MUI_PAGE_INSTFILES


;--------------------------------
; Finish page

	!define MUI_FINISHPAGE_RUN_TEXT "Run Allegiance"
    !define MUI_FINISHPAGE_RUN
    !define MUI_FINISHPAGE_RUN_FUNCTION PageFinishRun
	!define MUI_FINISHPAGE_RUN_NOTCHECKED
	!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show Release Notes"
	!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\mods\CortUI\# Release Notes.txt"
	!define MUI_FINISHPAGE_SHOWREADME_CHECKED
	!define MUI_FINISHPAGE_LINK "Visit the CortUI website now"
	!define MUI_FINISHPAGE_LINK_LOCATION "http://cortui.rtsquad.org/"
	!insertmacro MUI_PAGE_FINISH
