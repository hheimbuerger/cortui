@echo off

if not "%~1" == "" goto continue
echo Syntax: BuildModulusPackage.cmd ^<version number^>
goto eof

:continue
set PACKAGE_FILE=CortUI-%1.mdz

echo Creating modulus package %PACKAGE_FILE%.
echo.

echo 1. Collecting the files in a temp dir...
rmdir /s /q temp
mkdir temp\Files\Artwork\mods\CortUI\media
xcopy /q Media\*.png temp\Files\artwork\mods\CortUI\media\ >nul:
echo cortui_settings.mdl > temp\xcopy_filter.tmp
xcopy /q /EXCLUDE:temp\xcopy_filter.tmp Code\*.mdl temp\Files\artwork\ >nul:
del temp\xcopy_filter.tmp

echo 2. Adding the Modulus configuration file and the custom action...
xcopy /q ModulusPackage\CortUI.ModulusCustomAction\ModulusCustomAction\bin\Release\CortUIModulusCustomAction.dll temp\ >nul:
xcopy /q ModulusPackage\Definition.xml temp\ >nul:

echo 3. Creating the package...
if not exist %PACKAGE_FILE% goto skipDeletion
del %PACKAGE_FILE%
:skipDeletion
cd temp
..\tools\7za a -tzip ..\%PACKAGE_FILE% * >nul:
cd ..
echo Done.

:eof