class_name Idle
extends PlayerState

func enter(_msg := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	
	if player._velocity.x != 0:
		player._velocity.x = lerp(player._velocity.x, 0, 12 * _delta)
	
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
	
	# Exit
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {do_jump = true})
		
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.transition_to("Walk")
	
func get_class(): return "Idle"
