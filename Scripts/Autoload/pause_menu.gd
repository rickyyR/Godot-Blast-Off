# PauseMenu
extends CanvasLayer

var visible:= false
onready var Buttons:= get_node("Buttons")
onready var Background:= get_node("Background")

func _on_ResumeButton_pressed():
	hide()

func _on_RestartButton_pressed():
	var _ok = get_tree().reload_current_scene()
	hide()

func _on_QuitButton_pressed():
	hide()
	SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and not visible and get_tree().current_scene.get_class() == "Level":
		show()
	elif event.is_action_pressed("ui_cancel") and visible:
		hide()
		
func show() -> void:
	Engine.time_scale = 0
	Background.visible = true
	Buttons.visible = true
	visible = true
	
func hide() -> void:
	Engine.time_scale = 1
	Background.visible = false
	Buttons.visible = false
	visible = false
