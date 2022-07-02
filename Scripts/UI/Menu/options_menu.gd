extends Control

onready var ResolutionDropdown:= get_node("HBoxContainer/ScreenOptions/ResolutionOptions")
onready var MasterSlider:= get_node("HBoxContainer/AudioOptions/MasterSlider")
onready var MusicSlider:= get_node("HBoxContainer/AudioOptions/MusicSlider")
onready var EffectsSlider:= get_node("HBoxContainer/AudioOptions/EffectsSlider")
onready var FullscreenCheckbox:= get_node("HBoxContainer/ScreenOptions/CheckboxContainer/FullscreenCheckbox")
onready var BorderlessCheckbox:= get_node("HBoxContainer/ScreenOptions/CheckboxContainer/BoderlessCheckbox")
onready var DeleteSaveCheckbox:= get_node("HBoxContainer/SaveOptions/DeleteSaveCheckbox")
onready var DeleteSaveButton:= get_node("HBoxContainer/SaveOptions/DeleteSaveButton")

func _ready() -> void:
	add_items_to_resolution_dropdown()
	MasterSlider.value = GlobalVariables.settings[ "MasterVolumePercent"]
	MusicSlider.value = GlobalVariables.settings["MusicVolumePercent"]
	EffectsSlider.value = GlobalVariables.settings["EffectsVolumePercent"]
	FullscreenCheckbox.pressed = GlobalVariables.settings["Fullscreen"]
	BorderlessCheckbox.pressed = GlobalVariables.settings["Borderless"]
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
		BorderlessCheckbox.disabled = true
		ResolutionDropdown.disabled = true
	else:
		OS.set_window_fullscreen(false)
		GlobalVariables.settings["Fullscreen"] = false
		OS.set_window_size(GlobalVariables.window_resolutions[ResolutionDropdown.selected])
		center_screen()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		BorderlessCheckbox.disabled = false
		ResolutionDropdown.disabled = false

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
	var new_resolution = GlobalVariables.window_resolutions[index]
	OS.set_window_size(new_resolution)
	GlobalVariables.settings["Resolution"] = new_resolution
	center_screen()

func _on_DeleteSaveButton_pressed():
	if DeleteSaveCheckbox.pressed:
		SavingSystem.delete_all_data()
		var _ok = get_tree().change_scene("res://Scenes/UI/Menu/MainMenu.tscn")

func _on_DeleteSaveCheckbox_toggled(button_pressed: bool) -> void:
	if button_pressed:
		DeleteSaveButton.disabled = false
	else:
		DeleteSaveButton.disabled = true
