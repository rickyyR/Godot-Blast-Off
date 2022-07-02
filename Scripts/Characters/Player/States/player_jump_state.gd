class_name Jump
extends PlayerState

var jump_buffer = false
var is_double_jumping = false
var elapsed = 0.0

func enter(_msg := {}) -> void:
	if _msg.has("do_jump"):
		player._velocity.y = player._speed.y

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		jump_buffer = true
		jump_buffer_timer()
	if Input.is_action_just_released("jump") and player._velocity.y < 0:
		player._velocity.y = lerp(player._velocity.y,0, 0.5)
	# Left/Right movement
	if Input.is_action_pressed("right"):
			if player._velocity.x != player._speed.x:
				player._velocity.x = lerp(player._velocity.x, player._speed.x, 10 * _delta)
	elif Input.is_action_pressed("left"):
		if player._velocity.x != -player._speed.x:
			player._velocity.x = lerp(player._velocity.x, -player._speed.x, 10 * _delta)
	elif not Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		if player._velocity.x != 0:
			player._velocity.x = lerp(player._velocity.x, 0, 7 * _delta)
	if Input.is_action_pressed("down"):
		player._velocity.y += 20

	if player.is_on_floor():
		player._has_doublejump = true
		if jump_buffer:
			player._velocity.y = player._speed.y
		elif Input.is_action_just_pressed("jump"):
			player._velocity.y = player._speed.y
		elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			state_machine.transition_to("Walk")
		else:
			state_machine.transition_to("Idle")
			
func get_class(): return "Jump"

func jump_buffer_timer():
	yield(get_tree().create_timer(0.1), "timeout")
	jump_buffer = false
	
