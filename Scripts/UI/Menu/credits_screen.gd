# CreditsScreen
extends Control

var is_scrolling_down:= true

onready var _ScrollContainer:= get_node("ScrollContainer")
onready var _AnimationPlayer:= get_node("AnimationPlayer")

func _ready() -> void:
	# Make scrollbar invisible
	_ScrollContainer.get_v_scrollbar().modulate = Color(0, 0, 0, 0)
	_AnimationPlayer.play("scroll")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	# AnimationPlayer will switch between scroll directions automatically
	if is_scrolling_down:
		is_scrolling_down = false
		_AnimationPlayer.play_backwards("scroll")
	else:
		is_scrolling_down = true
		_AnimationPlayer.play("scroll")

func _unhandled_input(event):
	# Any event will transition back to main menu (does not work for mouse atm)
	if event:
		SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")
