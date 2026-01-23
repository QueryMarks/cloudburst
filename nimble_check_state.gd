extends NimbleIdleState
class_name NimbleCheckState

func enter():
	player.anim_play("nimble/nimble_check")
	
func _physics_process(_delta):
	if (abs(player.velocity.x) > 0):
		var old_sign = sign(player.velocity.x)
		player.velocity.x -= player.friction*(sign(player.velocity.x))*4
		if sign(player.velocity.x) != old_sign:
			player.velocity.x = 0
	if !player.is_on_floor():
		state_machine.change_state(NimbleFallState.new())
		
func _input(event):
	if event.is_action_pressed("jump"):
		state_machine.change_state(NimbleJumpState.new())
	elif event.is_action_pressed("shoot"):
		player.weapon.shoot()
	elif event.is_action_pressed("down"):
		state_machine.change_state(NimbleCheckState.new())
	elif (event.is_action_pressed("left") or event.is_action_pressed("right")):
		var lr_input = Input.get_axis("left", "right")
		if (lr_input != 0):
			player.check_flip()
			state_machine.change_state(NimbleWalkState.new())

func aim(ud_input):
	if player.aim != ud_input:
		if ud_input < 0:
			state_machine.change_state(NimbleIdleState.new())
		player.aim = ud_input
