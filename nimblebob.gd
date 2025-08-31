extends Sprite2D
@export var target : Node2D
@export var speed := 0.3

func _physics_process(_delta):
	global_position = global_position.move_toward(target.global_position, clampf(speed*abs(global_position.distance_to(target.global_position)), 0, 100))
