class_name Player
extends KinematicBody2D

var _velocity:= Vector2.ZERO
var _speed:= Vector2(180,-312)
var _has_doublejump:= true

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if _velocity.y < 600:
		_velocity.y = lerp(_velocity.y, 600, GlobalVariables.GRAVITY * delta)
	_velocity = move_and_slide(_velocity, Vector2.UP)
