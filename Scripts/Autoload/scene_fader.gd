# SceneFader
extends Node2D

# Function used to transition between scenes,
# Will return false if scene could not be found
func transition_to(new_scene_path: String) -> bool:
	var file = File.new()
	if not file.file_exists(new_scene_path):
		return false
	else:
		$AnimationPlayer.play("Fade_to_black")
		yield($AnimationPlayer, "animation_finished")
		# TODO:
		# Check if scene has been loaded before fading to color
		get_tree().change_scene(new_scene_path)
		$AnimationPlayer.play_backwards("Fade_to_black")
		yield($AnimationPlayer, "animation_finished")
		return true
