# PauseMenu
# This will be active and hidden, waiting for the "ui_cancel" input action
# On show it will pause the Engine, if you wish to change this you can remove
# the Engine.time_scale calls from show() and hide()
extends CanvasLayer

var _visible:= false
onready var _Buttons:= get_node("Buttons")
onready var _Background:= get_node("Background")

func _on_ResumeButton_pressed():
	hide()

func _on_RestartButton_pressed():
	var _ok = get_tree().reload_current_scene()
	hide()

func _on_QuitButton_pressed():
	hide()
	SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")

func _unhandled_input(event):
	if (event.is_action_pressed("ui_cancel") and not
	 _visible and get_tree().current_scene.get_class() == "Level"):
		show()
	elif event.is_action_pressed("ui_cancel") and _visible:
		hide()
		
func show() -> void:
	Engine.time_scale = 0
	_Background.visible = true
	_Buttons.visible = true
	_visible = true
	
func hide() -> void:
	Engine.time_scale = 1
	_Background.visible = false
	_Buttons.visible = false
	_visible = false
