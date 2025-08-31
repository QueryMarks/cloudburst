extends NimbleJumpState
class_name NimbleFallState

func enter():
	player.anim_play("nimble/nimble_jump")

	
func _physics_process(_delta):
	super(_delta)
