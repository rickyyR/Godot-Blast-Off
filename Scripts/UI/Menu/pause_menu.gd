# PauseMenu
extends CanvasLayer

var visible:= false

func _on_ResumeButton_pressed():
	hide()

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
	hide()

func _on_QuitButton_pressed():
	hide()
	SceneFader.transition_to("res://Scenes/UI/Menu/MainMenu.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and not visible:
		show()
	elif event.is_action_pressed("ui_cancel") and visible:
		hide()
		
func show() -> void:
	$Background.visible = true
	$Buttons.visible = true
	visible = true
	
func hide() -> void:
	$Background.visible = false
	$Buttons.visible = false
	visible = false
