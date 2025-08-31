extends Area2D
@export var shot_velocity := 0

func _physics_process(_delta):
	position += shot_velocity * Vector2.from_angle(rotation)
