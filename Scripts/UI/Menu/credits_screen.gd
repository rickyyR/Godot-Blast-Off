# CreditsScreen
extends Control

var is_scrolling_down:= true

func _ready() -> void:
	# Make scrollbar invisible
	$ScrollContainer.get_v_scrollbar().modulate = Color(0, 0, 0, 0)
	$AnimationPlayer.play("scroll")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	# AnimationPlayer will switch between scroll directions automatically
	if is_scrolling_down:
		is_scrolling_down = false
		$AnimationPlayer.play_backwards("scroll")
	else:
		is_scrolling_down = true
		$AnimationPlayer.play("scroll")

func _unhandled_input(event):
	# Any input event will transition back to main menu
	if event:
		SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")
