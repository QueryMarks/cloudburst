extends State
class_name NimbleJumpState

func enter():
	var ud_input = Input.get_axis("up", "down")
	if ud_input < 0:
		player.anim_play("nimble/nimble_jump_up")
	elif ud_input > 0:
		player.anim_play("nimble/nimble_jump_down")
	elif ud_input == 0:
		player.anim_play("nimble/nimble_jump")
	player.aim = ud_input
	player.velocity.y = player.jump_speed

func _input(event):
	if event.is_action_pressed("shoot"):
		player.weapon.air_shoot()
	
func _physics_process(_delta):
	var lr_input = Input.get_axis("left", "right")
	if (lr_input != 0):
		player.check_flip()
		var lr_dir = sign(lr_input)
		if lr_dir * player.velocity.x > player.air_speed:
			pass
		#elif player.velocity.x + lr_dir * player.air_accel >= lr_dir * player.air_speed:
			#player.velocity.x = lr_dir * player.air_speed
		else:
			player.velocity.x += lr_dir * player.air_accel
	if (abs(player.velocity.x) > 0):
		var old_sign = sign(player.velocity.x)
		player.velocity.x -= player.air_friction*(sign(player.velocity.x))
		if sign(player.velocity.x) != old_sign:
			player.velocity.x = 0
	var gravity = player.get_gravity()
	if Input.is_action_pressed("jump"):
		gravity = gravity/2
	if (player.velocity.y + gravity.y <= player.max_fallspeed):
		player.velocity += gravity
	elif (player.velocity.y < player.max_fallspeed):
		player.velocity.y = player.max_fallspeed

	if player.is_on_floor():
		if (lr_input != 0):
			state_machine.change_state(NimbleWalkState.new())
		else:
			state_machine.change_state(NimbleIdleState.new())
			
func _process(_delta):
	aim()
func aim():
	var ud_input = Input.get_axis("up", "down")
	#if player.aim != ud_input:
	var anim_pos = player.anim_player.current_animation_position
	if ud_input < 0:
		player.anim_play("nimble/nimble_jump_up")
	elif ud_input > 0:
		player.anim_play("nimble/nimble_jump_down")
	elif ud_input == 0:
		player.anim_play("nimble/nimble_jump")
	player.anim_player.seek(anim_pos)
	player.aim = ud_input
