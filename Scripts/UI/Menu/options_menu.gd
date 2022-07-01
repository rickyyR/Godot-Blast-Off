extends Control

onready var ResolutionDropdown:= get_node("HBoxContainer/ScreenOptions/ResolutionOptions")

func _ready() -> void:
	add_items_to_resolution_dropdown()
	$HBoxContainer/AudioOptions/MusicSlider.value = GlobalVariables.settings["MusicVolumePercent"]
	$HBoxContainer/AudioOptions/EffectsSlider.value = GlobalVariables.settings["EffectsVolumePercent"]
	$HBoxContainer/AudioOptions/MasterSlider.value = GlobalVariables.settings[ "MasterVolumePercent"]
	$HBoxContainer/ScreenOptions/CheckboxContainer/FullscreenCheckbox.pressed = GlobalVariables.settings["Fullscreen"]
	$HBoxContainer/ScreenOptions/CheckboxContainer/BoderlessCheckbox.pressed = GlobalVariables.settings["Borderless"]
	ResolutionDropdown.select(GlobalVariables.window_resolutions.find(GlobalVariables.settings["Resolution"]))
	
func add_items_to_resolution_dropdown():
	for resolution in GlobalVariables.window_resolutions:
		ResolutionDropdown.add_item(str(resolution))

func center_screen() -> void:
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
func _on_BackButton_pressed() -> void:
	SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")
	SavingSystem.save_data()

func _on_EffectsSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), linear2db(value))
	GlobalVariables.settings["EffectsVolumePercent"] = value

func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))
	GlobalVariables.settings["MusicVolumePercent"] = value

func _on_MasterSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
	GlobalVariables.settings["MasterVolumePercent"] = value

func _on_FullscreenCheckbox_toggled(button_pressed: bool) -> void:
	if button_pressed:
		OS.set_window_fullscreen(true)
		GlobalVariables.settings["Fullscreen"] = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		$HBoxContainer/ScreenOptions/CheckboxContainer/BoderlessCheckbox.disabled = true
		$HBoxContainer/ScreenOptions/ResolutionOptions.disabled = true
	else:
		OS.set_window_fullscreen(false)
		GlobalVariables.settings["Fullscreen"] = false
		OS.set_window_size(GlobalVariables.window_resolutions[ResolutionDropdown.selected])
		center_screen()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$HBoxContainer/ScreenOptions/CheckboxContainer/BoderlessCheckbox.disabled = false
		$HBoxContainer/ScreenOptions/ResolutionOptions.disabled = false

func _on_BoderlessCheckbox_toggled(button_pressed: bool) -> void:
	if button_pressed:
		OS.set_borderless_window(true)
		GlobalVariables.settings["Borderless"] = true
		center_screen()
	else:
		OS.set_borderless_window(false)
		GlobalVariables.settings["Borderless"] = false
		center_screen()

func _on_ResolutionOptions_item_selected(index: int) -> void:
	var current_selected = index
	var new_resolution = GlobalVariables.window_resolutions[index]
	OS.set_window_size(new_resolution)
	GlobalVariables.settings["Resolution"] = new_resolution
	center_screen()

func _on_DeleteSaveButton_pressed():
	if $HBoxContainer/SaveOptions/DeleteSaveCheckbox.pressed:
		SavingSystem.delete_all_data()
		get_tree().change_scene("res://Scenes/UI/Menu/MainMenu.tscn")

func _on_DeleteSaveCheckbox_toggled(button_pressed: bool) -> void:
	if button_pressed:
		$HBoxContainer/SaveOptions/DeleteSaveButton.disabled = false
	else:
		$HBoxContainer/SaveOptions/DeleteSaveButton.disabled = true
