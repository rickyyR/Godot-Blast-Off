# IntroScene
extends Node

func _ready() -> void:
	$AnimationPlayer.play("Intro_animation")
	yield($AnimationPlayer, "animation_finished")
	var _ok = get_tree().change_scene("res://Scenes/UI/Menu/MainMenu.tscn")

func _unhandled_input(event):
	# Any key will skip to main menu 
	if event is InputEventKey:
		SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")
