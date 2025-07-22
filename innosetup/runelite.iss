[Setup]
AppName=Jirenyte Launcher
AppPublisher=Jirenyte
UninstallDisplayName=Jirenyte
AppVersion=${project.version}
AppSupportURL=https://jirenyte.com
DefaultDirName={localappdata}\Jirenyte

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Jirenyte.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=JirenyteSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x64\Jirenyte.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\Jirenyte.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Jirenyte\Jirenyte"; Filename: "{app}\Jirenyte.exe"
Name: "{userprograms}\Jirenyte\Jirenyte (configure)"; Filename: "{app}\Jirenyte.exe"; Parameters: "--configure"
Name: "{userprograms}\Jirenyte\Jirenyte (safe mode)"; Filename: "{app}\Jirenyte.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Jirenyte"; Filename: "{app}\Jirenyte.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Jirenyte.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Jirenyte.exe"; Description: "&Open Jirenyte"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Jirenyte.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.jirenyte\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Jirenyte.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"