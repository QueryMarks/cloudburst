extends State
class_name NimbleIdleState


func enter():
	if player.aim >= 0:
		player.anim_play("nimble/nimble_idle")
	elif player.aim < 0:
		player.anim_play("nimble/nimble_idle_up")
	
func _input(event):
	if event.is_action_pressed("jump"):
		state_machine.change_state(NimbleJumpState.new())
	elif event.is_action_pressed("shoot"):
		player.weapon.shoot()

func _process(_delta):
	var ud_input = Input.get_axis("up", "down")
	if ud_input <= 0:
		aim(ud_input)
func _physics_process(_delta):
	var lr_input = Input.get_axis("left", "right")
	if (lr_input != 0):
		player.check_flip()
		player.move_and_slide()
		state_machine.change_state(NimbleWalkState.new())
	if (abs(player.velocity.x) > 0):
		var old_sign = sign(player.velocity.x)
		player.velocity.x -= player.friction*(sign(player.velocity.x))
		if sign(player.velocity.x) != old_sign:
			player.velocity.x = 0
		player.move_and_slide()
	if !player.is_on_floor():
		state_machine.change_state(NimbleFallState.new())

func aim(ud_input):
	if player.aim != ud_input:
		var anim_pos = player.anim_player.current_animation_position
		if ud_input < 0:
			player.anim_play("nimble/nimble_idle_up")
		elif ud_input == 0:
			player.anim_play("nimble/nimble_idle")
		player.anim_player.seek(anim_pos)
		player.aim = ud_input
