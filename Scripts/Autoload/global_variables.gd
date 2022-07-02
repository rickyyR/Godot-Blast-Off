# GlobalVariables Autoload
# For storing variables accessed by multiple objects
extends Node
# You can add more resolutions to this array
# They will be integrated into the Option Menus Resolution Dropdown
const window_resolutions:= [Vector2(640,360), Vector2(1024,576), Vector2(1152,648),
 Vector2(1280,720), Vector2(1366,768), Vector2(1600,900), Vector2(1920,1080),
 Vector2(2560,1440), Vector2(3840,2160), Vector2(7680,4320)]

onready var settings:= {"Fullscreen":false, "Borderless":false,
 "Resolution":Vector2(640,360),
 "MasterVolumePercent":1, "EffectsVolumePercent":1, "MusicVolumePercent":1}
