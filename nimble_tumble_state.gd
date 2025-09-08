extends NimbleJumpState
class_name NimbleTumbleState

func enter():
	player.anim_play("nimble/nimble_tumble")

func _process(delta):
	super(delta)
	
func _physics_process(delta):
	super(delta)

func aim():
	var ud_input = Input.get_axis("up", "down")
	#if player.aim != ud_input:
	player.aim = ud_input

func exit():
	player.sprite.rotation = 0
