# CreditsScreen
extends Control

var is_scrolling_down:= true

func _ready() -> void:
	$ScrollContainer.get_v_scrollbar().modulate = Color(0, 0, 0, 0)
	$AnimationPlayer.play("scroll")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if is_scrolling_down:
		is_scrolling_down = false
		$AnimationPlayer.play_backwards("scroll")
	else:
		is_scrolling_down = true
		$AnimationPlayer.play("scroll")

func _on_BackButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI/Menu/MainMenu.tscn")
