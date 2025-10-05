[Setup]
AppName=Elaro Launcher
AppPublisher=Elaro
UninstallDisplayName=Elaro
AppVersion=${project.version}
AppSupportURL=https://elaro-ps.com
DefaultDirName={localappdata}\Elaro

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Elaro.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=ElaroSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x64\Elaro.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\Elaro.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Elaro\Elaro"; Filename: "{app}\Elaro.exe"
Name: "{userprograms}\Elaro\Elaro (configure)"; Filename: "{app}\Elaro.exe"; Parameters: "--configure"
Name: "{userprograms}\Elaro\Elaro (safe mode)"; Filename: "{app}\Elaro.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Elaro"; Filename: "{app}\Elaro.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Elaro.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Elaro.exe"; Description: "&Open Elaro"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Elaro.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.elaro\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Elaro.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"