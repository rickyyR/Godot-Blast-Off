# Template class for Level
class_name Level
extends Node2D

# Override get_class to make it easy to determine if the current scene is a level
# For example the Pause menu should only be called inside a level
# Using Groups is a good alternative option
func get_class() -> String:
	return "Level"
