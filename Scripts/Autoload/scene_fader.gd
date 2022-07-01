# SceneFader
extends Node2D

onready var _AnimationPlayer:= get_node("AnimationPlayer")

# Function used to transition between scenes,
# Will return false if scene could not be found
func transition_to(new_scene_path: String) -> bool:
	var file = File.new()
	if not file.file_exists(new_scene_path):
		return false
	else:
		_AnimationPlayer.play("Fade_to_black")
		yield(_AnimationPlayer, "animation_finished")
		var ok = get_tree().change_scene(new_scene_path)
		if not ok:
			return ok
		_AnimationPlayer.play_backwards("Fade_to_black")
		yield(_AnimationPlayer, "animation_finished")
		return ok
