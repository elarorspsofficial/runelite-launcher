[Setup]
AppName=Zenyte Launcher
AppPublisher=Zenyte
UninstallDisplayName=Zenyte
AppVersion=${project.version}
AppSupportURL=https://zenyte.com
DefaultDirName={localappdata}\Zenyte

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Zenyte.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=ZenyteSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x64\Zenyte.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\Zenyte.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Zenyte\Zenyte"; Filename: "{app}\Zenyte.exe"
Name: "{userprograms}\Zenyte\Zenyte (configure)"; Filename: "{app}\Zenyte.exe"; Parameters: "--configure"
Name: "{userprograms}\Zenyte\Zenyte (safe mode)"; Filename: "{app}\Zenyte.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Zenyte"; Filename: "{app}\Zenyte.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Zenyte.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Zenyte.exe"; Description: "&Open Zenyte"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Zenyte.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.zenyte\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Zenyte.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"