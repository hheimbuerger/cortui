@echo off

set PACKAGE_FILE=CortUI-%1.mdz

echo Creating modulus package %PACKAGE_FILE% (set the version number with a command line argument!)

echo Collecting the files in a temp dir...
rmdir /s /q temp
mkdir temp\Files\Artwork\mods\CortUI\media
xcopy /q Media\*.png temp\Files\artwork\mods\CortUI\media\
echo cortui_settings.mdl > temp\xcopy_filter.tmp
xcopy /q /EXCLUDE:temp\xcopy_filter.tmp Code\*.mdl temp\Files\artwork\
del temp\xcopy_filter.tmp

echo Adding the Modulus configuration file and the custom action...
xcopy /q ModulusPackage\CortUI.ModulusCustomAction\ModulusCustomAction\bin\Release\CortUIModulusCustomAction.dll temp\
xcopy /q ModulusPackage\Definition.xml temp\

echo Creating the package...
del %PACKAGE_FILE%
cd temp
..\tools\7za a -tzip ..\%PACKAGE_FILE% *
cd ..
