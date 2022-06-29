# OptionsMenu
extends Control

func _on_BackButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI/Menu/MainMenu.tscn")
