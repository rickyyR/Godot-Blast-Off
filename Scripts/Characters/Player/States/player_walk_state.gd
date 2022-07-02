class_name Walk
extends PlayerState

var has_hangtime

func enter(_msg := {}) -> void:
	has_hangtime = true

func physics_update(_delta: float) -> void:
	
	if not player.is_on_floor():
		coyote_time()
		if Input.is_action_just_pressed("jump") and has_hangtime:
			state_machine.transition_to("Jump", {do_jump = true})
		elif not has_hangtime:
			state_machine.transition_to("Jump")
	
	# Left/Right movement
	if Input.is_action_pressed("right"):
		if player._velocity.x != player._speed.x:
			player._velocity.x = lerp(player._velocity.x, player._speed.x, 10 * _delta)
	elif Input.is_action_pressed("left"):
		if player._velocity.x != -player._speed.x:
			player._velocity.x = lerp(player._velocity.x, -player._speed.x, 10 * _delta)
			
	# Exit
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {do_jump = true})
	elif not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		state_machine.transition_to("Idle")
		
func get_class(): return "Walk"

func coyote_time():
	yield(get_tree().create_timer(0.1), "timeout")
	has_hangtime = false
