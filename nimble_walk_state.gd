extends State
class_name NimbleWalkState


func enter():
	if player.aim >= 0:
		player.anim_play("nimble/nimble_walk")
	elif player.aim < 0:
		player.anim_play("nimble/nimble_walk_up")
	
func _input(event):
	if event.is_action_pressed("jump"):
		state_machine.change_state(NimbleJumpState.new())
	elif event.is_action_pressed("shoot"):
		player.weapon.shoot()

func _physics_process(_delta):
	#if Input.is_action_pressed("right") and !Input.is_action_pressed("left"):
		#if player.velocity.x > player.walk_speed:
			#pass
		#elif player.velocity.x + player.walk_accel >= player.walk_speed:
			#player.velocity.x = player.walk_speed
		#else:
			#player.velocity.x += player.walk_accel
		#player.move_and_slide()
	#elif Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		#if player.velocity.x < -player.walk_speed:
			#pass
		#elif player.velocity.x - player.walk_accel <= -player.walk_speed:
			#player.velocity.x = -player.walk_speed
		#else:
			#player.velocity.x -= player.walk_accel
	var lr_input = Input.get_axis("left", "right")
	if (lr_input != 0):
		player.check_flip()
		var lr_dir = sign(lr_input)
		if lr_dir * player.velocity.x > player.walk_speed:
			pass
		elif lr_dir * player.velocity.x + lr_dir * player.walk_accel >= lr_dir * player.walk_speed:
			player.velocity.x = lr_dir * player.walk_speed
		else:
			player.velocity.x += lr_dir * player.walk_accel
		var ud_input = Input.get_axis("up", "down")
		aim(ud_input)
		if !player.is_on_floor():
			state_machine.change_state(NimbleFallState.new())
		
	else:
		if !player.is_on_floor():
			state_machine.change_state(NimbleFallState.new())
		else:
			state_machine.change_state(NimbleIdleState.new())
			
func aim(ud_input):
	if player.aim != ud_input:
		var anim_pos = player.anim_player.current_animation_position
		if ud_input < 0:
			player.anim_play("nimble/nimble_walk_up")
		elif ud_input == 0:
			player.anim_play("nimble/nimble_walk")
		player.anim_player.seek(anim_pos)
		player.aim = ud_input
