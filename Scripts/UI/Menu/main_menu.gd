# MainMenu
extends Control

func _on_StartButton_pressed() -> void:
	SceneFader.transition_to("res://Scenes/Game/Level/Level1.tscn")

func _on_OptionsButton_pressed() -> void:
	SceneFader.transition_to("res://Scenes/UI/Menu/OptionsMenu.tscn")

func _on_CreditsButton_pressed() -> void:
	SceneFader.transition_to("res://Scenes/UI/Menu/CreditsScreen.tscn")

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
