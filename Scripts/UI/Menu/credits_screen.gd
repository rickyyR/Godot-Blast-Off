# CreditsScreen
extends Control

var _is_scrolling_down:= true

onready var _ScrollContainer:= get_node("ScrollContainer")
onready var _AnimationPlayer:= get_node("AnimationPlayer")

func _ready() -> void:
	# Make scrollbar invisible
	_ScrollContainer.get_v_scrollbar().modulate = Color(0, 0, 0, 0)
	_AnimationPlayer.play("scroll")

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	# AnimationPlayer will switch between scroll directions automatically
	if _is_scrolling_down:
		_is_scrolling_down = false
		_AnimationPlayer.play_backwards("scroll")
	else:
		_is_scrolling_down = true
		_AnimationPlayer.play("scroll")

func _input(event):
	# Any key/button event will transition back to main menu
	if event is InputEventKey or event is InputEventMouseButton:
		SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")
