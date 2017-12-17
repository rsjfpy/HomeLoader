
#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <GuiButton.au3>
#include <FontConstants.au3>
#include <File.au3>
#include <GUIConstants.au3>
#include <TrayConstants.au3>
#include <Inet.au3>
#include "_GDIPlus_WTOB.au3"
#include <GDIPlus.au3>

Opt("GUIOnEventMode", 1)

#Region Global
Global $SteamVR_Status, $Title_1, $Title_2, $Handle_1, $Handle_2, $Title_Array_1, $Title_Array_2, $Handle_Array_1, $Handle_Array_2, $NR_Handle_1, $NR_Handle_2
Global $GameStarted, $LOOP_VIVEHOMECheck, $OldWindowExists, $Button_Close_Current_Running, $Button_Restart, $Button_Exit
Global $Select_HomeApp_Label, $USE_GUI_Backup, $ApplicationList_Read, $Array_tools_vrmanifest_File, $Line_NR_binary_path_windows, $Line_NR_image_path
Global $Array_tools_vrmanifest_File, $AddShortcut_to_Oculus_GUI, $GUI_Label, $HOMECheck, $WinTitle, $Check_AppId
Global $DesktopWidth, $DesktopHeight, $Width, $Height, $X, $Y, $font_arial, $GUI, $Install_DIR_replaced,$State_Checkbox, $SteamGameID
Global $hImage1_Path, $hImage2_Path, $Check_StringSplit_NR, $Check_Filename_1, $Check_Filename_2, $Check_Filename_3, $Check_Filename, $hBMPBuff, $hGraphic, $hPen
Global $hImage1, $hImage2, $GameNameStarted, $GameStarted_State, $FileLines, $Application_name
Global $GUI_Loading, $COLOR_RED, $DOWNLOAD_URL, $Button_HLStatus, $NewIcon_Path, $GameClosed, $GameStarted
Global $SteamVR_Status
#endregion

#Region Colors
Global $LimeGreen = "0x32CD32"
Global $Blue = "0x00BFFF"
Global $Yellow = "0xFFFF00"
#endregion

#Region Variablen
Global $font = "arial"

;Global $Config_INI = @ScriptDir & "\config.ini"
Global $Config_INI = _PathFull("HomeLoader\config.ini", @AppDataDir)
If Not FileExists($Config_INI) Then FileCopy(@ScriptDir & "\config.ini", $Config_INI, $FC_CREATEPATH + $FC_OVERWRITE)
Global $Install_DIR = StringReplace(@ScriptDir, 'System', '')
	If StringRight($Install_DIR, 1) <> "\" Then $Install_DIR = $Install_DIR & "\"
Global $System_DIR = $Install_DIR & "System\"
Global $HomeLoader_StartBat = $System_DIR & "StartHomeAPP.bat"
Global $ApplicationList_Folder = $Install_DIR & "ApplicationList\"
Global $TEMP_StartHomeLoader = IniRead($Config_INI, "TEMP", "StartHomeLoader", "")
Global $TEMP_StartHomeSettings = IniRead($Config_INI, "TEMP", "StartHomeLoaderSettings", "")
Global $ChangeDefaultSteamVRHome = IniRead($Config_INI, "Settings", "ChangeDefaultSteamVRHome", "")
Global $Add_PlayersOnline_to_Icons = IniRead($Config_INI, "Settings", "Add_PlayersOnline_to_Icons", "false")
Global $Add_SS_to_Icons = IniRead($Config_INI, "Settings", "Add_SS_to_Icons", "false")
Global $Add_SS_per_game = IniRead($Config_INI, "Settings", "Add_SS_per_game", "false")
Global $StartSteamVRHome = $System_DIR & "StartSteamVRHome.exe"
Global $Home_Path = IniRead($Config_INI, "Settings_HomeAPP", "Home_Path", "")
Global $WinName = IniRead($Config_INI, "Settings_HomeAPP", "WindowName", "")
Global $Status_Checkbox_Minimize_OVRS = IniRead($Config_INI,"Settings", "Minimize_Oculus", "")
Global $Status_Checkbox_Close_OVRS = IniRead($Config_INI,"Settings", "Close_Oculus", "")
Global $gfx = $System_DIR & "gfx\"
Global $Icons = $Install_DIR & "Icons\"
Global $JanusVR_Page = $Install_DIR & "WebPage\janusvr\" & "index.html"
Global $First_Start = IniRead($Config_INI, "Settings", "First_Start", "")
Global $Autostart_VRUB = IniRead($Config_INI, "Settings", "Autostart_VRUB", "")
Global $Steam_Path_REG = RegRead('HKEY_CURRENT_USER\Software\Valve\Steam\', "SteamPath")
Global $Steam_Path = StringReplace($Steam_Path_REG, '/', '\') & "\"
Global $HomeLoader_Overlay_Folder = $Steam_Path & "steamapps\common\VRUtilityBelt\addons\custom\HomeLoader\overlays\HomeLoader\"

Global $ShowCMD = IniRead($Config_INI, "TEMP", "ShowCMD", "")

Global $ApplicationList_SteamLibrary_ALL_INI = $ApplicationList_Folder & "ApplicationList_SteamLibrary_ALL.ini"
Global $ApplicationList_Non_Steam_Appl_INI = $ApplicationList_Folder & "ApplicationList_Non-Steam_Appl.ini"
Global $ApplicationList_Custom_1_INI = $ApplicationList_Folder & "ApplicationList_Custom_1.ini"
Global $ApplicationList_Custom_2_INI = $ApplicationList_Folder & "ApplicationList_Custom_2.ini"
Global $ApplicationList_Custom_3_INI = $ApplicationList_Folder & "ApplicationList_Custom_3.ini"
Global $ApplicationList_Custom_4_INI = $ApplicationList_Folder & "ApplicationList_Custom_4.ini"

Global $Install_Folder_Steam_1 = IniRead($Config_INI, "Folders", "Install_Folder_Steam_1", "")
Global $Install_Folder_Steam_2 = IniRead($Config_INI, "Folders", "Install_Folder_Steam_2", "")
Global $Install_Folder_Steam_3 = IniRead($Config_INI, "Folders", "Install_Folder_Steam_3", "")
Global $Install_Folder_Steam_4 = IniRead($Config_INI, "Folders", "Install_Folder_Steam_4", "")
Global $Install_Folder_Steam_5 = IniRead($Config_INI, "Folders", "Install_Folder_Steam_5", "")

Global $Icon_Folder_1 = IniRead($Config_INI, "Folders", "Icon_Folder_1", "")
Global $Icon_Folder_2 = IniRead($Config_INI, "Folders", "Icon_Folder_2", "")
Global $Icon_Folder_3 = IniRead($Config_INI, "Folders", "Icon_Folder_3", "")
Global $Icon_Folder_4 = IniRead($Config_INI, "Folders", "Icon_Folder_4", "")
Global $Icon_Folder_5 = IniRead($Config_INI, "Folders", "Icon_Folder_5", "")

Global $Steam_Path_REG = RegRead('HKEY_CURRENT_USER\Software\Valve\Steam\', "SteamPath")
Global $Steam_Path = StringReplace($Steam_Path_REG, '/', '\') & "\"
Global $SteamVR_Path = $Steam_Path & "SteamApps\common\SteamVR\"

Global $default_vrsettings_File = IniRead($Config_INI, "Folders", "Steam_default_vrsettings", "")
Global $default_vrsettings_File_BAK = $default_vrsettings_File & ".bak"
Global $default_vrsettings_File_new = $default_vrsettings_File & ".new"

Global $Steam_tools_vrmanifest_File = IniRead($Config_INI, "Folders", "Steam_tools_vrmanifest", "")
Global $Steam_tools_vrmanifest_File_BAK = $Steam_tools_vrmanifest_File & ".bak"

Global $Steam_stats_log_txt = $Install_Folder_Steam_1 & "\logs\stats_log.txt"

Global $HTCVive_Path_REG = RegRead('HKEY_CURRENT_USER\Software\HTC\HTC Vive\', "ViveHelperPath")
Global $HTCVive_Path_StringReplace_1 = StringReplace($HTCVive_Path_REG, 'PCClient\HTCVRMarketplaceUserContextHelper.exe', '')
Global $HTCVive_Path = StringReplace($HTCVive_Path_StringReplace_1, '/', '\')

Global $DefaultClickAction = IniRead($Config_INI, "TEMP", "DefaultClickAction", "")

Global $default_renderTargetMultiplier_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "SteamVR_Status", "default_renderTargetMultiplier", "1.0")
Global $default_supersampleScale_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "SteamVR_Status", "default_supersampleScale", "1.0")
Global $default_allowSupersampleFiltering_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "SteamVR_Status", "default_allowSupersampleFiltering", "true")

Global $stats_log_FILE = $System_DIR & "Logs\stats_log.txt"
#endregion

If Not ProcessExists("vrmonitor.exe") Then
	Sleep(5000)
	_Check_SteamVR_Exit()
EndIf

If $First_Start = "true" Then
	If Not FileExists($Install_DIR & "Backups\default.vrsettings") Then FileCopy($default_vrsettings_File, $Install_DIR & "Backups\default.vrsettings", $FC_OVERWRITE)
	If Not FileExists($Install_DIR & "Backups\tools.vrmanifest") Then FileCopy($Steam_tools_vrmanifest_File, $Install_DIR & "Backups\tools.vrmanifest", $FC_OVERWRITE)
	_FirstStart_Restart()
EndIf

If $Autostart_VRUB = "true" Then
	Local $Parameter_1 = ""
	If $CmdLine[0] Then
		;_ArrayDisplay($CmdLine)
		$Parameter_1 = $CmdLine[1]
	EndIf

	If $Parameter_1 = "UpdateOverlay" Then
		FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " Start Updating the Overlay:")
		If $Add_PlayersOnline_to_Icons = "true" Then _Get_ADD_PlayersOnline_DATA()
		If $Add_SS_to_Icons = "true" Then _Get_AD_SS_Values_to_Icons()
		_Start_HomeLoaderLibrary_UpdateOverlay()
		Exit
	EndIf
Else
	If $Add_PlayersOnline_to_Icons = "true" Then _Get_ADD_PlayersOnline_DATA()
	If $Add_SS_to_Icons = "true" Then _Get_AD_SS_Values_to_Icons()
EndIf


#Region GUI
	_Main_GUI()
#endregion

_Min_Close_Oculus()

If $Autostart_VRUB <> "true" Then _LOOP_1()
If $Autostart_VRUB = "true" Then _VRUB_LOOP_1()

#Region GUI
Func _Main_GUI()
	_Create_GUI()

	If Not ProcessExists("vrmonitor.exe") Then
		Sleep(5000)
		If Not ProcessExists("vrmonitor.exe") Then Sleep(10000)
		If Not ProcessExists("vrmonitor.exe") Then Sleep(10000)
		If Not ProcessExists("vrmonitor.exe") Then Exit
	EndIf
EndFunc

Func _Loading_GUI()
	Local Const $PG_WS_POPUP = 0x80000000
	Local Const $PG_WS_DLGFRAME = 0x00400000

	$GUI_Loading = GUICreate("Downloading PHP Files...please wait...", 250, 65, -1, -1, BitOR($PG_WS_DLGFRAME, $PG_WS_POPUP))
	GUISetIcon(@AutoItExe, -2, $GUI_Loading)
	GUISetBkColor("0x00BFFF")

	GUICtrlCreateLabel("...Downloading...", 40, 5, 170, 25)
	GUICtrlSetFont(-1, 17, 800, 1, $font)
	GUICtrlSetColor(-1, $COLOR_RED)
	GUICtrlCreateLabel("...PHP Files...", 58, 32, 160, 25)
	GUICtrlSetFont(-1, 17, 800, 1, $font)
	GUICtrlSetColor(-1, $COLOR_RED)

	GUISetState(@SW_SHOW, $GUI_Loading)
	WinSetOnTop("Loading...please wait...", "", $WINDOWS_ONTOP)
EndFunc

Func _Create_GUI()
	$Width = 30
	$Height = 30
	$X = $Width
	$Y = $Height

	$font_arial = "arial"
	$SteamVR_Status = "true"

	Local Const $PG_WS_POPUP = 0x80000000
	Local Const $PG_WS_DLGFRAME = 0x00400000

	Global $GUI_2 = GUICreate("Home Loader", $X, $Y, 2, 2, BitOR($PG_WS_DLGFRAME, $PG_WS_POPUP))  ; $WS_EX_TOPMOST
	GUISetIcon(@AutoItExe, -2, $GUI_2)
	GUISetBkColor("0x483D8B")

	$Button_HLStatus = GUICtrlCreateButton("HLStatus_1", - 5, - 5, 41, 41, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_HLStatus, $gfx & "HLStatus_1.bmp")
	GuiCtrlSetTip($Button_HLStatus, "LOADING...:" & @CRLF)
	GUICtrlSetOnEvent($Button_HLStatus, "_Button_HLStatus")

	Global $contextmenu = GUICtrlCreateContextMenu($Button_HLStatus)
	Global $RM_Menu_Item_1 = GUICtrlCreateMenu("Open Game Page", $contextmenu, 1)
		Global $RM_Item1_1 = GUICtrlCreateMenuItem("Game Page - All Applications", $RM_Menu_Item_1, 1, 0)
		Global $RM_Item1_2 = GUICtrlCreateMenuItem("Game Page - Non-Steam Applications", $RM_Menu_Item_1, 2, 0)
		Global $RM_Item1_3 = GUICtrlCreateMenuItem("Game Page - Custom 1", $RM_Menu_Item_1, 3, 0)
		Global $RM_Item1_4 = GUICtrlCreateMenuItem("Game Page - Custom 2", $RM_Menu_Item_1, 4, 0)
		Global $RM_Item1_5 = GUICtrlCreateMenuItem("Game Page - Custom 3", $RM_Menu_Item_1, 5, 0)
		Global $RM_Item1_6 = GUICtrlCreateMenuItem("Game Page - Custom 4", $RM_Menu_Item_1, 6, 0)
		;GUICtrlSetOnEvent($RM_Menu_Item_1, "_RM_Menu_Item_1")
		GUICtrlSetOnEvent($RM_Item1_1, "_RM_Item1_1")
		GUICtrlSetOnEvent($RM_Item1_2, "_RM_Item1_1")
		GUICtrlSetOnEvent($RM_Item1_3, "_RM_Item1_1")
		GUICtrlSetOnEvent($RM_Item1_4, "_RM_Item1_1")
		GUICtrlSetOnEvent($RM_Item1_5, "_RM_Item1_1")
		GUICtrlSetOnEvent($RM_Item1_6, "_RM_Item1_1")
	Global $RM_Item2 = GUICtrlCreateMenuItem("", $contextmenu, 2, 0)
	Global $RM_Item3 = GUICtrlCreateMenuItem("Home Loader Library", $contextmenu, 3, 0)
		GUICtrlSetOnEvent(- 1, "RM_Item3")
	;Global $RM_Item4 = GUICtrlCreateMenuItem("Playlist", $contextmenu, 4, 0)
		;GUICtrlSetOnEvent(- 1, "RM_Item4")
	Global $RM_Item5 = GUICtrlCreateMenuItem("Supersampling Menu", $contextmenu, 5, 0)
		GUICtrlSetOnEvent(- 1, "RM_Item5")
	Global $RM_Item6 = GUICtrlCreateMenuItem("Start SteamVR Home APP", $contextmenu, 6, 0)
		GUICtrlSetOnEvent(- 1, "RM_Item6")
	Global $RM_Item7 = GUICtrlCreateMenuItem("Settings", $contextmenu, 7, 0)
		GUICtrlSetOnEvent(- 1, "RM_Item7")
	Global $RM_Item8 = GUICtrlCreateMenuItem("", $contextmenu, 8, 0)
	Global $RM_Item9 = GUICtrlCreateMenuItem("", $contextmenu, 9, 0)
	Global $RM_Menu_Item_10 = GUICtrlCreateMenu("Default click action", $contextmenu, 10)
		Global $RM_Item10_1 = GUICtrlCreateMenuItem("Game Page - All Applications", $RM_Menu_Item_10, 1, 1)
		Global $RM_Item10_2 = GUICtrlCreateMenuItem("Game Page - Non-Steam Applications", $RM_Menu_Item_10, 2, 1)
		Global $RM_Item10_3 = GUICtrlCreateMenuItem("Game Page - Custom 1", $RM_Menu_Item_10, 3, 1)
		Global $RM_Item10_4 = GUICtrlCreateMenuItem("Game Page - Custom 2", $RM_Menu_Item_10, 4, 1)
		Global $RM_Item10_5 = GUICtrlCreateMenuItem("Game Page - Custom 3", $RM_Menu_Item_10, 5, 1)
		Global $RM_Item10_6 = GUICtrlCreateMenuItem("Game Page - Custom 4", $RM_Menu_Item_10, 6, 1)
		Global $RM_Item10_7 = GUICtrlCreateMenuItem("Home Loader Library", $RM_Menu_Item_10, 7, 1)
		;Global $RM_Item10_8 = GUICtrlCreateMenuItem("Playlist", $RM_Menu_Item_10, 8, 1)
		Global $RM_Item10_9 = GUICtrlCreateMenuItem("Supersampling Menu", $RM_Menu_Item_10, 9, 1)
		Global $RM_Item10_10 = GUICtrlCreateMenuItem("Start SteamVR Home APP", $RM_Menu_Item_10, 10, 1)
		Global $RM_Item10_11 = GUICtrlCreateMenuItem("Settings", $RM_Menu_Item_10, 11, 1)
		Global $RM_Item10_12 = GUICtrlCreateMenuItem("Restart Home Loader", $RM_Menu_Item_10, 12, 1)
		Global $RM_Item10_13 = GUICtrlCreateMenuItem("Exit", $RM_Menu_Item_10, 13, 1)
			GUICtrlSetOnEvent($RM_Item10_1, "_RM_Item10_1")
			GUICtrlSetOnEvent($RM_Item10_2, "_RM_Item10_2")
			GUICtrlSetOnEvent($RM_Item10_3, "_RM_Item10_3")
			GUICtrlSetOnEvent($RM_Item10_4, "_RM_Item10_4")
			GUICtrlSetOnEvent($RM_Item10_5, "_RM_Item10_5")
			GUICtrlSetOnEvent($RM_Item10_6, "_RM_Item10_6")
			GUICtrlSetOnEvent($RM_Item10_7, "_RM_Item10_7")
			;GUICtrlSetOnEvent($RM_Item10_8, "_RM_Item10_8")
			GUICtrlSetOnEvent($RM_Item10_9, "_RM_Item10_9")
			GUICtrlSetOnEvent($RM_Item10_10, "_RM_Item10_10")
			GUICtrlSetOnEvent($RM_Item10_11, "_RM_Item10_11")
			GUICtrlSetOnEvent($RM_Item10_12, "_RM_Item10_12")
			GUICtrlSetOnEvent($RM_Item10_13, "_RM_Item10_13")
	Global $RM_Item11 = GUICtrlCreateMenuItem("", $contextmenu, 11, 0)
	Global $RM_Item12 = GUICtrlCreateMenuItem("", $contextmenu, 12, 0)
	Global $RM_Item13 = GUICtrlCreateMenuItem("Restart Home Loader", $contextmenu, 13, 0)
		GUICtrlSetOnEvent(- 1, "_Restart_HomeLoader")
	Global $RM_Item14 = GUICtrlCreateMenuItem("Exit", $contextmenu, 14, 0)
		GUICtrlSetOnEvent(- 1, "_Exit")
	GUISetState(@SW_SHOW, $GUI_2)
	WinSetOnTop("Home Loader", "", $WINDOWS_ONTOP)
	WinActivate($WinName)
EndFunc

#endregion

#Region LOOP
Func _LOOP_1()
	$Home_Path = IniRead($Config_INI, "Settings_HomeAPP", "Home_Path", "")
	$WinName = IniRead($Config_INI, "Settings_HomeAPP", "WindowName", "")

	Local $WinName_ACTIVE = WinGetTitle("[ACTIVE]")

	_GUICtrlButton_SetImage($Button_HLStatus, $gfx & "HLStatus_1.bmp")

	Do
		$SteamVR_Status = IniRead($Config_INI, "SteamVR_Status", "Status", "")
		Sleep(1000)
		_Check_SteamVR_Exit()
		$WinName_ACTIVE = WinGetTitle("[ACTIVE]")
	Until WinExists($WinName)

	Sleep(500)

	If $WinName_ACTIVE = $WinName Then
		Local $HOMECheck = "false"
		FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " Home app loaded: " & "<Name: " & $WinName & ">" & " - " & "<Path: " & $Home_Path & ">")
		Do
			_GUICtrlButton_SetImage($Button_HLStatus, $gfx & "HLStatus_2.bmp")
			GuiCtrlSetTip($Button_HLStatus, "Home APP loaded:" & @CRLF & $WinName_ACTIVE)

			If WinExists($WinName) Then
				$HOMECheck = "true"
				GUICtrlSetData($GUI_Label, "SteamVR Home loaded.")
				GUISetBkColor($Blue)
			Else
				$HOMECheck = "false"
				GUICtrlSetData($GUI_Label, "Home not loaded")
				GUISetBkColor($Yellow)
				TrayTip("Home Loader", "Home not loaded." & @CRLF & $WinName, 5, $TIP_ICONASTERISK)
			EndIf
			_Check_SteamVR_Exit()
			_Ident_GameID()
			Sleep(1000)
			WinSetOnTop("Home Loader", "", $WINDOWS_ONTOP)
		Until $HOMECheck = "false"
		$GameStarted = "true"
	EndIf
	_Ident_GameID()
EndFunc

Func _VRUB_LOOP_1()
	Exit
EndFunc

Func _LOOP_2()
	Sleep(100)
	Local $WinName_ACTIVE = WinGetTitle("[ACTIVE]")
	If $WinName_ACTIVE = "" Or $WinName_ACTIVE = "Oculus" Or $WinName_ACTIVE = "Vive Home" Or $WinName_ACTIVE = "SteamVR-Status" Or $WinName_ACTIVE = "SteamVR Status" Or $WinName_ACTIVE = "Home Loader" Or $WinName_ACTIVE = $WinName Then _Restart_HomeLoader()

	_LOOP_3()
EndFunc

Func _LOOP_3()
	Sleep(100)
	_Exit()
EndFunc

#endregion

#Region Main
Func _Create_JanusVR_Page()
	$Install_DIR_replaced = StringReplace($Install_DIR, '\', '/')
	FileWrite($JanusVR_Page, '<!-- Written with Janus VR.  URL: file:///' & $Install_DIR_replaced & ' -->' & @CRLF & _
								'<html>' & @CRLF & _
								'<head>' & @CRLF & _
								'<title>Showcase Room</title>' & @CRLF & _
								'<meta charset="utf-8">' & @CRLF & _
								'</head>' & @CRLF & _
								'<body>' & @CRLF & _
								'<!--' & @CRLF & _
								'<FireBoxRoom>' & @CRLF & _
								'<Assets>' & @CRLF & _
								'<AssetObject id="Main" src="Walls_Roof_And_Floor.dae" />' & @CRLF & _
								'<AssetObject id="Wall_Frame_1" src="PictureFrame_1.obj" />' & @CRLF & _
								'<AssetObject id="Wall_Frame_2" src="PictureFrame_2.obj" />' & @CRLF & _
								'<AssetObject id="Wall_Frame_3" src="PictureFrame_3.obj" />' & @CRLF & _
								'<AssetObject id="Wall_Frame_4" src="PictureFrame_4.obj" />' & @CRLF & _
								'<AssetWebSurface height="1080" id="GamePage_ALL" show_url_bar="false" src="file:///' & $Install_DIR_replaced & 'WebPage/GamePage_ALL.html" width="1920" />' & @CRLF & _
								'<AssetWebSurface height="1080" id="GamePage_Non-Steam_Appl" show_url_bar="false" src="file:///' & $Install_DIR_replaced & 'WebPage/GamePage_Non-Steam_Appl.html" width="1920" />' & @CRLF & _
								'<AssetWebSurface height="1080" id="GamePage_Custom_1" show_url_bar="false" src="file:///' & $Install_DIR_replaced & 'WebPage/GamePage_Custom_1.html" width="1920" />' & @CRLF & _
								'<AssetWebSurface height="1080" id="GamePage_Custom_2" show_url_bar="false" src="file:///' & $Install_DIR_replaced & 'WebPage/GamePage_Custom_2.html" width="1920" />' & @CRLF & _
								'</Assets>' & @CRLF & _
								'<Room visible="false" pos="-4.6 0 4.6" xdir="-0.707109 0 -0.707105" ydir="0 1 0" zdir="0.707105 0 -0.707109">' & @CRLF & _
								'<Object id="Main" lighting="false" cull_face="none" collision_id="Main" />' & @CRLF & _
								'<Object id="Wall_Frame_1" pos="0 1 -2" websurface_id="GamePage_ALL" />' & @CRLF & _
								'<Object id="Wall_Frame_2" pos="0 0 0" websurface_id="GamePage_Non-Steam_Appl" />' & @CRLF & _
								'<Object id="Wall_Frame_3" pos="0 1 -2" websurface_id="GamePage_Custom_1" />' & @CRLF & _
								'<Object id="Wall_Frame_4" pos="0 0 0" websurface_id="GamePage_Custom_2" />' & @CRLF & _
								'</Room>' & @CRLF & _
								'</FireBoxRoom>' & @CRLF & _
								'-->' & @CRLF & _
								'<script src="https://web.janusvr.com/janusweb.js"></script>' & @CRLF & _
								'<script>elation.janusweb.init({url: document.location.href})</script>' & @CRLF & _
								'</body>' & @CRLF & _
								'</html>')
EndFunc


Func _Get_ADD_PlayersOnline_DATA()
	Local $FileList = _FileListToArray($Icons , "*.jpg" , 1)

	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " Start adding PO values to icons: " & "<.jpg Files found = " & $FileList[0] & ">")

	If $FileList <> "" Then
		For $NR = 1 To $FileList[0]
			$Check_AppId = StringReplace($FileList[$NR], 'steam.app.', '')
			$Check_AppId = StringReplace($Check_AppId, '.jpg', '')

			Local $sHTML = _INetGetSource('https://steamdb.info/app/' & $Check_AppId & '/graphs/')

			Local $iPosition_1 = StringInStr($sHTML, '<li><strong>')
			Local $iPosition_2 = StringInStr($sHTML, '</strong><em>all-time peak')
			Local $iPosition_3 = $iPosition_2 - $iPosition_1

			Local $sString = StringMid($sHTML, $iPosition_1, $iPosition_3)
			Global $aArray = StringSplit($sString, '<li><strong>', $STR_ENTIRESPLIT)

			If $aArray[0] > 1 Then
				Global $PlayersOnline_right_now = StringSplit($aArray[2], '<')
				$PlayersOnline_right_now = $PlayersOnline_right_now[1]
				Global $PlayersOnline_24h_peak = StringSplit($aArray[3], '<')
				$PlayersOnline_24h_peak = $PlayersOnline_24h_peak[1]
				Global $PlayersOnline_all_time_peak = StringSplit($aArray[4], '<')
				$PlayersOnline_all_time_peak = $PlayersOnline_all_time_peak[1]

				Local $NR_Apps = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "NR", "")

				IniWrite($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "right_now", $PlayersOnline_right_now)
				IniWrite($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "24h_peak", $PlayersOnline_24h_peak)
				IniWrite($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "all_time_peak", $PlayersOnline_all_time_peak)

				IniWrite($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $NR_Apps, "right_now", $PlayersOnline_right_now)
				IniWrite($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $NR_Apps, "24h_peak", $PlayersOnline_24h_peak)
				IniWrite($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $NR_Apps, "all_time_peak", $PlayersOnline_all_time_peak)

				_Write_PO_TEXT_2_Image()
				_Write_PO_Image_2_Image()
				_Copy_Icon_2_Icon_Folder()

				$PlayersOnline_right_now = ""
				$PlayersOnline_24h_peak = ""
				$PlayersOnline_all_time_peak = ""
				$Check_AppId = ""
			EndIf
		Next
	EndIf
	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " End adding PO values to icons: " & "<.jpg Files found = " & $FileList[0] & ">")
EndFunc

Func _Write_PO_TEXT_2_Image()
	_GDIPlus_Startup()
	Global $hImage = _GDIPlus_WTOB($gfx & "PlayersOnline.jpg", $PlayersOnline_right_now, "Arial", 45, -1, 3, 0, 0,  0x00CCFF, 1, 1)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	If FileExists(@ScriptDir & "\" & "WTOB.png") Then
		FileCopy(@ScriptDir & "\" & "WTOB.png", @ScriptDir & "\PlayersOnline" & ".jpg", $FC_OVERWRITE + $FC_CREATEPATH)
		FileDelete(@ScriptDir & "\" & "WTOB.png")
	EndIf
EndFunc

Func _Write_PO_Image_2_Image()
	Global $ImageSizeX = 460, $ImageSizeY = 215
	Global $FAVImageSizeX = 60, $FAVImageSizeY = 60

	$hImage1_Path = $Icons & "steam.app." & $Check_AppId & ".jpg"
	$hImage2_Path = @ScriptDir & "\" & "PlayersOnline.jpg"

	$Check_StringSplit_NR = StringInStr($hImage1_Path, "/", "", -1)
	If $Check_StringSplit_NR = "0" Then $Check_StringSplit_NR = StringInStr($hImage1_Path, "\", "", -1)
	$Check_Filename_1 = StringTrimLeft($hImage1_Path, $Check_StringSplit_NR)
	$Check_Filename_2 = StringRight($Check_Filename_1, 11)
	$Check_Filename = $Check_Filename_1

	GUISetState()

	_GDIPlus_Startup()
	$hImage1 = _GDIPlus_ImageLoadFromFile($hImage1_Path)
	$hImage2 = _GDIPlus_ImageLoadFromFile($hImage2_Path)

	$hBMPBuff = _GDIPlus_ImageLoadFromFile($hImage1_Path)
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff)

	;Graphics here
	_GDIPlus_GraphicsClear($hGraphic, 0xFFE8FFE8)

	$hPen = _GDIPlus_PenCreate(0xFFFF0000, 3)

	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage1, 0, 0, $ImageSizeX, $ImageSizeY)
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage2, 3, 3, $FAVImageSizeX, $FAVImageSizeY)

	_GDIPlus_GraphicsDrawRect($hGraphic, 1, 1, 60 + 3, 60 + 3, $hPen); $hPen 3 pixels thick

	GUIRegisterMsg(0xF, "MY_PAINT"); Register PAINT-Event 0x000F = $WM_PAINT (WindowsConstants.au3)
	GUIRegisterMsg(0x85, "MY_PAINT") ; $WM_NCPAINT = 0x0085 (WindowsConstants.au3)Restore after Minimize.

	;Save composite image
	Local $sNewName = $Icons & "460x215\" & $Check_Filename
	$NewIcon_Path = $sNewName

	_GDIPlus_ImageSaveToFile($hBMPBuff, $NewIcon_Path) ; $hBMPBuff the bitmap

	_GDIPlus_PenDispose($hPen)
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
	_GDIPlus_GraphicsDispose($hGraphic)
	_WinAPI_DeleteObject($hBMPBuff)
	_GDIPlus_Shutdown()

	_Quit_PO_Image_2_Image()
EndFunc

Func MY_PAINT($hWnd, $msg, $wParam, $lParam)
    Return $GUI_RUNDEFMSG
EndFunc

Func _Quit_PO_Image_2_Image()
	FileDelete(@ScriptDir & "\PlayersOnline" & ".jpg")
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _GDIPlus_GraphicsDispose($hGraphic)
    _WinAPI_DeleteObject($hBMPBuff)
    _GDIPlus_Shutdown()
EndFunc

Func _Copy_Icon_2_Icon_Folder()
	If $Icon_Folder_3 <> "" Then
		If FileExists($Icon_Folder_3 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_3 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_3 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_1 <> "" Then
		If FileExists($Icon_Folder_1 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_1 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_1 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_2 <> "" Then
		If FileExists($Icon_Folder_2 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_2 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_2 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_4 <> "" Then
		If FileExists($Icon_Folder_4 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_4 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_4 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_4 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_4 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_4 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_4 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_5 <> "" Then
		If FileExists($Icon_Folder_5 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_5 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_5 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_5 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_5 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_5 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_5 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf
EndFunc

Func _Ident_GameID()
	Sleep(500)
	$Steam_stats_log_txt = $Install_Folder_Steam_1 & "\logs\stats_log.txt"

	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_1 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_2 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_3 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_4 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_5 & "\logs\stats_log.txt"

	Local $Steam_stats_log_Lines = _FileCountLines($Steam_stats_log_txt)
	Local $Steam_stats_log_Value = FileReadLine($Steam_stats_log_txt, - 1)
	Local $Steam_stats_log_Value_2 = FileReadLine($Steam_stats_log_txt, $Steam_stats_log_Lines - 1)

	;Current
	Local $AppID_POS_1 = StringInStr($Steam_stats_log_Value, "[", 0, 2)
	Local $StringTrim_1 = StringTrimLeft($Steam_stats_log_Value, $AppID_POS_1)

	Local $AppID_POS_2 = StringInStr($StringTrim_1, "]", 0, 1)
	Local $StringTrim_2 = StringLeft($StringTrim_1, $AppID_POS_2)

	Local $StringReplace_1 = StringReplace($StringTrim_2, 'AppID ', '')
	Local $StringReplace_2 = StringReplace($StringReplace_1, ']', '')

	Local $AppID = $StringReplace_2
	Local $AppName = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $AppID, "name", "")

	;Last
	Local $AppID_last_POS_1 = StringInStr($Steam_stats_log_Value_2, "[", 0, 2)
	Local $StringTrim_last_1 = StringTrimLeft($Steam_stats_log_Value_2, $AppID_last_POS_1)

	Local $AppID_last_POS_2 = StringInStr($StringTrim_last_1, "]", 0, 1)
	Local $StringTrim_last_2 = StringLeft($StringTrim_last_1, $AppID_last_POS_2)

	Local $StringReplace_last_1 = StringReplace($StringTrim_last_2, 'AppID ', '')
	Local $StringReplace_last_2 = StringReplace($StringReplace_last_1, ']', '')

	Local $AppID_last = $StringReplace_last_2
	Local $AppName_last = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $AppID_last, "name", "")

	;Time Current
	Local $Time_SteamLog_POS_1 = StringInStr($Steam_stats_log_Value, " ", 0, 1)
	Local $Time_SteamLog_StringTrim_1 = StringTrimLeft($Steam_stats_log_Value, $Time_SteamLog_POS_1)

	Local $Time_SteamLog_POS_2 = StringInStr($Time_SteamLog_StringTrim_1, " ", 0, 1)
	Local $Time_SteamLog_StringTrim_2 = StringLeft($Time_SteamLog_StringTrim_1, $Time_SteamLog_POS_2)

	Local $Time_SteamLog_StringReplace_1 = StringReplace($Time_SteamLog_StringTrim_2, ' ', '')
	Local $Time_SteamLog_StringReplace_2 = StringReplace($Time_SteamLog_StringReplace_1, ']', '')

	Local $Time_Now_1 = $Time_SteamLog_StringReplace_2

	;Time last
	Local $Time_SteamLog_POS_1 = StringInStr($Steam_stats_log_Value_2, " ", 0, 1)
	Local $Time_SteamLog_StringTrim_1 = StringTrimLeft($Steam_stats_log_Value_2, $Time_SteamLog_POS_1)

	Local $Time_SteamLog_POS_2 = StringInStr($Time_SteamLog_StringTrim_1, " ", 0, 1)
	Local $Time_SteamLog_StringTrim_2 = StringLeft($Time_SteamLog_StringTrim_1, $Time_SteamLog_POS_2)

	Local $Time_SteamLog_StringReplace_1 = StringReplace($Time_SteamLog_StringTrim_2, ' ', '')
	Local $Time_SteamLog_StringReplace_2 = StringReplace($Time_SteamLog_StringReplace_1, ']', '')

	Local $Time_Now_2 = $Time_SteamLog_StringReplace_2


	Local $Time_Now_minutes_1 = StringTrimLeft(StringTrimRight($Time_Now_1, 3), 3)
	Local $Time_Now_minutes_2 = StringTrimLeft(StringTrimRight($Time_Now_2, 3), 3)

	Local $Time_Now_seconds_1 = StringRight($Time_Now_1, 2)
	Local $Time_Now_seconds_2 = StringRight($Time_Now_2, 2)

	_Check_SteamVR_Exit()

	If $AppID <> $AppID_last Or $GameStarted = "true" Then
		WinClose($WinName)
		_GUICtrlButton_SetImage($Button_HLStatus, $Icons & "32x32\steam.app." & $AppID & ".bmp")
		FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " App started: " & "<App ID: " & $AppID & ">" & " - " & "<App Name: " & $AppName & ">")

		$Application_name = $AppName
		$SteamGameID = $AppID
		If $Add_SS_per_game = "true" Then _Add_SS_to_SteamVR()
		_LOOP_2()
	EndIf
EndFunc

Func _Ident_ClosingGame()
	Sleep(500)
	$Steam_stats_log_txt = $Install_Folder_Steam_1 & "\logs\stats_log.txt"

	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_1 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_2 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_3 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_4 & "\logs\stats_log.txt"
	If Not FileExists($Steam_stats_log_txt) Then $Steam_stats_log_txt = $Install_Folder_Steam_5 & "\logs\stats_log.txt"

	Local $Steam_stats_log_Lines = _FileCountLines($Steam_stats_log_txt)
	Local $Steam_stats_log_Value = FileReadLine($Steam_stats_log_txt, - 1)
	Local $Steam_stats_log_Value_2 = FileReadLine($Steam_stats_log_txt, $Steam_stats_log_Lines - 1)

	Local $AppID_POS_1 = StringInStr($Steam_stats_log_Value, "[", 0, 2)
	Local $StringTrim_1 = StringTrimLeft($Steam_stats_log_Value, $AppID_POS_1)

	Local $AppID_POS_2 = StringInStr($StringTrim_1, "]", 0, 1)
	Local $StringTrim_2 = StringLeft($StringTrim_1, $AppID_POS_2)

	Local $StringReplace_1 = StringReplace($StringTrim_2, 'AppID ', '')
	Local $StringReplace_2 = StringReplace($StringReplace_1, ']', '')

	Local $AppID = $StringReplace_2
	Local $AppName = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $AppID, "name", "")

	Local $CloseGameCheck = StringInStr($Steam_stats_log_Value, "CAPIJobStoreUserStats")
	;If $CloseGameCheck = 0 Then $CloseGameCheck = StringInStr($Steam_stats_log_Value_2, "CAPIJobStoreUserStats")

	If $CloseGameCheck <> 0 Then
		$GameClosed = "true"
		;MsgBox(0, $CloseGameCheck, $GameClosed & @CRLF & @CRLF & $Steam_stats_log_Value & @CRLF & @CRLF & $Steam_stats_log_Value_2)
	Else
		$GameClosed = "false"
	EndIf

	If $GameClosed = "true" Then
		_GUICtrlButton_SetImage($Button_HLStatus, $gfx & "HLStatus_1.bmp")
		FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " App closed: " & "<App ID: " & $AppID & ">" & " - " & "<App Name: " & $AppName & ">")
		_LOOP_3()
	EndIf
EndFunc

Func _Add_SS_to_SteamVR()
	If Not FileExists($default_vrsettings_File_BAK) Then FileCopy($default_vrsettings_File, $default_vrsettings_File_BAK, $FC_OVERWRITE)

	Local $Steam_app_Name = $Application_name
	Local $Game_ID = $SteamGameID

	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " Starting adding SS to SteamVR: " & "<App ID: " & $Game_ID & ">" & " - " & "<App Name: " & $Steam_app_Name & ">")

	$FileLines = _FileCountLines($default_vrsettings_File)

	$default_renderTargetMultiplier_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Game_ID, "default_renderTargetMultiplier", "1.0")
	$default_supersampleScale_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Game_ID, "default_supersampleScale", "1.0")
	$default_allowSupersampleFiltering_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Game_ID, "default_allowSupersampleFiltering", "true")

	Local $renderTargetMultiplier_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Game_ID, "renderTargetMultiplier", $default_renderTargetMultiplier_value)
	Local $supersampleScale_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Game_ID, "supersampleScale", $default_supersampleScale_value)
	Local $allowSupersampleFiltering_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Game_ID, "allowSupersampleFiltering", $default_allowSupersampleFiltering_value)

	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " <renderTargetMultiplier: " & $renderTargetMultiplier_value & ">" & " - " & "<supersampleScale: " & $supersampleScale_value & ">" & " - " & "<allowSupersampleFiltering: " & $allowSupersampleFiltering_value & ">")

	FileWriteLine($default_vrsettings_File_new, '{')
	FileWriteLine($default_vrsettings_File_new, '	"steamvr" : {')

	For $LOOP_vrsettings = 3 To $FileLines
		Local $ReadLine = FileReadLine($default_vrsettings_File, $LOOP_vrsettings)
		Local $ReadLine_Split_value = $ReadLine

		If $ReadLine <> '	},' Then
			Local $ReadLine_Split = StringSplit($ReadLine, ':')
			$ReadLine_Split_value = StringReplace($ReadLine_Split[1], '"', '')
			$ReadLine_Split_value = StringReplace($ReadLine_Split_value, '        ', '')
			$ReadLine_Split_value = StringReplace($ReadLine_Split_value, ' ', '')
		EndIf

		If $ReadLine_Split_value = 'renderTargetMultiplier' Then
			FileWriteLine($default_vrsettings_File_new, '        "renderTargetMultiplier" : ' & $renderTargetMultiplier_value & ',')
		EndIf

		If $ReadLine_Split_value = 'supersampleScale' Then
			FileWriteLine($default_vrsettings_File_new, '        "supersampleScale" : ' & $supersampleScale_value & ',')
		EndIf

		If $ReadLine_Split_value = 'allowSupersampleFiltering' Then
			FileWriteLine($default_vrsettings_File_new, '        "allowSupersampleFiltering" : ' & $allowSupersampleFiltering_value & ',')
		EndIf

		If $ReadLine_Split_value <> 'renderTargetMultiplier' And $ReadLine_Split_value <> 'supersampleScale' And $ReadLine_Split_value <> 'allowSupersampleFiltering' Then
			FileWriteLine($default_vrsettings_File_new, $ReadLine)
		EndIf
	Next
	FileCopy($default_vrsettings_File_new, $default_vrsettings_File, $FC_OVERWRITE)
	FileDelete($default_vrsettings_File_new)
	If Not FileExists($default_vrsettings_File) Then FileCopy($default_vrsettings_File_BAK, $default_vrsettings_File, $FC_OVERWRITE)
	IniWrite($Config_INI, "TEMP", "HomeLoaderState_SSDATA", "loaded")
	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " End adding SS to SteamVR: " & "<App ID: " & $Game_ID & ">" & " - " & "<App Name: " & $Steam_app_Name & ">")
EndFunc

Func _Get_AD_SS_Values_to_Icons()
	Local $FileList = _FileListToArray($Icons & "460x215\" , "*.jpg" , 1)

	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " Start adding SS values to icons: " & "<.jpg Files found = " & $FileList[0] & ">")

	If $FileList <> "" Then
		For $NR = 1 To $FileList[0]
			$Check_AppId = StringReplace($FileList[$NR], 'steam.app.', '')
			$Check_AppId = StringReplace($Check_AppId, '.jpg', '')

			Local $SS_Value_Check = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "renderTargetMultiplier", "")

			Local $renderTargetMultiplier_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "renderTargetMultiplier", "1.0")
			Local $supersampleScale_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "supersampleScale", "1.0")
			Local $allowSupersampleFiltering_value = IniRead($ApplicationList_SteamLibrary_ALL_INI, "Application_" & $Check_AppId, "allowSupersampleFiltering", "true")

			Global $Value_for_Image = $renderTargetMultiplier_value & " / " & $supersampleScale_value

			If $SS_Value_Check <> "" Then
				_Write_SS_TEXT_2_Image()
				_Write_SS_Image_2_Image()
				_Copy_SS_Icon_2_Icon_Folder()
			EndIf

			$renderTargetMultiplier_value = ""
			$supersampleScale_value = ""
			$allowSupersampleFiltering_value = ""
			$Check_AppId = ""
		Next
	EndIf
	FileWriteLine($stats_log_FILE, "[" & _Now() & "]" & " End adding SS values to icons: " & "<.jpg Files found = " & $FileList[0] & ">")
EndFunc

Func _Write_SS_TEXT_2_Image()
	_GDIPlus_Startup()
	Global $hImage = _GDIPlus_WTOB($gfx & "SS_Values.jpg", $Value_for_Image, "Arial", 45, -1, 3, 0, 0,  0x00CCFF, 1, 1)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	If FileExists(@ScriptDir & "\" & "WTOB.png") Then
		FileCopy(@ScriptDir & "\" & "WTOB.png", @ScriptDir & "\SS_Values" & ".jpg", $FC_OVERWRITE + $FC_CREATEPATH)
		FileDelete(@ScriptDir & "\" & "WTOB.png")
	EndIf
EndFunc

Func _Write_SS_Image_2_Image()
	Global $ImageSizeX = 460, $ImageSizeY = 215
	Global $FAVImageSizeX = 200, $FAVImageSizeY = 60

	$hImage1_Path = $Icons & "460x215\" & "steam.app." & $Check_AppId & ".jpg"
	$hImage2_Path = @ScriptDir & "\" & "SS_Values.jpg"

	;MsgBox($MB_ICONINFORMATION, $Check_AppId, $hImage1_Path & @CRLF & @CRLF & $hImage2_Path)

	$Check_StringSplit_NR = StringInStr($hImage1_Path, "/", "", -1)
	If $Check_StringSplit_NR = "0" Then $Check_StringSplit_NR = StringInStr($hImage1_Path, "\", "", -1)
	$Check_Filename_1 = StringTrimLeft($hImage1_Path, $Check_StringSplit_NR)
	$Check_Filename_2 = StringRight($Check_Filename_1, 11)
	$Check_Filename = $Check_Filename_1

	GUISetState()

	_GDIPlus_Startup()
	$hImage1 = _GDIPlus_ImageLoadFromFile($hImage1_Path)
	$hImage2 = _GDIPlus_ImageLoadFromFile($hImage2_Path)

	$hBMPBuff = _GDIPlus_ImageLoadFromFile($hImage1_Path)
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff)

	;Graphics here
	_GDIPlus_GraphicsClear($hGraphic, 0xFFE8FFE8)

	$hPen = _GDIPlus_PenCreate(0xFFFF0000, 3)

	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage1, 0, 0, $ImageSizeX, $ImageSizeY)
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage2, 257, 152, $FAVImageSizeX, $FAVImageSizeY)

	_GDIPlus_GraphicsDrawRect($hGraphic, 255, 150, 200 + 3, 60 + 3, $hPen); $hPen 3 pixels thick

	GUIRegisterMsg(0xF, "MY_PAINT"); Register PAINT-Event 0x000F = $WM_PAINT (WindowsConstants.au3)
	GUIRegisterMsg(0x85, "MY_PAINT") ; $WM_NCPAINT = 0x0085 (WindowsConstants.au3)Restore after Minimize.

	;Save composite image
	Local $sNewName = $Icons & "460x215\SS_Values\" & $Check_Filename
	$NewIcon_Path = $sNewName
	_GDIPlus_ImageSaveToFile($hBMPBuff, $NewIcon_Path) ; $hBMPBuff the bitmap

	_GDIPlus_PenDispose($hPen)
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
	_GDIPlus_GraphicsDispose($hGraphic)
	_WinAPI_DeleteObject($hBMPBuff)
	_GDIPlus_Shutdown()

	_Quit_SS_Image_2_Image()
EndFunc

Func _Quit_SS_Image_2_Image()
	FileDelete(@ScriptDir & "\SS_Values." & ".jpg")
	FileDelete(@ScriptDir & "\System\SS_Values." & ".jpg")
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _GDIPlus_GraphicsDispose($hGraphic)
    _WinAPI_DeleteObject($hBMPBuff)
    _GDIPlus_Shutdown()
EndFunc

Func _Copy_SS_Icon_2_Icon_Folder()
	;FileCopy($NewIcon_Path, $Icons & "460x215\", $FC_OVERWRITE)
	;MsgBox(0, "", $NewIcon_Path & @CRLF & @CRLF & $Icons & "460x215\" & "steam.app." & $Check_AppId & ".jpg")
	If $Icon_Folder_1 <> "" Then
		If FileExists($Icon_Folder_1 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_1 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_1 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_1 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_2 <> "" Then
		If FileExists($Icon_Folder_2 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_2 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_2 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_2 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_3 <> "" Then
		If FileExists($Icon_Folder_3 & $Check_AppId & "_header" & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_3 & $Check_AppId & "_header" & ".jpg", $FC_OVERWRITE)
		If FileExists($Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg") Then FileCopy($NewIcon_Path, $Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)

		If Not FileExists($Icon_Folder_3 & $Check_AppId & "_header" & ".jpg") And Not FileExists($Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg") Then
			FileCopy($NewIcon_Path, $Icon_Folder_3 & "steam.app." & $Check_AppId & ".jpg", $FC_OVERWRITE)
		EndIf
	EndIf

	If $Icon_Folder_1 = "" And $Icon_Folder_2 = "" And $Icon_Folder_3 = "" Then
		MsgBox($MB_ICONWARNING, "", "You need at least one Icon Folder path." & @CRLF & "Go to settings menu and enter an Icon path." & @CRLF & "Or disable the 'Add PlayersOnline to Icons function'.")
	EndIf
EndFunc

Func _Min_Close_Oculus()
	If $Status_Checkbox_Minimize_OVRS = "true" Then
		If WinExists("Oculus") Then WinSetState("Oculus", "", @SW_MINIMIZE)
	EndIf
	If $Status_Checkbox_Close_OVRS = "true" Then
		If WinExists("Oculus") Then WinClose("Oculus")
	EndIf
EndFunc

Func _Check_SteamVR_Exit()
	If Not ProcessExists("vrmonitor.exe") Then
		GUICtrlSetData($GUI_Label, "SteamVR closed.")
		GUISetBkColor($Yellow)
		_Exit()
	EndIf
EndFunc

Func _Start_StartSteamVRHome()
	If FileExists($HomeLoader_StartBat) Then
		ShellExecute($HomeLoader_StartBat, "", $System_DIR)
	Else
		If FileExists($System_DIR & "StartSteamVRHome.exe") Then
			ShellExecute($System_DIR & "StartSteamVRHome.exe", "", $System_DIR)
		Else
			ShellExecute($System_DIR & "StartSteamVRHome.au3", "", $System_DIR)
		EndIf
	EndIf
	Exit
EndFunc

Func _FirstStart_Restart()
	If FileExists($System_DIR & "HomeLoaderLibrary.exe") Then
		ShellExecute($System_DIR & "HomeLoaderLibrary.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "HomeLoaderLibrary.au3", "", $System_DIR)
	EndIf
	Exit
EndFunc

Func _Restart_HomeLoader()
	Local $stats_log_FILE_Lines = _FileCountLines($stats_log_FILE)
	If $stats_log_FILE_Lines > 400 Then FileDelete($stats_log_FILE)
	IniWrite($Config_INI, "TEMP", "StartHomeLoader", "true")
	If FileExists($System_DIR & "HomeLoader.exe") Then
		ShellExecute($System_DIR & "HomeLoader.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "HomeLoader.au3", "", $System_DIR)
	EndIf
	Sleep(5000)
	Exit
EndFunc

Func _Exit()
	FileDelete(@ScriptDir & "\SS_Values." & ".jpg")
	FileDelete(@ScriptDir & "\System\SS_Values." & ".jpg")
	Exit
EndFunc

#endregion

#Region Home Loader Functions
Func _StartGame_Check()
	If FileExists($Install_DIR & "WebPage\temp.txt") Then
		$SteamGameID = FileRead($Install_DIR & "WebPage\temp.txt")
		$ApplicationList_Read = $ApplicationList_SteamLibrary_ALL_INI
		Local $Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")

		If $Application_appid = "" Then
			$ApplicationList_Read = $ApplicationList_Non_Steam_Appl_INI
			$Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")
		EndIf

		If $Application_appid = "" Then
			$ApplicationList_Read = $ApplicationList_Custom_1_INI
			$Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")
		EndIf

		If $Application_appid = "" Then
			$ApplicationList_Read = $ApplicationList_Custom_2_INI
			$Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")
		EndIf

		If $Application_appid = "" Then
			$ApplicationList_Read = $ApplicationList_Custom_3_INI
			$Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")
		EndIf

		If $Application_appid = "" Then
			$ApplicationList_Read = $ApplicationList_Custom_4_INI
			$Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")
		EndIf

		Local $Application_appid = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "appid", "")
		Global $Application_name = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "name", "")
		Local $Application_installdir = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "installdir", "")
		Local $Application_IconPath = IniRead($ApplicationList_Read, "Application_" & $SteamGameID, "IconPath", "")


		If ProcessExists("vrmonitor.exe") Then
			TrayTip("Home Loader", "App started: " & @CRLF & $Application_name, 5, $TIP_ICONASTERISK)

			GUICtrlSetData($GUI_Label, $Application_name)
			GUISetBkColor($Blue)


			If StringLeft($Application_appid, 2) <> "HL" Then
				If WinExists("Janus VR") Then WinClose("Janus VR")
				If WinExists($WinName) Then WinClose($WinName)
				If $Add_SS_per_game = "true" Then _Add_SS_to_SteamVR()
				ShellExecuteWait("steam://rungameid/" & $SteamGameID)
			Else
				If WinExists("Janus VR") Then WinClose("Janus VR")
				If WinExists($WinName) Then WinClose($WinName)
				If $Add_SS_per_game = "true" Then _Add_SS_to_SteamVR()
				ShellExecuteWait($Application_installdir)
			EndIf

			Sleep(4000)
			_Ident_GameID()
			$GameStarted_State = "true"
			$GameNameStarted = WinGetTitle("[ACTIVE]")
			If FileExists($Install_DIR & "WebPage\temp.txt") Then FileDelete($Install_DIR & "WebPage\temp.txt")
			Do
				GUICtrlSetData($GUI_Label, $GameNameStarted)
				GUISetBkColor($Blue)
				Sleep(2000)
				If Not WinExists($GameNameStarted) Then $GameStarted_State = "false"
			Until $GameStarted_State = "false"

			If FileExists($Install_DIR & "WebPage\temp.txt") Then FileDelete($Install_DIR & "WebPage\temp.txt")
			Sleep(3000)
		EndIf
		Exit
	EndIf
EndFunc
#endregion

#Region RM Functions
Func _Button_HLStatus()
	$DefaultClickAction = IniRead($Config_INI, "TEMP", "DefaultClickAction", "")

	If $DefaultClickAction = "RM_Item10_1" Then ; Game Page - All Applications
		_RM_Item1_1()
	EndIf

	If $DefaultClickAction = "RM_Item10_2" Then ; Game Page - Non-Steam Applications
		_RM_Item1_2()
	EndIf

	If $DefaultClickAction = "RM_Item10_3" Then ; Game Page - Custom 1
		_RM_Item1_3()
	EndIf

	If $DefaultClickAction = "RM_Item10_4" Then ; Game Page - Custom 2
		_RM_Item1_4()
	EndIf

	If $DefaultClickAction = "RM_Item10_5" Then ; Game Page - Custom 3
		_RM_Item1_5()
	EndIf

	If $DefaultClickAction = "RM_Item10_6" Then ; Game Page - Custom 4
		_RM_Item1_6()
	EndIf

	If $DefaultClickAction = "RM_Item10_7" Then ; Home Loader Library
		RM_Item3()
	EndIf

	If $DefaultClickAction = "RM_Item10_8" Then ; Playlist
		RM_Item4()
	EndIf

	If $DefaultClickAction = "RM_Item10_9" Then ; Supersampling Menu
		RM_Item5()
	EndIf

	If $DefaultClickAction = "RM_Item10_10" Then ; Start SteamVR Home APP
		RM_Item6()
	EndIf

	If $DefaultClickAction = "RM_Item10_11" Then ; Settings
		RM_Item7()
	EndIf

	If $DefaultClickAction = "RM_Item10_12" Then ; Restart Home Loader
		_Restart_HomeLoader()
	EndIf

	If $DefaultClickAction = "RM_Item10_13" Then ; Exit
		GUIDelete($GUI)
		Exit
	EndIf

	If $DefaultClickAction = "" Then ; Empty
		GUIDelete($GUI)
		Exit
	EndIf
EndFunc

Func _RM_Item1_1()
	Local $GamePage_URL = $Install_DIR & "WebPage\GamePage_ALL.html"

	If FileExists($GamePage_URL) Then
		ShellExecute($GamePage_URL)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Game Page missing.", "Game Page does not exist." & @CRLF & _
																		"'" & $GamePage_URL & "'" & @CRLF & @CRLF & _
																		"Create a new Game Page first using the 'Create Game Page' Button.")
	EndIf
EndFunc

Func _RM_Item1_2()
	Local $GamePage_URL = $Install_DIR & "WebPage\GamePage_Non-Steam_Appl.html"

	If FileExists($GamePage_URL) Then
		ShellExecute($GamePage_URL)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Game Page missing.", "Game Page does not exist." & @CRLF & _
																		"'" & $GamePage_URL & "'" & @CRLF & @CRLF & _
																		"Create a new Game Page first using the 'Create Game Page' Button.")
	EndIf
EndFunc

Func _RM_Item1_3()
	Local $GamePage_URL = $Install_DIR & "WebPage\GamePage_Custom_1.html"

	If FileExists($GamePage_URL) Then
		ShellExecute($GamePage_URL)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Game Page missing.", "Game Page does not exist." & @CRLF & _
																		"'" & $GamePage_URL & "'" & @CRLF & @CRLF & _
																		"Create a new Game Page first using the 'Create Game Page' Button.")
	EndIf
EndFunc

Func _RM_Item1_4()
	Local $GamePage_URL = $Install_DIR & "WebPage\GamePage_Custom_2.html"

	If FileExists($GamePage_URL) Then
		ShellExecute($GamePage_URL)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Game Page missing.", "Game Page does not exist." & @CRLF & _
																		"'" & $GamePage_URL & "'" & @CRLF & @CRLF & _
																		"Create a new Game Page first using the 'Create Game Page' Button.")
	EndIf
EndFunc

Func _RM_Item1_5()
	Local $GamePage_URL = $Install_DIR & "WebPage\GamePage_Custom_3.html"

	If FileExists($GamePage_URL) Then
		ShellExecute($GamePage_URL)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Game Page missing.", "Game Page does not exist." & @CRLF & _
																		"'" & $GamePage_URL & "'" & @CRLF & @CRLF & _
																		"Create a new Game Page first using the 'Create Game Page' Button.")
	EndIf
EndFunc

Func _RM_Item1_6()
	Local $GamePage_URL = $Install_DIR & "WebPage\GamePage_Custom_4.html"

	If FileExists($GamePage_URL) Then
		ShellExecute($GamePage_URL)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Game Page missing.", "Game Page does not exist." & @CRLF & _
																		"'" & $GamePage_URL & "'" & @CRLF & @CRLF & _
																		"Create a new Game Page first using the 'Create Game Page' Button.")
	EndIf
EndFunc


Func RM_Item3()
	IniWrite($Config_INI, "TEMP", "Show_Playlist", "")
	If FileExists($System_DIR & "HomeLoaderLibrary.exe") Then
		ShellExecute($System_DIR & "HomeLoaderLibrary.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "HomeLoaderLibrary.au3", "", $System_DIR)
	EndIf
EndFunc

Func RM_Item4()
	IniWrite($Config_INI, "TEMP", "Show_Playlist", "true")
	If FileExists($System_DIR & "HomeLoaderLibrary.exe") Then
		ShellExecute($System_DIR & "HomeLoaderLibrary.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "HomeLoaderLibrary.au3", "", $System_DIR)
	EndIf
EndFunc

Func RM_Item5()
	IniWrite($Config_INI, "TEMP", "Show_SS_Menu", "true")
	If FileExists($System_DIR & "HomeLoaderLibrary.exe") Then
		ShellExecute($System_DIR & "HomeLoaderLibrary.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "HomeLoaderLibrary.au3", "", $System_DIR)
	EndIf
EndFunc

Func RM_Item6()
	If FileExists($System_DIR & "StartSteamVRHome.exe") Then
		ShellExecute($System_DIR & "StartSteamVRHome.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "StartSteamVRHome.au3", "", $System_DIR)
	EndIf
EndFunc

Func RM_Item7()
	If FileExists($System_DIR & "Settings.exe") Then
		ShellExecute($System_DIR & "Settings.exe", "", $System_DIR)
	Else
		ShellExecute($System_DIR & "Settings.au3", "", $System_DIR)
	EndIf
EndFunc


Func _RM_Item10_1()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_1")
EndFunc

Func _RM_Item10_2()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_2")
EndFunc

Func _RM_Item10_3()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_3")
EndFunc

Func _RM_Item10_4()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_4")
EndFunc

Func _RM_Item10_5()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_5")
EndFunc

Func _RM_Item10_6()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_6")
EndFunc

Func _RM_Item10_7()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_7")
EndFunc

Func _RM_Item10_8()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_8")
EndFunc

Func _RM_Item10_9()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_9")
EndFunc

Func _RM_Item10_10()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_10")
EndFunc

Func _RM_Item10_11()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_11")
EndFunc

Func _RM_Item10_12()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_12")
EndFunc

Func _RM_Item10_13()
	IniWrite($Config_INI, "TEMP", "DefaultClickAction", "RM_Item10_13")
EndFunc

#endregion

#Region Restart/Exit
Func _Start_HomeLoaderLibrary_UpdateOverlay()
	If FileExists($System_DIR & "HomeLoaderLibrary.exe") Then
		ShellExecute($System_DIR & "HomeLoaderLibrary.exe", "UpdateOverlay", $System_DIR)
	Else
		ShellExecute($System_DIR & "HomeLoaderLibrary.au3", "UpdateOverlay", $System_DIR)
	EndIf
EndFunc
#endregion



