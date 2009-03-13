;--------------------------------
; Interface Configuration

	# Do show a confirmation dialog when the user wants to abort the installation
	!define MUI_ABORTWARNING
	
	# Show a custom header
	!define MUI_HEADERIMAGE
	!define MUI_HEADERIMAGE_BITMAP "Installer\media\header.bmp"
	!define MUI_HEADERIMAGE_UNBITMAP "Installer\media\header.bmp"
	!define MUI_HEADERIMAGE_RIGHT
	
	# Use a custom icon
	!define MUI_ICON "Installer\media\icon.ico"
	!define MUI_UNICON "Installer\media\icon.ico"

	# Do not jump to the finish pages automatically, to allow the user to review the (un)installation log
	!define MUI_FINISHPAGE_NOAUTOCLOSE
	!define MUI_UNFINISHPAGE_NOAUTOCLOSE


;--------------------------------
; Languages

	!insertmacro MUI_LANGUAGE "English"
