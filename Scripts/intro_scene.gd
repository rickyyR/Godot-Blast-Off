# IntroScene
extends Node

# Currently the Scenes only purpose is to load saved data and apply it
func _ready() -> void:
	# Center Screen
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	# Load and apply settings then change Scene to MainMenu
	SavingSystem.load_data()
	apply_user_setting()
	get_tree().change_scene("res://Scenes/UI/Menu/MainMenu.tscn")

func apply_user_setting() -> void:
	var user_settings = GlobalVariables.settings
