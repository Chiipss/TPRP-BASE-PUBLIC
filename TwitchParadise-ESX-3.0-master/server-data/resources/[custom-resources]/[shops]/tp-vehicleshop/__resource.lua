resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
ui_page 'ProgressBar/h.html'
client_scripts {
	-- Base
	'JAM_Main.lua',
	'JAM_Client.lua',
	'JAM_Utilities.lua',

  -- Notify
  'JAM_Notify/JAM_Notify_Client.lua',

  -- Progress Bar
  'ProgressBar/ProgressBar_Client.lua',

	-- DNATracker
	'JAM_DNATracker/JAM_DNATracker_Config.lua',
	'JAM_DNATracker/JAM_DNATracker_Client.lua',

  -- Ping  'JAM_Ping/JAM_Ping_Config.lua',
  --'JAM_Ping/JAM_Ping_Client.lua',

  -- Skelly System
 -- 'JAM_SkeletalSystem/JAM_SkeletalSystem_Config.lua',
 -- 'JAM_SkeletalSystem/JAM_SkeletalSystem_Client.lua',

    -- VehicleShop
  'JAM_VehicleShop/JAM_VehicleShop_Config.lua', 
  'JAM_VehicleShop/JAM_VehicleShop_Client.lua',
  --'JAM_ImportShop/JAM_ImportShop_Config.lua', 
  --'JAM_ImportShop/JAM_ImportShop_Client.lua',

  -- VehicleFinance  
  'JAM_VehicleFinance/JAM_VehicleFinance_Config.lua', 
  'JAM_VehicleFinance/JAM_VehicleFinance_Client.lua',
--  'JAM_VehicleFinance2/JAM_VehicleFinance2_Config.lua', 
--  'JAM_VehicleFinance2/JAM_VehicleFinance2_Client.lua',


  -- Dope Plant
 -- 'JAM_DopePlant/JAM_DopePlant_Config.lua',
 -- 'JAM_DopePlant/JAM_DopePlant_Client.lua',

	-- NativeUI
	"NativeUILua-Reloaded/Wrapper/Utility.lua",

  "NativeUILua-Reloaded/UIElements/UIVisual.lua",
  "NativeUILua-Reloaded/UIElements/UIResRectangle.lua",
  "NativeUILua-Reloaded/UIElements/UIResText.lua",
  "NativeUILua-Reloaded/UIElements/Sprite.lua",

  "NativeUILua-Reloaded/UIMenu/elements/Badge.lua",
  "NativeUILua-Reloaded/UIMenu/elements/Colours.lua",
  "NativeUILua-Reloaded/UIMenu/elements/ColoursPanel.lua",
  "NativeUILua-Reloaded/UIMenu/elements/StringMeasurer.lua",

  "NativeUILua-Reloaded/UIMenu/items/UIMenuItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuCheckboxItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuListItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuSliderItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuSliderHeritageItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuColouredItem.lua",

  "NativeUILua-Reloaded/UIMenu/items/UIMenuProgressItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuSliderProgressItem.lua",

  "NativeUILua-Reloaded/UIMenu/windows/UIMenuHeritageWindow.lua",

  "NativeUILua-Reloaded/UIMenu/panels/UIMenuGridPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuColourPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuPercentagePanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuStatisticsPanel.lua",

  "NativeUILua-Reloaded/UIMenu/UIMenu.lua",
  "NativeUILua-Reloaded/UIMenu/MenuPool.lua",

  "NativeUILua-Reloaded/UITimerBar/UITimerBarPool.lua",

  "NativeUILua-Reloaded/UITimerBar/items/UITimerBarItem.lua",
  "NativeUILua-Reloaded/UITimerBar/items/UITimerBarProgressItem.lua",
  "NativeUILua-Reloaded/UITimerBar/items/UITimerBarProgressWithIconItem.lua",

  "NativeUILua-Reloaded/UIProgressBar/UIProgressBarPool.lua",
  "NativeUILua-Reloaded/UIProgressBar/items/UIProgressBarItem.lua",

  "NativeUILua-Reloaded/NativeUI.lua",
}

server_scripts {	
	-- Base
	'JAM_Main.lua',
	'JAM_Server.lua',
	'JAM_Utilities.lua',

	-- MySQL
	'@mysql-async/lib/MySQL.lua',

	-- DNATracker
	'JAM_DNATracker/JAM_DNATracker_Config.lua',
	'JAM_DNATracker/JAM_DNATracker_Server.lua',

  -- Ping
 -- 'JAM_Ping/JAM_Ping_Config.lua',
 -- 'JAM_Ping/JAM_Ping_Server.lua',

  -- Skelly System
 -- 'JAM_SkeletalSystem/JAM_SkeletalSystem_Config.lua',
 -- 'JAM_SkeletalSystem/JAM_SkeletalSystem_Server.lua',

	-- VehicleShop
	'JAM_VehicleShop/JAM_VehicleShop_Config.lua',	
	'JAM_VehicleShop/JAM_VehicleShop_Server.lua',
	--'JAM_ImportShop/JAM_ImportShop_Config.lua',	
	--'JAM_ImportShop/JAM_ImportShop_Server.lua',

	-- VehicleFinance
	'JAM_VehicleFinance/JAM_VehicleFinance_Config.lua',	
	'JAM_VehicleFinance/JAM_VehicleFinance_Server.lua',
	--'JAM_VehicleFinance2/JAM_VehicleFinance2_Config.lua',	
	--'JAM_VehicleFinance2/JAM_VehicleFinance2_Server.lua',

  -- Dope Plant
  'JAM_DopePlant/JAM_DopePlant_Config.lua',
  'JAM_DopePlant/JAM_DopePlant_Server.lua',
}

files {	
 -- 'JAM_SkeletalSystem/SKELLY_Base.png',
 -- 'JAM_SkeletalSystem/SKELLY_Head.png',
  --'JAM_SkeletalSystem/SKELLY_Body.png',
 -- 'JAM_SkeletalSystem/SKELLY_LeftLeg.png',
 -- 'JAM_SkeletalSystem/SKELLY_RightLeg.png',
 -- 'JAM_SkeletalSystem/SKELLY_LeftArm.png',
--  'JAM_SkeletalSystem/SKELLY_RightArm.png',
  'ProgressBar/h.html',
}

export "startUI"